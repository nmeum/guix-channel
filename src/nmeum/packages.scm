(define-module (nmeum packages)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (ice-9 match))

(define %distro-root-directory
  ;; Like %distro-root-directory from (gnu packages), with adjusted paths.
  (letrec-syntax ((dirname* (syntax-rules ()
                              ((_ file)
                               (dirname file))
                              ((_ file head tail ...)
                               (dirname (dirname* file tail ...)))))
                  (try      (syntax-rules ()
                              ((_ (file things ...) rest ...)
                               (match (search-path %load-path file)
                                 (#f
                                  (try rest ...))
                                 (absolute
                                  (dirname* absolute things ...))))
                              ((_)
                               #f))))
    (try ("nmeum/packages/misc" nmeum/ packages/)
         ("nmeum/packages.scm" nmeum/))))

(define %default-package-module-path
  ;; Default search path for package modules.
  `((,%distro-root-directory . "nmeum/packages")))

(define-public (get-file name)
  (local-file
    (in-vicinity
      %distro-root-directory
      (string-append "nmeum/packages/files/" name))))
