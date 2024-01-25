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

(define-public levee
  (let ((commit "d9f908e54f2905c2a01b4dd7d3091dd70d09298f"))
    (package
      (name "levee")
      (version (git-version "20240120" "0" commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/nmeum/levee.git")
                 (commit commit)
                 (recursive? #t)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "16xm0li67zc2ihjblcfqfkzfklspyf0y1b79f4vxsjf2k3x5wi3j"))))
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
      (description "A fork of the levee status bar which intended to be
more mallable then the original version.  For example,
supporting custom status bar information via stdin.")
      (license license:expat))))
