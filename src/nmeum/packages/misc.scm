(define-module (nmeum packages misc)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages version-control)
  #:use-module (srfi srfi-26))

(define-public git-shuffle
  (let ((commit "06ac27513a275c979aa57cd8c932b90c8cb689eb")
        (revision "1"))
    (package
      (name "git-shuffle")
      (version (git-version "20251025" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://git.8pit.net/git-shuffle.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1say9ap60l04i3lj4gbf0dn6zbf457cf5fdvlwdh4y7rfi8hq3m0"))))
      (build-system gnu-build-system)
      (arguments
       (list
        #:tests? #f
        #:make-flags
        #~(list "CFLAGS=-O2"
                "PREFIX=/"
                (string-append "DESTDIR=" #$output)
                (string-append "CC=" #$(cc-for-target)))
        #:phases
        #~(modify-phases %standard-phases
            (delete 'configure))))
      (inputs (list pkg-config))
      (native-inputs (list libgit2))
      (home-page "https://git.8pit.net/git-shuffle")
      (synopsis "Randomize timestamps associated with Git commits to enhance privacy")
      (description "")
      (license license:gpl3))))

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

(define-public mblaze-ui
  (package
    (name "mblaze-ui")
    (version "0.0.0-20250423085554-54f778f3d6a8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.8pit.net/mblaze-ui.git")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "104fjj7da2cp2f6g8h4y6ycs68ml8smiq11clx3dc07y191mnzf1"))))
    (build-system go-build-system)
    (arguments
     (list
      #:install-source? #f
      #:import-path "github.com/nmeum/mblaze-ui"))
    (propagated-inputs (list mblaze
                             go-github-com-mattn-go-runewidth
                             go-github-com-gdamore-tcell-v2))
    (home-page "https://github.com/nmeum/mblaze-ui")
    (synopsis "mblaze-ui")
    (description "")
    (license license:gpl3+)))

(define-public tpm
  (package
    (name "tpm")
    (version "1.3.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.8pit.net/tpm.git")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "109q5ag4cbrxbr2slnb3ii9zkjnim5yxfb3j34yf3r32yd6kmjlg"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f
      #:make-flags
      #~(list "PREFIX=/"
              (string-append "DESTDIR=" #$output))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'fix-paths
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (substitute* "tpm"
                (("gpg2")
                 (search-input-file inputs "/bin/gpg")))))
          (delete 'configure))))
    (inputs (list gnupg))
    (native-inputs (list perl))
    (home-page "https://git.8pit.net/tpm")
    (synopsis "Tiny password manager")
    (description
     "Tiny shell script which is heavily inspired and largely
compatible with @code{pass}.  Just like pass it uses @code{gnupg} to securely
store your passwords, the major difference between pass and tpm is that the
latter is a lot more minimal.")
    (license license:gpl3)))

(define-public go-github-com-aymerick-raymond
  (package
    (name "go-github-com-aymerick-raymond")
    (version "2.0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/aymerick/raymond")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0s5nxzx87a12hcdzhliy1j8albfx2jqddaks4m86yfrcawm6vndn"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/aymerick/raymond"
      #:phases
      #~(modify-phases %standard-phases
          ;; Replace vendored mustache version with the one from 'inputs'.
          (add-before 'check 'supply-mustache
            (lambda* (#:key inputs import-path #:allow-other-keys)
              (let ((mustache (string-append "src/" import-path "/mustache")))
                (delete-file-recursively mustache)
                (copy-recursively
                  #$(this-package-input "mustache-specs")
                  mustache)))))))
    (inputs
      `(("mustache-specs"
        ,(origin
           (method git-fetch)
           (uri
             (git-reference
               (url "https://github.com/mustache/spec")
               (commit "83b0721610a4e11832e83df19c73ace3289972b9")))
           (sha256
             (base32
              "1g2f6hi04vkxrk53ixzm7yvkg5v8m00dh9nrkh9lxnx8aw824y80"))))))
    (propagated-inputs (list go-gopkg-in-yaml-v2))
    (home-page "https://github.com/aymerick/raymond")
    (synopsis "Handlebars for Go")
    (description "Provides a minimal templating engine for Go, inspired by the
Mustache-compatible Handlebars library from the Javascript ecosystem.")
    (license license:expat)))

(define-public go-github-com-gosimple-unidecode
  (package
    (name "go-github-com-gosimple-unidecode")
    (version "1.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/gosimple/unidecode")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1dxdddn744l0s1lr006s2a4k02w6qx8j3k31c7sfflh7wvwzcdzx"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/gosimple/unidecode"))
    (home-page "https://github.com/gosimple/unidecode")
    (synopsis "Unicode transliterator for Go")
    (description "Package unidecode implements a unicode transliterator which
replaces non-ASCII characters with their ASCII approximations.")
    (license license:asl2.0)))

(define-public go-github-com-gosimple-slug
  (package
    (name "go-github-com-gosimple-slug")
    (version "1.12.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/gosimple/slug")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "15gk6hdd8kjfl0srlf3gnjq34m64as1s6pjv7paaxd1zvrcml46y"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/gosimple/slug"))
    (propagated-inputs (list go-github-com-gosimple-unidecode))
    (home-page "https://github.com/gosimple/slug")
    (synopsis "slug")
    (description
     "Package slug generate slug from unicode string, URL-friendly slugify with
multiple languages support.")
    (license license:mpl2.0)))

(define-public go-github-com-mvdan-xurls
  (package
    (name "go-github-com-mvdan-xurls")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mvdan/xurls")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "05q4nqbpgfb0a35sn22rn9mlag2ks4cgwb54dx925hipp6zgj1hx"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/mvdan/xurls"))
    (propagated-inputs
      (list go-golang-org-x-net))
    (home-page "https://github.com/mvdan/xurls")
    (synopsis "xurls")
    (description
     "Package xurls extracts urls from plain text using regular expressions.")
    (license license:bsd-3)))

(define-public go-github-com-relvacode-iso8601
  (package
    (name "go-github-com-relvacode-iso8601")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/relvacode/iso8601")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0qn6rb957s6kniyadz248j3ajm8wvn9ilrs4yz50zsw1lj7n4csw"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/relvacode/iso8601"))
    (home-page "https://github.com/relvacode/iso8601")
    (synopsis "Usage")
    (description
     "Package iso8601 is a utility for parsing ISO8601 datetime strings into native Go
times.  The standard library's RFC3339 reference layout can be too strict for
working with 3rd party APIs, especially ones written in other languages.")
    (license license:expat)))

(define-public go-github-com-rvflash-elapsed
  (package
    (name "go-github-com-rvflash-elapsed")
    (version "0.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/rvflash/elapsed")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1jawknvv51k1awlzpyr2qc1s75s1fg3l40c0zhixp1sc98hl434c"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/rvflash/elapsed"))
    (home-page "https://github.com/rvflash/elapsed")
    (synopsis "Elapsed time")
    (description
     "Package elapsed return the elapsed time since a given time in a human readable
format.")
    (license license:expat)))

(define-public go-github-com-tj-go-naturaldate
  (package
    (name "go-github-com-tj-go-naturaldate")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/tj/go-naturaldate")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "12d7nf1jd7nk9r8ifn1hr21a7m4yb1garmiw2grrsi5zsqsh2jb1"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/tj/go-naturaldate"))
    (propagated-inputs (list go-github-com-tj-assert))
    (home-page "https://github.com/tj/go-naturaldate")
    (synopsis "Go Natural Date")
    (description "Package naturaldate provides natural date time parsing.")
    (license license:expat)))

(define-public go-github-com-tliron-kutil
  (package
    (name "go-github-com-tliron-kutil")
    (version "0.1.59")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/tliron/go-kutil")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "07lhzgpsi96icdya874xmfd1ymg4s4y09s7m7h398aryn7hbysyg"))))
    (build-system go-build-system)
    (arguments
     (list
      #:skip-build? #t
      #:tests? #f ; TODO: requires packaging a lot of additional libraries.
      #:import-path "github.com/tliron/kutil"))
    (home-page "https://github.com/tliron/kutil")
    (synopsis "Kutil")
    (description "This package provides a collection of Go utilities.")
    (license license:asl2.0)))

(define-public go-github-com-petermattis-goid
  (package
    (name "go-github-com-petermattis-goid")
    (version "0.0.0-20251121121749-a11dd1a45f9a")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/petermattis/goid")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0zbagyilyrz87kinzfnkcmgsqhzq1nhacn5kjswdlr08n4wdg748"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/petermattis/goid"))
    (home-page "https://github.com/petermattis/goid")
    (synopsis "Retrieves the current goroutine's ID")
    (description "Programatically retrieve the current goroutine's identifier.")
    (license license:asl2.0)))

(define-public go-github-com-sasha-s-go-deadlock
  (package
    (name "go-github-com-sasha-s-go-deadlock")
    (version "0.3.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/sasha-s/go-deadlock")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0arb35idnyz4n118xz7p2snazqi35gk1975h1xfk0y4riiks58yz"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/sasha-s/go-deadlock"))
    (propagated-inputs (list go-github-com-petermattis-goid))
    (home-page "https://github.com/sasha-s/go-deadlock")
    (synopsis "Online deadlock detection in go (golang).")
    (description "Deadlocks happen and are painful to debug.")
    (license license:asl2.0)))

(define-public go-github-com-zchee-color
  (package
    (name "go-github-com-zchee-color")
    (version "2.0.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/zchee/color")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0im301c9m5702lsv3qvzwmx943m9hmrpb2670zfv0z14cm7fqhls"))))
    (build-system go-build-system)
    (arguments
     (list
      #:tests? #f
      #:import-path "github.com/zchee/color/v2"))
    (propagated-inputs (list go-github-com-mattn-go-isatty
                             go-github-com-mattn-go-colorable))
    (home-page "https://github.com/zchee/color")
    (synopsis "Color")
    (description
     "Package color is an ANSI color package to output colorized or SGR defined output
to the standard output.  The API can be used in several way, pick one that suits
you.")
    (license license:expat)))

(define-public go-github-com-tliron-glsp
  (package
    (name "go-github-com-tliron-glsp")
    (version "0.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/tliron/glsp")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0vz4idndpcxrkjck6m0azdg8zsgcxcchf0ldhnkr8fj3z2sllljr"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/tliron/glsp"))
    (propagated-inputs (list go-github-com-sasha-s-go-deadlock
                             go-github-com-tliron-kutil
                             go-github-com-sourcegraph-jsonrpc2
                             go-github-com-pkg-errors
                             go-github-com-gorilla-websocket
                             go-golang-org-x-term
                             go-golang-org-x-crypto
                             go-github-com-zchee-color))
    (home-page "https://github.com/tliron/glsp")
    (synopsis "GLSP")
    (description
     "@@url{https://microsoft.github.io/language-server-protocol/,Language Server
Protocol} SDK for Go.")
    (license license:asl2.0)))

(define-public go-gopkg-in-djherbis-times-v1
  (package
    (name "go-gopkg-in-djherbis-times-v1")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/djherbis/times")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1dk087l9c927f90zrsmyxxfx5i980r952qw47j9srq2q7dd0b4ni"))
       (modules '((guix build utils)))
       ;; Fix import path for itself in the example code (build by 'check).
       (snippet '(substitute* "example/main.go"
                   (("github.com/djherbis/times")
                    "gopkg.in/djherbis/times.v1")))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "gopkg.in/djherbis/times.v1"))
    (home-page "https://github.com/djherbis/times")
    (synopsis "File times for Go")
    (description "")
    (license license:expat)))

(define-public go-github-com-yuin-goldmark-meta
  (package
    (name "go-github-com-yuin-goldmark-meta")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yuin/goldmark-meta")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "07dnwpkcifk9lw25ncflwdzmp8xqwbsbq0bnw3v7ljz9i8zi3ya3"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/yuin/goldmark-meta"))
    (propagated-inputs (list go-gopkg-in-yaml-v2 go-github-com-yuin-goldmark))
    (home-page "https://github.com/yuin/goldmark-meta")
    (synopsis "goldmark-meta")
    (description
     "package meta is a extension for the
goldmark(@@url{http://github.com/yuin/goldmark,http://github.com/yuin/goldmark}).")
    (license license:expat)))

(define-public go-github-com-zk-org-pretty
  (package
    (name "go-github-com-zk-org-pretty")
    (version "0.2.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zk-org/pretty")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "086zcjamclnn3y9w4ww88ik9avwihbxk7h08vk7686643i1zij96"))))
    (build-system go-build-system)
    (arguments
      (list
        #:import-path "github.com/zk-org/pretty"))
    (propagated-inputs (list go-github-com-rogpeppe-go-internal
                             go-github-com-kr-text))
    (home-page "https://github.com/zk-org/pretty")
    (synopsis #f)
    (description
      "Package pretty provides pretty-printing for Go values.  This is useful during
      debugging, to avoid wrapping long output lines in the terminal.")
      (license license:expat)))

(define-public go-github-com-go-testfixtures-testfixtures
  (package
    (name "go-github-com-go-testfixtures-testfixtures")
    (version "3.6.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/go-testfixtures/testfixtures")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1mcxvr1lhcf8bkwcy5ngrc5l2cfan435vrnm1byy4ifkyw1g9l5k"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/go-testfixtures/testfixtures/v3"
      #:unpack-path "github.com/go-testfixtures/testfixtures"))
    (propagated-inputs (list go-gopkg-in-yaml-v2
                             go-github-com-spf13-pflag
                             go-github-com-mattn-go-sqlite3
                             go-github-com-lib-pq
                             go-github-com-joho-godotenv
                             go-github-com-jackc-pgx-v4
                             go-github-com-go-sql-driver-mysql
                             go-github-com-denisenkom-go-mssqldb))
    (home-page "https://github.com/go-testfixtures/testfixtures")
    (synopsis "testfixtures")
    (description
     "Writing tests is hard, even more when you have to deal with an SQL database.
This package aims to make writing functional tests for web apps written in Go
easier.")
    (license license:expat)))

(define-public zk
  (package
    (name "zk")
    (version "0.15.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/zk-org/zk/")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1jm18qp4sgfb92c420jc8ylfjwc6shv29fb1jc4z2g03dqcbg2l7"))
       (snippet
         ;; Remove the transaction_test as it introduces a dependency on
         ;; github.com/go-testfixtures/testfixtures/v3 which itself requires
         ;; several new dependencies to be added to Guix.
         #~(begin (delete-file "internal/adapter/sqlite/transaction_test.go")))))
    (build-system go-build-system)
    (arguments
     (list
      #:tests? #f
      #:install-source? #f
      #:import-path "github.com/zk-org/zk"))
    (native-inputs (list ncurses))
    (propagated-inputs
      (list
        go-github-com-aymerick-raymond
        go-github-com-alecaivazis-survey-v2
        go-github-com-alecthomas-kong
        go-github-com-bmatcuk-doublestar-v4
        go-github-com-fatih-color
        go-github-com-google-go-cmp
        go-github-com-gosimple-slug
        go-github-com-kballard-go-shellquote
        go-github-com-lestrrat-go-strftime
        go-github-com-mattn-go-isatty
        go-github-com-mattn-go-sqlite3
        go-github-com-mvdan-xurls
        go-github-com-pelletier-go-toml
        go-github-com-pkg-errors
        go-github-com-relvacode-iso8601
        go-github-com-rvflash-elapsed
        go-github-com-schollz-progressbar-v3
        go-github-com-tj-go-naturaldate
        go-github-com-tliron-glsp
        go-github-com-tliron-kutil
        go-github-com-yuin-goldmark
        go-github-com-yuin-goldmark-meta
        go-github-com-zk-org-pretty
        go-gopkg-in-djherbis-times-v1
        go-github-com-alecaivazis-survey-v2))
    (home-page "https://zk-org.github.io/zk")
    (synopsis "mblaze-ui")
    (description "")
    (license license:gpl3)))
