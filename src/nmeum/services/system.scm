(define-module (nmeum services system)
  #:use-module (nmeum packages desktop)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu system pam)

  #:export (login-xdg-runtime-service-type))

;; Hack to extract the login-pam-service from (gnu services base).
(define login-pam-service (@@ (gnu services base) login-pam-service))

;; Utility method for unioning multiple PAM services.
(define (pam-service-union name lst)
  (define (%pam-service-union s1 s2)
    (pam-service (name name)
                 (account (append (pam-service-account s1)
                                  (pam-service-account s2)))
                 (auth (append (pam-service-auth s1)
                               (pam-service-auth s2)))
                 (password (append (pam-service-password s1)
                                   (pam-service-password s2)))
                 (session (append (pam-service-session s1)
                                  (pam-service-session s2)))))

  (apply %pam-service-union lst))

;; Custom variant of the login-pam-service procedure from the
;; `gnu/services/base.scm` file in the Guix repository.
(define (login-xdg-runtime-pam-service config)
  (define dumb-dir-pam-service
    (let* ((module "/lib/security/pam_dumb_runtime_dir.so")
           (dumb-dir (pam-entry (control "optional")
                                (module (file-append dumb-runtime-dir module)))))
      (pam-service (name "dumb-dir")
                   (session (list dumb-dir)))))

  (list
    (pam-service-union
      "login"
      (append
        (login-pam-service config)
        (list dumb-dir-pam-service)))))

;; Provides a custom variant of the login-service-type from the
;; `gnu/services/base.scm` file.  This custom services supports
;; the dumb-runtime-dir PAM module to setup a XDG_RUNTIME_DIR.
;;
;; TODO: Find a better way to extend the login-service-type
;;       and propose that upstream.
(define login-xdg-runtime-service-type
  (service-type (name 'login)
                (extensions (list (service-extension pam-root-service-type
                                   login-xdg-runtime-pam-service)))
                (default-value (login-configuration))
                (description
                 "Custom login service integrated with dumb-runtime-dir.")))
