(define-module (nmeum services networking)
  #:use-module (nmeum packages networking)
  #:use-module (guix gexp)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages dns)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module ((srfi srfi-1) #:select (concatenate))
  #:use-module ((srfi srfi-13) #:select (string-join))
  #:use-module ((srfi srfi-26) #:select (cut))

  #:export (unbound-service-type
            unbound-configuration
            unbound-configuration
            unbound-server
            unbound-zone
            unbound-remote

            dhcpcd-service-type
            dhcpcd-configuration
            dhcpcd-configuration?
            dhcpcd-configuration-interfaces
            dhcpcd-configuration-options))

;;
;; Unbound
;;

(define (unbound-serialize-field field-name value)
  (let ((field (object->string field-name))
        (value (cond
                 ((boolean? value) (if value "yes" "no"))
                 ((string? value) value)
                 (else (object->string value)))))
    (if (string=? field "extra-content")
      #~(string-append #$value "\n")
      #~(format #f "	~a: ~s~%" #$field #$value))))

(define (unbound-serialize-alist field-name value)
  #~(string-append #$@(generic-serialize-alist list
                                               unbound-serialize-field
                                               value)))

(define (unbound-serialize-section section-name value fields)
  #~(format #f "~a:~%~a"
            #$(object->string section-name)
            #$(serialize-configuration value fields)))

(define unbound-serialize-string unbound-serialize-field)
(define unbound-serialize-boolean unbound-serialize-field)

(define-maybe string (prefix unbound-))
(define-maybe list-of-strings (prefix unbound-))
(define-maybe boolean (prefix unbound-))

(define (unbound-serialize-list-of-strings field-name value)
  #~(string-append #$@(map (cut unbound-serialize-string field-name <>) value)))

(define-configuration unbound-zone
  (name
    string
    "Zone name.")

  (forward-addr
    maybe-list-of-strings
    "IP address of server to forward to.")

  (forward-tls-upstream
    maybe-boolean
    "Whether the queries to this forwarder use TLS for transport.")

  (extra-options
   (alist '())
   "An association list of options to append.")

  (prefix unbound-))

(define (unbound-serialize-unbound-zone field-name value)
  (unbound-serialize-section field-name value unbound-zone-fields))

(define (unbound-serialize-list-of-unbound-zone field-name value)
  #~(string-append #$@(map (cut unbound-serialize-unbound-zone field-name <>)
                           value)))

(define list-of-unbound-zone? (list-of unbound-zone?))

(define-configuration unbound-remote
  (control-enable
    maybe-boolean
    "Enable remote control.")

  (control-interface
    maybe-string
    "IP address or local socket path to listen on for remote control.")

  (extra-options
   (alist '())
   "An association list of options to append.")

  (prefix unbound-))

(define (unbound-serialize-unbound-remote field-name value)
  (unbound-serialize-section field-name value unbound-remote-fields))

(define-configuration unbound-server
  (interface
    maybe-list-of-strings
    "Interfaces listened on for queries from clients.")

  (hide-version
    maybe-boolean
    "Refuse the version.server and version.bind queries.")

  (hide-identity
    maybe-boolean
    "Refuse the id.server and hostname.bind queries.")

  (tls-cert-bundle
    maybe-string
    "Certificate bundle file, used for DNS over TLS.")

  (extra-options
   (alist '())
   "An association list of options to append.")

  (prefix unbound-))

(define (unbound-serialize-unbound-server field-name value)
  (unbound-serialize-section field-name value unbound-server-fields))

(define-configuration unbound-configuration
  (server
    (unbound-server
      (unbound-server
        (interface '("127.0.0.1" "::1"))

        (hide-version #t)
        (hide-identity #t)

        (tls-cert-bundle "/etc/ssl/certs/ca-certificates.crt")))
    "General options for the Unbound server.")

  (remote-control
    (unbound-remote
      (unbound-remote
        (control-enable #t)
        (control-interface "/run/unbound.sock")))
    "Remote control options for the daemon.")

  (forward-zone
    (list-of-unbound-zone '())
    "A zone for which queries should be forwarded to another resolver.")

  (extra-content
    maybe-string
    "Raw content to add to the configuration file.")

  (prefix unbound-))

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
            (requirement '(user-processes))
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
         (shell (file-append shadow "/sbin/nologin")))))

(define unbound-service-type
  (service-type (name 'unbound)
                (description "Run the Unbound DNS resolver.")
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

(define-maybe list)

;; Ensure that strings within the unbound configuration
;; are not enclosed in double quotes by the serialization.
(define (->string obj)
  (if (string? obj)
    obj
    (object->string obj)))

(define (serialize-list-of-opts field-name lst)
  #~(string-append
      (string-join
        (list
          #$@(map
               (lambda (lst)
                 (string-join (map ->string lst) " "))
               lst)) "\n") "\n"))

(define (list-of-opts? lst)
  (list? lst))

(define-configuration dhcpcd-configuration
  (interfaces
    maybe-list
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
  (let* ((config-file (dhcpcd-config-file config))
         (interfaces (dhcpcd-configuration-interfaces config)))
    (list (shepherd-service
            (documentation "dhcp daemon.")
            (provision '(networking))
            (requirement '(user-processes udev))
            (actions (list (shepherd-configuration-action config-file)))
            (start #~(lambda _
                       ;; When invoked without any arguments, the client discovers all
                       ;; non-loopback interfaces *that are up*.  However, the relevant
                       ;; interfaces are typically down at this point.  Thus we perform
                       ;; our own interface discovery here.
                       ;;
                       ;; Taken from the `dhcp-client-shepherd-service`.
                       (define valid?
                         (lambda (interface)
                           (and (arp-network-interface? interface)
                                (not (loopback-network-interface? interface))
                                ;; XXX: Make sure the interfaces are up so that
                                ;; 'dhclient' can actually send/receive over them.
                                ;; Ignore those that cannot be activated.
                                (false-if-exception
                                  (set-network-interface-up interface)))))
                       (define ifaces
                         (filter valid?
                                 #$(if (maybe-value-set? interfaces)
                                     #~'#$interfaces
                                     #~(all-network-interface-names))))

                       (fork+exec-command
                         (cons* (string-append #$dhcpcd "/sbin/dhcpcd")
                                "-q" "-q" "-B" "-f" #$config-file ifaces))))
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
