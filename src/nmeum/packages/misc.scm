(define-module (nmeum packages misc)
  #:use-module (guix)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages version-control)
  #:use-module (srfi srfi-26))

;; TODO: This cannot be properly used with Guix right now because
;; gnu/system/keyboard.scm unconditionally generates the keyboard
;; console-keymap from xkeyboard-config.
(define-public neo-layout
  (let ((commit "97cfdd486dcd278833b80dc396e00a1c3503e6d6")
        (revision "1"))
    (package
      (name "neo-layout")
      (version (git-version "20220410" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://git.neo-layout.org/neo/neo-layout.git")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0xg3n808rphn9jlpvgc4y1pz8kdjv916xshg64lkp4hakip1p45j"))))
      (build-system copy-build-system)
      (arguments
        `(#:install-plan
          '(("linux/console/neo.map" "usr/share/keymaps/legacy/i386/qwertz/neo.map"))))
      (home-page "https://neo-layout.org")
      (synopsis "Keyboard layout optimized for the German language")
      (description "This provides the original handwritten version of the
neo-layout for kbd's @code{loadkeys(1)}.  Contrary to the version generated
from xkeyboard-config, layer 4 actually works.")
      (license license:gpl3))))

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
    (native-inputs (list mblaze
                         go-github-com-mattn-go-runewidth
                         go-github-com-gdamore-tcell-v2))
    (home-page "https://github.com/nmeum/mblaze-ui")
    (synopsis "mblaze-ui")
    (description "")
    (license license:gpl3+)))

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
(define-public loksh-8pit
  (package
    (inherit loksh)
    (name "loksh-8pit")
    (source
     (origin
       (inherit (package-source loksh))
       (patches (map (lambda (patch)
                       (search-path (map (cut string-append <>
                                              "/nmeum/packages/patches")
                                         %load-path) patch))
                     '("loksh-bracketed-paste-mode.patch"
                       "loksh-kshbasename.patch")))))))

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

(define-public pimsync
  (package
    (name "pimsync")
    (version "0.5.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://git.sr.ht/~whynothugo/pimsync")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0r8ph1gra5d9wb06c8khcz0rpjak2dcpvkvdm7aj55gdvcnx4v9d"))))
    (build-system cargo-build-system)
    (arguments
      (list #:install-source? #f
            #:phases
            #~(modify-phases %standard-phases
                ;; XXX: Forcefully disable experimental jmap support as it
                ;; introduces a dependency on jmap-tools which does not compile
                ;; with rustc-1.85.1 due to utilization of unstable rustc
                ;; features.  Can be removed once we upgrade to rustc-1.86.X.
                (add-after 'unpack 'disable-jmap
                  (lambda _
                    (substitute* "Cargo.toml"
                      ((".*jmap.*") ""))))
                (add-after 'unpack 'setup-environment
                  (lambda _
                    (setenv "PIMSYNC_VERSION" #$version)))
                (add-after 'install 'install-man-pages
                  (lambda _
                    (let ((man (string-append #$output "/share/man/man")))
                      (install-file "pimsync.1" (string-append man "1"))
                      (install-file "pimsync.conf.5" (string-append man "5"))
                      (install-file "pimsync-migration.7" (string-append man "7"))))))))
    (inputs (cons* sqlite (cargo-inputs 'pimsync #:module '(nmeum packages rust-crates))))
    (synopsis "Synchronize calendars and contacts using CalDAV, CardDAV and others")
    (description "pimsync synchronizes your calendars and contacts between two
storage locations.  The most popular purpose is to synchronize a CalDAV or
CardDAV server with a local folder or file.")
    (home-page "https://pimsync.whynothugo.nl/")
    (license license:eupl1.2)))

(define-public go-webdav
  (package/inherit go-github-com-emersion-go-webdav
    (name "go-webdav")
    (arguments
      (substitute-keyword-arguments
        (package-arguments go-github-com-emersion-go-webdav)
        ((#:tests? _ #t) #f)
        ((#:install-source? _ #t) #f)
        ((#:import-path _ "github.com/emersion/go-webdav") "github.com/emersion/go-webdav/cmd/webdav-server")
        ((#:unpack-path _ "") "github.com/emersion/go-webdav")))
    (native-inputs (package-propagated-inputs go-github-com-emersion-go-webdav))
    (propagated-inputs '())
    (inputs '())))

(define-public archive-mail
  (package
    (name "archive-mail")
    (version "v0.0.0-20260103100740-0b0c03251191")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.8pit.net/archive-mail.git")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1fdwf2xyy8gkvagq6ivsd0kvfxx9xl3fvd81v54agwmlszxa8jc6"))))
    (build-system go-build-system)
    (arguments
     (list
      #:install-source? #f
      #:import-path "github.com/nmeum/archive-mail"
      #:phases
      #~(modify-phases %standard-phases
          (replace 'check
            (lambda* (#:key tests? import-path #:allow-other-keys)
              (when tests?
                (with-directory-excursion (string-append "src/" import-path "/tests")
                   (setenv "ARCHIVE_MAIL" (in-vicinity (getenv "GOBIN") "archive-mail"))
                   (invoke "./run_tests.sh"))))))))
    (inputs (list bash-minimal diffutils))
    (home-page "https://git.8pit.net/archive-logs")
    (synopsis "archive-mail")
    (description "")
    (license license:gpl3+)))

(define-public archive-logs
  (let ((commit "faaf2e85ee419c7b0a3c4dd0f5932834d2fb9d60")
        (revision "0"))
    (package
      (name "archive-logs")
      (version (git-version "20211124" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://git.8pit.net/archive-logs.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0d9fxbrajzjnb6cvaw8x363583gvdplw0yfbk7qgzzrsyfdqa52d"))))
      (build-system gnu-build-system)
      (arguments
       (list
        #:test-target "check"
        #:make-flags
        #~(list "CFLAGS=-O2"
                "HAVE_SENDFILE=1"
                "PREFIX=/"
                (string-append "DESTDIR=" #$output)
                (string-append "CC=" #$(cc-for-target)))
        #:phases
        #~(modify-phases %standard-phases
            (delete 'configure))))
      (inputs (list bash-minimal))
      (home-page "https://git.8pit.net/archive-logs")
      (synopsis "Iteratively archive newline separated log files")
      (description "")
      (license license:gpl3))))
