(define-module (nmeum services web)
  #:use-module (nmeum packages misc)
  #:use-module (guix gexp)
  #:use-module (gnu packages admin)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services shepherd)
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
