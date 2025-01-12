(define-module (nmeum packages misc)
  #:use-module (srfi srfi-26)
  #:use-module (guix)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages libedit)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages tls))

(define-public mandoc-zstd
  (package
    (name "mandoc-zstd")
    (version "1.14.6")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://mandoc.bsd.lv/snapshots/mandoc-"
                                  version ".tar.gz"))
              (patches (map (lambda (patch)
                              (search-path (map (cut string-append <>
                                                     "/nmeum/packages/patches")
                                                %load-path) patch))
                            '("mandoc-support-zstd-compression.patch")))
              (sha256
               (base32
                "174x2x9ws47b14lm339j6rzm7mxy1j3qhh484khscw0yy1qdbw4b"))))
    (build-system gnu-build-system)
    (arguments
     `(#:test-target "regress"
       #:make-flags
       (list "VPATH=./zstd-src/zlibWrapper"
             (string-join
               (list "CFLAGS=-DZWRAP_USE_ZSTD=1"
                     (string-append "-I./zstd-src/zlibWrapper"))
               " "))
       #:phases ,#~(modify-phases %standard-phases
                     (add-after 'unpack 'unpack-zstd
                       (lambda _
                         (mkdir "zstd-src")
                         (invoke "tar" "--strip-components=1" "-C" "zstd-src"
                                 "-xf" #$(package-source zstd))))
                     (add-before 'configure 'set-prefix
                       (lambda* (#:key outputs #:allow-other-keys)
                         (substitute* "configure"
                           (("^CC=.*")
                            (string-append "CC=" #$(cc-for-target) "\n"))
                           (("^DEFCFLAGS=\\\\\"")
                            "DEFCFLAGS=\"-O2 ")
                           (("^UTF8_LOCALE=.*")      ;used for tests
                            "UTF8_LOCALE=en_US.UTF-8\n")
                           (("^MANPATH_(BASE|DEFAULT)=.*" _ which)
                            (string-append "MANPATH_" which "="
                                           "/run/current-system/profile/share/man\n"))
                           (("^PREFIX=.*")
                            (string-append "PREFIX=" (assoc-ref outputs "out")
                                           "\n"))))))))
    (native-inputs (list (libc-utf8-locales-for-target) perl)) ;used to run tests
    (inputs (list zlib (list zstd "lib")))
    (native-search-paths
     (list (search-path-specification
            (variable "MANPATH")
            (files '("share/man")))))
    (synopsis "Tools for BSD mdoc and man pages")
    (description
     "mandoc is a suite of tools compiling mdoc, the roff macro language of
choice for BSD manual pages, and man, the predominant historical language for
UNIX manuals.  It is small and quite fast.  The main component of the toolset
is the @command{mandoc} utility program, based on the libmandoc validating
compiler, to format output for UTF-8 and ASCII UNIX terminals, HTML 5,
PostScript, and PDF.  Additional tools include the @command{man} viewer, and
@command{apropos} and @command{whatis}.")
    (home-page "https://mandoc.bsd.lv/")
    (license license:isc)))

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
    (description
     "This library allows an application to generate text, XML,
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
       (patches (map (lambda (patch)
                       (search-path (map (cut string-append <>
                                              "/nmeum/packages/patches")
                                         %load-path) patch))
                     '("chimerautils-find-getopt-fix.patch")))
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
    (description
     "This is a port of the FreeBSD userland for Linux provided by
the Chimera Linux distribution.  Essentially, it is a collection of UNIX tools
such as @command{grep}, @command{cp}, @command{vi}, etc. and can be used as an
alternative to the corresponding implementations from the GNU project.")
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
