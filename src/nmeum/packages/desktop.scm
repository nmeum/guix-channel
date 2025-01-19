(define-module (nmeum packages desktop)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system zig)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages zig)
  #:use-module (gnu packages zig-xyz)
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
      #:make-flags #~(list (string-append "CC="
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

(define-public zig-fcft
  (package
    (name "zig-fcft")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~novakane/zig-fcft")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0im0rdwww7xxvhmibfp3459h8wwdmihjb9m7vmzxkgqs4x77l114"))))
    (build-system zig-build-system)
    (arguments
     (list
      #:skip-build? #t
      #:tests? #f))
    (propagated-inputs (list zig-pixman fcft))
    (native-inputs (list pkg-config))
    (synopsis "Zig bindings for the fcft font library")
    (description "")
    (home-page "https://git.sr.ht/~novakane/zig-fcft")
    (license license:expat)))

(define-public creek
  (package
    (name "creek")
    (version "0.4.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nmeum/creek")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0b1gpxgi207cqrls6qp0pd6749g60yfcrjii8nagm00c678bs3nx"))))
    (build-system zig-build-system)
    (arguments
     (list
      #:zig-release-type "safe"
      #:tests? #f))
    (native-inputs (list fcft
                         pixman
                         pkg-config
                         zig-wayland
                         zig-fcft
                         zig-pixman))
    (home-page "https://github.com/nmeum/leeve")
    (synopsis
     "A minimalistic and malleable status bar for the River compositor.")
    (description "A fork of the creek status bar which intended to be
more mallable then the original version.  For example,
supporting custom status bar information via stdin.")
    (license license:expat)))

(define-public font-terminus-patched
  (package
    (inherit font-terminus)
    (name "font-terminus-patched")
    (arguments
      (substitute-keyword-arguments (package-arguments font-terminus)
        ((#:phases phases '%standard-phases)
         #~(modify-phases #$phases
             (add-after 'unpack 'patch-font
               (lambda _
                 (invoke "patch" "-p0" "-i" "alt/td1.diff")
                 (invoke "patch" "-p0" "-i" "alt/ll2.diff")))))))))
