(define-module (nmeum packages misc)
  #:use-module (srfi srfi-26)
  #:use-module (guix)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages libedit)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages tls))

(define-public libxo
  (package
    (name "libxo")
    (version "1.7.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Juniper/libxo")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "115jv067msym0lsxkiz95ddvspd6smvww37248xkqyin0rxb2m0j"))))
    (build-system gnu-build-system)
    (native-inputs (list autoconf automake libtool))
    (home-page "http://juniper.github.io/libxo/libxo-manual.html")
    (synopsis "Library for Generating Text, XML, JSON, and HTML Output")
    (description "This library allows an application to generate text, XML,
JSON, and HTML output using a common set of function calls.  The application
decides at run time which output style should be produced.  The application
calls a function @code{xo_emit} to product output that is described in a format
string.  A \"field descriptor\" tells libxo what the field is and what it means.")
    (license license:bsd-2)))

(define-public chimera-utils
  (package
    (name "chimerautils")
    (version "14.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/chimera-linux/chimerautils")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1z23ii57r9li4ffk9fg8q5k6n74rkzvmj2v5bcwb7dgkjanmhrn5"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:tests? #f))
    (inputs (list (list zstd "lib")
                  zlib
                  ncurses
                  acl
                  libedit
                  libxo
                  openssl))
    (native-inputs (list flex bison pkg-config))
    (home-page "https://github.com/chimera-linux/chimerautils")
    (synopsis "The FreeBSD-based core Linux userland from Chimera Linux")
    (description "This is a port of the FreeBSD userland to Linux provided by
the Chimera Linux distribution.  It provides a variety of standard tools which
can be used as alternative to the corresponding implementation from the GNU
project.")
    (license license:bsd-2)))

;; TODO: Use package-with-extra-patches somehow, however, we need to change
;; the package name somehow as loksh would otherwise be ambiguous and not
;; sure how do that on a package returned by package-with-extra-patches.
(define-public loksh-bracketed
  (package
    (inherit loksh)
    (name "loksh-bracketed")
    (source
     (origin
       (inherit (package-source loksh))
       (patches (map (lambda (patch)
                       (search-path (map (cut string-append <>
                                              "/nmeum/packages/patches")
                                         %load-path) patch))
                     '("loksh-bracketed-paste-mode.patch")))))))
