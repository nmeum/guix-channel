(define-module (nmeum packages desktop)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system zig)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages zig)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages textutils))

(define-public dumb-runtime-dir
  (package
    (name "dumb-runtime-dir")
    (version "1.0.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ifreund/dumb_runtime_dir")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0nrxhvbh3bs4pi4f5h03zw1p1ys19qmmlx263ysly8302wkxk1m4"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f
      ;; TODO: Create a subdirectory in /run (e.g. /run/users) or simply
      ;; prefix the directory created by dumb-runtime-dir with "user-".
      #:make-flags #~(list "RUNTIME_DIR_PARENT=/run"
                           (string-append "CC="
                                          #$(cc-for-target))
                           (string-append "PREFIX=")
                           (string-append "DESTDIR="
                                          #$output))
      #:phases #~(modify-phases %standard-phases
                   (delete 'configure))))
    (inputs (list linux-pam))
    (native-inputs (list pkg-config))
    (home-page "https://github.com/ifreund/dumb_runtime_dir")
    (synopsis "Creates an XDG_RUNTIME_DIR via PAM")
    (description
     "Provides a acronym{PAM, Pluggable Authentication Module} for
creating a primitve @code{XDG_RUNTIME_DIR} that is never removed.  This
is useful in conjuction with simple seat managers like @code{seatd}
which do not set @code{XDG_RUNTIME_DIR}.")
    (license license:bsd-0)))

(define-public mkrundir
  (package
    (name "mkrundir")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://raw.githubusercontent.com/nmeum/aports/20c6e66bcb4a23236b96bbd9b360f7dd7b8fdaf7/8pit/mkrundir/mkrundir.c")
       (sha256
        (base32 "1zmqns6grn9awjwn1f2qmv9v7agk2ly2xbr9i6av48g8rkwgmid7"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'configure)
                   (delete 'unpack)
                   (replace 'build
                     (lambda _
                       (let ((gcc (assoc-ref %build-inputs "gcc")))
                         (invoke (string-append gcc "/bin/gcc")
                                 "-O2"
                                 "-Wall"
                                 "-Wextra"
                                 "-Wpedantic"
                                 "-Werror"
                                 "-fstack-clash-protection"
                                 "-fstack-protector-strong"
                                 "-D_FORTIFY_SOURCE=2"
                                 "-DRUNTIME_DIR_PREFIX=\"/run/user-\""
                                 "-o"
                                 "mkrundir"
                                 #$source))))
                   (replace 'install
                     (lambda _
                       (let* ((out (assoc-ref %outputs "out"))
                              (bin (string-append out "/bin"))
                              (exec (string-append bin "/mkrundir")))
                         (mkdir-p bin)
                         (copy-file "mkrundir" exec)
                         (chmod exec #o4755)))))))
    (home-page "https://github.com/nmeum/aports/tree/master/8pit/mkrundir")
    (synopsis "A simple SUID binary for creating an XDG_RUNTIME_DIR")
    (description "")
    (license license:expat)))

(define-public creek
  (package
    (name "creek")
    (version "0.2.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/nmeum/creek")
               (commit (string-append "v" version))
               (recursive? #t)))
        (file-name (git-file-name name version))
        (sha256
          (base32 "08v8f39wxpalifib0760nkckl1xbbxqcjcmv68348w9b8367kzx6"))))
    (build-system zig-build-system)
    (arguments
      (list
        #:zig-release-type "safe"
        #:tests? #f))
    (native-inputs
      (list
        pixman
        fcft
        pkg-config
        wayland
        wayland-protocols
        zig))
    (home-page "https://github.com/nmeum/leeve")
    (synopsis "A minimalistic and malleable status bar for the River compositor.")
    (description "A fork of the creek status bar which intended to be
more mallable then the original version.  For example,
supporting custom status bar information via stdin.")
    (license license:expat)))
