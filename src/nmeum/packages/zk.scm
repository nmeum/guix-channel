(define-module (nmeum packages zk)
  #:use-module (guix)
  #:use-module (guix build-system go)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages terminals))

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
                (copy-recursively #$(this-package-input "mustache-specs")
                                  mustache)))))))
    (inputs `(("mustache-specs" ,(origin
                                   (method git-fetch)
                                   (uri (git-reference (url
                                                        "https://github.com/mustache/spec")
                                                       (commit
                                                        "83b0721610a4e11832e83df19c73ace3289972b9")))
                                   (sha256 (base32
                                            "1g2f6hi04vkxrk53ixzm7yvkg5v8m00dh9nrkh9lxnx8aw824y80"))))))
    (propagated-inputs (list go-gopkg-in-yaml-v2))
    (home-page "https://github.com/aymerick/raymond")
    (synopsis "Handlebars for Go")
    (description
     "Provides a minimal templating engine for Go, inspired by the
Mustache-compatible Handlebars library from the Javascript ecosystem.")
    (license license:expat)))

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
    (synopsis "URL-friendly slugify with multiple language support")
    (description "Generates slug from Unicode string for use in URLs.")
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
    (propagated-inputs (list go-golang-org-x-net))
    (home-page "https://github.com/mvdan/xurls")
    (synopsis "Extracts URLs from text")
    (description
     "Xurls extracts urls from plain text using regular expressions.  It can
be used as both a binary and a library.")
    (license license:bsd-3)))

(define-public go-github-com-alecthomas-kong-0.5.0
  (package
    (inherit go-github-com-alecthomas-kong)
    (name "go-github-com-alecthomas-kong")
    (version "0.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/alecthomas/kong")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1lk4nb8ilvy0l5szj4s6wnz716vlz0v253423ykmph5l6bmips1k"))))
    (arguments
     (list
      #:tests? #f
      #:import-path "github.com/alecthomas/kong"))
    (propagated-inputs (list go-github-com-alecthomas-repr
                             go-github-com-pkg-errors))))

(define-public go-github-com-fatih-color-1.13.0
  (package
    (inherit go-github-com-fatih-color)
    (name "go-github-com-fatih-color")
    (version "1.13.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/fatih/color")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "029qkxsdpblhrpgbv4fcmqwkqnjhx08hwiqp19pd7zz6l8a373ay"))))
    (arguments
     (list
      #:import-path "github.com/fatih/color"
      #:test-flags
      #~(list "-vet=off")))))

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
    (description
     "Package unidecode implements a unicode transliterator which
replaces non-ASCII characters with their ASCII approximations.")
    (license license:asl2.0)))

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
    (synopsis "Calculates the elapsed time for a given date")
    (description "This package can be used to return the elapsed time since a
given time in a human-readable format.")
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
    (synopsis "Provides natural date time parsing")
    (description
     "This package was designed for parsing human-friendly relative
date/time ranges.")
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
      #:tests? #f ;TODO: requires packaging a lot of additional libraries.
      #:import-path "github.com/tliron/kutil"))
    (home-page "https://github.com/tliron/go-kutil")
    (synopsis "Utility library for Go")
    (description "This package provides a collection of Go utilities.")
    (license license:asl2.0)))

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
    (synopsis "Language Server Protocol SDK for Go")
    (description
     "Implementation of the @acronym{LSP, language server protocol}
for Go, allowing the creating of custom language servers.")
    (license license:asl2.0)))

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
    (synopsis "YAML metadata extension for the goldmark markdown parser")
    (description
     "Extension for the @code{goldmark} markdown parser which enables
defining document metadata in the YAML format.")
    (license license:expat)))

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
      #:test-flags
      #~(list "-vet=off")
      #:import-path "github.com/zchee/color/v2"))
    (propagated-inputs (list go-github-com-mattn-go-isatty
                             go-github-com-mattn-go-colorable))
    (home-page "https://github.com/zchee/color")
    (synopsis "Color package for Go")
    (description
     "Package color is an ANSI color package to output colorized or
SGR defined output to the standard output.  The API can be used in several way,
pick one that suits you.")
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
    (synopsis "Pretty printing for Go values")
    (description "Provides a pretty printing library for Go values.")
    (license license:expat)))

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
    (description
     "This package allows access different file time metadata from Go.")
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
       (modules '((guix build utils)))
       (snippet
        ;; Remove the sqlite database tests as they require a dependency on
        ;; github.com/go-testfixtures/testfixtures/v3 which itself requires
        ;; several new dependencies to be added to Guix.
        #~(begin
            (for-each delete-file
                      (find-files "internal/adapter/sqlite" ".*_test\\.go$"))))))
    (build-system go-build-system)
    (arguments
     (list
      #:install-source? #f
      #:import-path "github.com/zk-org/zk"
      #:test-flags
      #~(list "-vet=off" "-skip"
              (string-join (list
                            ;; Test matches $HOME against the /etc/passwd entry.
                            ;; Doesn't work on Guix because of HOME=/homeless-shelter.
                            "TestExpandPath") "|"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'fix-paths
            (lambda* (#:key inputs import-path #:allow-other-keys)
              (substitute* (string-append "src/" import-path
                                          "/internal/adapter/fzf/fzf.go")
                (("\"fzf\"")
                 (string-append
                   "\"" (search-input-file inputs "/bin/fzf") "\""))))))))
    (inputs (list fzf))
    (propagated-inputs (list go-github-com-aymerick-raymond
                             go-github-com-alecaivazis-survey-v2
                             go-github-com-alecthomas-kong-0.5.0
                             go-github-com-bmatcuk-doublestar-v4
                             go-github-com-fatih-color-1.13.0
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
    (synopsis "Plain text note-taking assistant")
    (description
     "Command-line tooling for helping you to maintain a plain text
Zettelkasten or personal wiki.  Based on the Markdown markup language.")
    (license license:gpl3)))
