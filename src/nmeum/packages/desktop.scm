(define-module (nmeum packages desktop)
  #:use-module (nmeum packages)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (guix build-system zig)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages zig)
  #:use-module (gnu packages zig-xyz)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages xdisorg))

(define-public bemenu-emoji
  (package
    (name "bemenu-emoji")
    (version "16.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules ((guix build utils))
        #:builder
        ,#~(begin
             (use-modules (guix build utils))
             (let* ((bindir (string-append #$output "/bin"))
                    (script (string-append bindir "/bemenu-emoji")))
               (mkdir-p bindir)
               (with-output-to-file script
                 (lambda _
                   (format #t
                     "#!~a

emoji=$(~a -F '# ' '/fully-qualified/ { print $2 }' ~s | \\
 ~a -F 'E[0-9][0-9]*.[0-9][0-9]* ' '/E[0-9][0-9]*\\.[0-9][0-9]*/ { print $1 $2 }' | \\
 ~a -p emoji -l 15 \"$@\" | cut -d ' ' -f1)

[ -n \"${emoji}\" ] || exit
exec ~a \"${emoji}\""
                     (search-input-file %build-inputs "/bin/sh")
                     (search-input-file %build-inputs (string-append "/bin/awk"))
                     (assoc-ref %build-inputs "unicode")
                     (search-input-file %build-inputs (string-append "/bin/awk"))
                     (search-input-file %build-inputs (string-append "/bin/bemenu"))
                     (search-input-file %build-inputs (string-append "/bin/wtype")))))
               (chmod script #o755)))))
    (inputs
      `(("bash-minimal" ,bash-minimal)
        ("bemenu" ,bemenu)
        ("gawk" ,gawk)
        ("wtype" ,wtype)
        ("unicode"
         ,(origin
            (method url-fetch)
            (uri (format #f "https://www.unicode.org/Public/emoji/~a/emoji-test.txt" version))
            (sha256
              (base32
                "15wn2f2yvk66576xs7lij8ip0gkawkqfhlv997i45wbcx0scbw14"))))))
    (synopsis "Provides a cc(1) symlink to gcc(1)")
    (description "")
    (home-page "https://github.com/nmeum/aports/blob/master/8pit/bemenu-emoji")
    (license license:public-domain)))

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

(define-public dam
  (let ((commit "e6eb713fb3239aad3c534502d8c0e42e4e514c8f")
        (revision "1"))
    (package
      (name "dam")
      (version (git-version "0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://codeberg.org/sewn/dam")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0ybhyvv3n1xdy5hb1xw7l2rzy73n5vhh8r60gfbf61crhggnzh8k"))))
      (build-system gnu-build-system)
      (arguments
       (list
        #:tests? #f
        #:make-flags #~(list (string-append "PREFIX=" #$output))
        #:phases #~(modify-phases %standard-phases
                     (add-before 'configure 'set-cc-command
                       (lambda _
                         (setenv "CC" #$(cc-for-target))))
                     (delete 'configure))))
      (inputs (list fcft pixman wayland wayland-protocols))
      (native-inputs (list pkg-config))
      (home-page "https://codeberg.org/sewn/dam")
      (synopsis "A itsy-bitsy dwm-esque bar for the river compositor")
      (description "")
      (license license:expat))))

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

(define-public font-terminus-patched
  (package
    (inherit font-terminus)
    (name "font-terminus-patched")
    (arguments
     (substitute-keyword-arguments (package-arguments font-terminus)
       ((#:phases phases
         '%standard-phases)
        #~(modify-phases #$phases
            (add-after 'unpack 'patch-font
              (lambda _
                (invoke "patch" "-p0" "-i" "alt/td1.diff")
                (invoke "patch" "-p0" "-i" "alt/ll2.diff")))))))))

(define-public ustatus
  (let ((commit "4032e2010de049472b7af57e85b7e4728fdde5e7")
        (revision "0"))
    (package
      (name "ustatus")
      (version (git-version "20190721" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/nmeum/ustatus")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0a9pf51c2j68s7limdhw8ccqhyc1lk3q0iddfh1y65m18jh1vmn1"))))
      (build-system gnu-build-system)
      (arguments
       (list
        #:tests? #f
        #:make-flags
        #~(list (string-append "CC="
                               #$(cc-for-target)))
        #:phases
        #~(modify-phases %standard-phases
            (replace 'configure
              (lambda _
                (symlink #$(nmeum-file "ustatus-config.h") "config.h")))
            (replace 'install
              (lambda* (#:key outputs #:allow-other-keys)
                (let* ((outdir (assoc-ref outputs "out"))
                       (bindir (string-append outdir "/bin")))
                  (mkdir-p bindir)
                  (copy-file "ustatus"
                             (string-append bindir "/ustatus"))))))))
      (inputs (list tinyalsa))
      (native-inputs (list pkg-config))
      (home-page "https://git.8pit.net/ustatus")
      (synopsis "Minimal status tool for dwm-like status bars")
      (description "")
      (license license:wtfpl2))))

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
