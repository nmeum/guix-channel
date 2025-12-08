(define-module (nmeum services web)
  #:use-module (nmeum packages misc)
  #:use-module (guix gexp)
  #:use-module (gnu packages admin)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module (gnu system accounts)
  #:use-module (gnu system shadow)
  #:use-module (srfi srfi-1))

(define (sogogi-serialize-field field-name value)
  #~(format #f "	~a: ~s~%" #$field #$value))

(define sogogi-serialize-string sogogi-serialize-field)
(define sogogi-serialize-boolean sogogi-serialize-field)

(define-maybe string (prefix sogogi-))
(define-maybe list-of-strings (prefix sogogi-))
(define-maybe boolean (prefix sogogi-))

(define-configuration sogogi-user
  (name
    maybe-string
    "Name of the user.")

  (password
    maybe-string
    "Password of the user.")

  (prefix sogogi-))

(define-configuration sogogi-location
  (path
    string
    "HTTP path at which the directory will be exposed.")

  (dir
    string
    "Path to local directory to serve.")

  (grant
    maybe-list-of-strings
    "Grant remote users access to the directory.")

  (prefix sogogi-))

(define (sogogi-serialize-list-of-sogogi-location field-name value)
  #~(format #f "	~a: ~s~%" #$field #$value))

(define (sogogi-serialize-list-of-sogogi-user field-name value)
  #~(format #f "	~a: ~s~%" #$field #$value))

(define list-of-sogogi-user? (list-of sogogi-user?))
(define list-of-sogogi-location? (list-of sogogi-location?))

(define-configuration sogogi-configuration
  (listen
    (string "localhost:8080")
    "Listening address.")

  (locations
    (list-of-sogogi-location '())
    "Local directories to expose via a HTTP path")

  (users
    (list-of-sogogi-user '())
    "Users with access to the location.")

  (prefix sogogi-))

(define (sogogi-serialize-sogogi-configuration field-name value)
  (error "here"))

(define (sogogi-config-file config)
  (mixed-text-file "sogogi.conf"
    (serialize-configuration
      config
      sogogi-configuration-fields)))

(define (sogogi-shepherd-service config)
  (let ((config-file (sogogi-config-file config)))
    (list (shepherd-service
            (documentation "Sogogi daemon.")
            (provision '(sogogi))
            ;; sogogi may be bound to a particular IP address, hence
            ;; only start it after the networking service has started.
            (requirement '(user-processes networking))
            (actions (list (shepherd-configuration-action config-file)))
            (start #~(make-forkexec-constructor
                       (list (string-append #$sogogi "/bin/sogogi")
                             "-config" #$config-file)))
            (stop #~(make-kill-destructor))))))

(define sogogi-account-service
  (list (user-group (name "sogogi") (system? #t))
        (user-account
         (name "sogogi")
         (group "sogogi")
         (system? #t)
         (comment "Sogogi daemon user")
         (home-directory "/var/empty")
         (shell (file-append shadow "/sbin/nologin")))))

(define sogogi-service-type
  (service-type (name 'sogogi)
                (description "Run the sogogi WebDAV server.")
                (extensions
                  (list (service-extension account-service-type
                                           (const sogogi-account-service))
                        (service-extension shepherd-root-service-type
                                           sogogi-shepherd-service)))
                (compose concatenate)
                (default-value (sogogi-configuration))))
