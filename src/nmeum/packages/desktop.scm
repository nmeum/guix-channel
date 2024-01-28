(define-module (nmeum packages desktop)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system zig)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages zig)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages textutils))

;; See https://issues.guix.gnu.org/68548
(define fcft-utf8
  (package
    (inherit fcft)
    (native-inputs
      (modify-inputs (package-native-inputs fcft)
                     (prepend utf8proc)))))

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
        fcft-utf8
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
