(define-module (8pit services networking)
  #:use-module (guix gexp)
  #:use-module (gnu packages dns)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module ((srfi srfi-1) #:select (concatenate)))

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
                             (object->string (cdr pair))
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
