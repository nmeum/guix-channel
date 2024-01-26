(define-module (nmeum services networking)
  #:use-module (nmeum packages networking)
  #:use-module (guix gexp)
  #:use-module (gnu packages dns)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module ((srfi srfi-1) #:select (concatenate))
  #:use-module ((srfi srfi-13) #:select (string-join))

  #:export (unbound-service-type
            unbound-configuration
            unbound-configuration?
            unbound-configuration-server
            unbound-configuration-remote-control
            unbound-configuration-forward-zone
            unbound-configuration-stub-zone
            unbound-configuration-auth-zone
            unbound-configuration-view
            unbound-configuration-python
            unbound-configuration-dynlib

            dhcpcd-service-type
            dhcpcd-configuration
            dhcpcd-configuration?
            dhcpcd-options))

;; Ensure that strings within the unbound configuration
;; are not enclosed in double quotes by the serialization.
(define (->string obj)
  (if (string? obj)
    obj
    (object->string obj)))

;;
;; Unbound
;;

(define-maybe list)

(define (serialize-list field-name lst)
  #~(string-append
      #$(string-append (symbol->string field-name) ":\n")
      #$(apply string-append
          (map
            (lambda (pair)
              (string-append "\t"
                             (symbol->string (car pair))
                             ": "
                             (->string (cdr pair))
                             "\n"))
            lst))))

(define-configuration unbound-configuration
  (server
    (maybe-list '((interface . "127.0.0.1")
                  (interface . "::1")

                  ;; TLS certificate bundle for DNS over TLS.
                  (tls-cert-bundle . "/etc/ssl/certs/ca-certificates.crt")

                  (hide-identity . yes)
                  (hide-version . yes)))
    "The server section of the configuration.")
  (remote-control
    (maybe-list '((control-enable . yes)
                  (control-interface . "/run/unbound.sock")))
    "Configuration of the remote control facility.")
  (forward-zone
    maybe-list
    "Configuration of nameservers to forward queries to.")
  (stub-zone
    maybe-list
    "Configuration of stub zones.")
  (auth-zone
    maybe-list
    "Zones for which unbound should response as an authority server.")
  (view
    maybe-list
    "Configuration of view clauses.")
  (python
    maybe-list
    "Configuration of the Python module.")
  (dynlib
    maybe-list
    "Dynamic library module configuration."))

(define (unbound-config-file config)
  (mixed-text-file "unbound.conf"
    (serialize-configuration
      config
      unbound-configuration-fields)))

(define (unbound-shepherd-service config)
  (let ((config-file (unbound-config-file config)))
    (list (shepherd-service
            (documentation "Unbound daemon.")
            (provision '(unbound dns))
            (requirement '(networking))
            (actions (list (shepherd-configuration-action config-file)))
            (start #~(make-forkexec-constructor
                       (list (string-append #$unbound "/sbin/unbound")
                             "-d" "-p" "-c" #$config-file)))
            (stop #~(make-kill-destructor))))))

(define unbound-account-service
  (list (user-group (name "unbound") (system? #t))
        (user-account
         (name "unbound")
         (group "unbound")
         (system? #t)
         (comment "Unbound daemon user")
         (home-directory "/var/empty")
         (shell "/run/current-system/profile/sbin/nologin"))))

(define unbound-service-type
  (service-type (name 'unbound)
                (description "Run the unbound DNS resolver.")
                (extensions
                  (list (service-extension account-service-type
                                           (const unbound-account-service))
                        (service-extension shepherd-root-service-type
                                           unbound-shepherd-service)))
                (compose concatenate)
                (default-value (unbound-configuration))))

;;
;; dhcpcd
;;

(define (serialize-list-of-opts field-name lst)
  #~(string-join
      (list
        #$@(map
             (lambda (lst)
               (string-join (map ->string lst) " "))
             lst)) "\n"))

(define (list-of-opts? lst)
  (list? lst))

(define-configuration dhcpcd-configuration
  (interfaces
    list
    "List of interfaces to start a DHCP client for."
    empty-serializer)
  (options
    ;; Replicate the default dhcpcd configuration file.
    ;; See: https://github.com/NetworkConfiguration/dhcpcd#configuration
    (list-of-opts '((hostname)
                    (duid)
                    (persistent)
                    (option rapid_commit)
                    (option interface_mtu)
                    (require dhcp_server_identifier)
                    (slaac private)))
    "List of configuration options for dhcpcd."))

(define (dhcpcd-config-file config)
  (mixed-text-file "dhcpcd.conf"
    (serialize-configuration
      config
      dhcpcd-configuration-fields)))

(define dhcpcd-account-service
  (list (user-group (name "dhcpcd") (system? #t))
        (user-account
          (name "dhcpcd")
          (group "dhcpcd")
          (system? #t)
          (comment "dhcpcd daemon user")
          (home-directory "/var/empty")
          (shell "/run/current-system/profile/sbin/nologin"))))

(define (dhcpcd-shepherd-service config)
  (let ((config-file (dhcpcd-config-file config))
        (interfaces  (dhcpcd-configuration-interfaces config)))
    (list (shepherd-service
            (documentation "dhcp daemon.")
            (provision '(networking))
            (requirement '())
            (actions (list (shepherd-configuration-action config-file)))
            (start #~(make-forkexec-constructor
                       ;; TODO: Determine available interfaces?
                       (list (string-append #$dhcpcd "/sbin/dhcpcd")
                              "-B" "-f" #$config-file #$@interfaces)))
            (stop #~(make-kill-destructor))))))

(define dhcpcd-service-type
  (service-type (name 'dhcpcd)
                (description "Run the dhcpcd daemon.")
                (extensions
                 (list (service-extension account-service-type
                                          (const dhcpcd-account-service))
                       (service-extension shepherd-root-service-type
                                          dhcpcd-shepherd-service)))
                (compose concatenate)
                (default-value (dhcpcd-configuration))))
