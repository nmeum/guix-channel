(define-module (nmeum services web)
  #:use-module (nmeum packages misc)
  #:use-module (guix gexp)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages dav)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services mail)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services web)
  #:use-module (gnu system accounts)
  #:use-module (gnu system shadow)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26))

(define (webdav-server-shepherd-service args)
  (list (shepherd-service
          (documentation "webdav-server daemon.")
          (provision '(webdav-server))
          ;; webdav-server may be bound to a particular IP address, hence
          ;; only start it after the networking service has started.
          (requirement '(user-processes networking))
          (start #~(make-forkexec-constructor
                     (list (string-append #$webdav-server "/bin/webdav-server")
                           #$@args)
                     #:user "webdav-server" #:group "webdav-server"))
          (stop #~(make-kill-destructor)))))

(define webdav-server-account-service
  (list (user-group (name "webdav-server") (system? #t))
        (user-account
         (name "webdav-server")
         (group "webdav-server")
         (system? #t)
         (comment "webdav-server daemon user")
         (home-directory "/var/empty")
         (shell (file-append shadow "/sbin/nologin")))))

(define-public webdav-server-service-type
  (service-type (name 'webdav-server)
                (description "Run the WebDAV server.")
                (extensions
                  (list (service-extension account-service-type
                                           (const webdav-server-account-service))
                        (service-extension shepherd-root-service-type
                                           webdav-server-shepherd-service)))
                (compose concatenate)
                (default-value '())))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; XXX: This is hopefully a temporary hack until we come up with a better way
;; of using gunicorn-service-type with existing WSGI application services.
;;
;; See <https://codeberg.org/guix/guix/issues/8185>

(define serialize-radicale-configuration
  (@@ (gnu services mail) serialize-radicale-configuration))

(define radicale-accounts
  (@@ (gnu services mail) %radicale-accounts))

(define radicale-activation
  (@@ (gnu services mail) radicale-activation))

(define-public radicale-gunicorn-service-type
  (service-type
   (name 'radicale-gunicorn)
   (description "Run Radicale via the gunicorn WSGI server.")
   (extensions
    (list (service-extension
            gunicorn-service-type
            (lambda (conf)
              (let ((cfg (serialize-radicale-configuration conf)))
                (list (gunicorn-app
                        (name "radicale")
                        (package radicale)
                        (wsgi-app-module "radicale")
                        ;;(sockets '("127.0.0.1:8080"))
                        (user "radicale")
                        (group "radicale")
                        (environment-variables
                          (list (cons "RADICALE_CONFIG" cfg))))))))
          (service-extension account-service-type (const radicale-accounts))
          (service-extension activation-service-type radicale-activation)))
   (default-value (radicale-configuration))))
