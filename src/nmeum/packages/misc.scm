(define-module (nmeum packages misc)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages version-control)
  #:use-module (srfi srfi-26))

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
