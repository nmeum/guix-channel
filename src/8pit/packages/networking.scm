(define-module (8pit packages networking)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages linux))

(define-public dhcpcd
  (package
    (name "dhcpcd")
    (version "10.0.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/NetworkConfiguration/dhcpcd")
             (commit (string-append "v" version))))
       (sha256
        (base32 "07n7d5wsmy955i6l8rkcmxhgxjygj2cxgpw79id2hx9w41fbkl5l"))
       (file-name (git-file-name name version))))
    (inputs (list bash-minimal))
    (native-inputs (list eudev))
    (build-system gnu-build-system)
    (arguments
     (list
      #:test-target "test"
      #:configure-flags #~(list "--enable-ipv6"
                                "--enable-privsep"
                                "--privsepuser=dhcpcd"
                                (string-append "--dbdir=" "/var/db/dhcpcd")
                                (string-append "--rundir=" "/var/run/dhcpcd")
                                "CC=gcc")
      #:phases #~(modify-phases %standard-phases
                   (add-after 'unpack 'do-not-create-dbdir
                     (lambda _
                       ;; Make sure that the Makefile doesn't attempt to create
                       ;; /var/db/dhcpcd for which it doesn't have permissions.
                       (substitute* "src/Makefile"
                         (("\\$\\{INSTALL\\} -m \\$\\{DBMODE\\} -d \\$\\{DESTDIR\\}\\$\\{DBDIR\\}")
                          ""))))
                   (add-before 'build 'setenv
                     (lambda _
                       (setenv "HOST_SH"
                               (string-append #$bash-minimal "/bin/sh"))))
                   (add-after 'install 'wrap-hooks
                     (lambda* (#:key inputs outputs #:allow-other-keys)
                       (let* ((out (assoc-ref outputs "out"))
                              (libexec (string-append out "/libexec"))
                              (sed (assoc-ref inputs "sed"))
                              (coreutils (assoc-ref inputs "coreutils")))
                         (wrap-program (string-append libexec
                                                      "/dhcpcd-run-hooks")
                           `("PATH" ":" suffix
                             (,(string-append coreutils "/bin")
                              ,(string-append sed "/bin"))))))))))
    (home-page "https://roy.marples.name/projects/dhcpcd")
    (synopsis "Feature-rich DHCP and DHCPv6 client")
    (description
     "Provides a DHCP and a DHCPv6 client.  Additionally,
dhcpcd is also an IPv4LL (aka ZeroConf) client.  In layperson's terms,
dhcpcd runs on your machine and silently configures your computer to work
on the attached networks without trouble and mostly without configuration.")
    (license license:bsd-2)))
