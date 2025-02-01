(define-module (nmeum services networking)
  #:use-module (guix gexp)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages dns)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module ((srfi srfi-1) #:select (concatenate))
  #:use-module ((srfi srfi-13) #:select (string-join))
  #:use-module ((srfi srfi-26) #:select (cut))

  #:export (dhcpcd-service-type
            dhcpcd-configuration
            dhcpcd-configuration?
            dhcpcd-configuration-interfaces
            dhcpcd-configuration-command-args
            dhcpcd-configuration-hostname
            dhcpcd-configuration-duid
            dhcpcd-configuration-persistent
            dhcpcd-configuration-option
            dhcpcd-configuration-require
            dhcpcd-configuration-slaac
            dhcpcd-configuration-nooption
            dhcpcd-configuration-nohook
            dhcpcd-configuration-static
            dhcpcd-configuration-vendorclassid
            dhcpcd-configuration-clientid
            dhcpcd-configuration-extra-content))

;;
;; DHCPCD.
;;

(define (dhcpcd-serialize-string field-name value)
  (let ((field (object->string field-name)))
    (if (string=? field "extra-content")
      #~(string-append #$value "\n")
      #~(format #f "~a ~a~%" #$field #$value))))

(define (dhcpcd-serialize-boolean field-name value)
  (if value
    #~(format #f "~a~%" #$(object->string field-name))
    ""))

(define (dhcpcd-serialize-list-of-strings field-name value)
  #~(string-append #$@(map (cut dhcpcd-serialize-string field-name <>) value)))

;; Some fields (e.g. hostname) can be specified with an empty string argument.
;; Therefore, we need a maybe type to differentiate disabled/empty-string.
(define-maybe string (prefix dhcpcd-))

(define-configuration dhcpcd-configuration
  (interfaces
    (list '())
    "List of interfaces to start a DHCP client for."
    empty-serializer)
  (command-args
    (list '("-q" "-q"))
    "List of additional command-line options."
    empty-serializer)

  ;; The following defaults replicate the default dhcpcd configuration file.
  ;;
  ;; See https://github.com/NetworkConfiguration/dhcpcd/tree/v10.0.10#configuration
  (hostname
    (maybe-string "")
    "Hostname to send via DHCP, defaults to the current system hostname.")
  (duid
    (maybe-string "")
    "Use and generate a DHCP Unique Identifier.")
  (persistent
    (boolean #t)
    "Do not de-configure on shutdown.")
  (option
    (list-of-strings
      '("rapid_commit"
        "domain_name_servers"
        "domain_name"
        "domain_search"
        "host_name"
        "classless_static_routes"
        "interface_mtu"))
    "List of options to request from the server.")
  (require
    (list-of-strings '("dhcp_server_identifier"))
    "List of options to require in responses.")
  (slaac
    (maybe-string "private")
    "Interface identifier used for SLAAC generated IPv6 addresses.")

  ;; Common options not set in the default configuration file.
  (nooption
    (list-of-strings '())
    "List of options to remove from the message before it's processed.")
  (nohook
    (list-of-strings '())
    "List of hook script which should not be invoked.")
  (static
    (list-of-strings '())
    "Configure a static value (e.g. ip_address).")
  (vendorclassid
    maybe-string
    "Set the DHCP Vendor Class.")
  (clientid
    maybe-string
    "Use the interface hardware address or the given string as a Client ID.")

  ;; Escape hatch for the generated configuration file.
  (extra-content
    maybe-string
    "Extra content to append to the configuration as-is.")

  (prefix dhcpcd-))

(define (dhcpcd-config-file config)
  (mixed-text-file "dhcpcd.conf"
    (serialize-configuration
      config
      dhcpcd-configuration-fields)))

(define dhcpcd-account-service
  (list (user-group (name "dhcpcd") (system? #t))
        (user-account
          (name "dhcpcd")
          (group "dhcpcd")
          (system? #t)
          (comment "dhcpcd daemon user")
          (home-directory "/var/empty")
          (shell (file-append shadow "/sbin/nologin")))))

(define (dhcpcd-shepherd-service config)
  (let* ((config-file (dhcpcd-config-file config))
         (command-args (dhcpcd-configuration-command-args config))
         (ifaces (dhcpcd-configuration-interfaces config)))
    (list (shepherd-service
            (documentation "dhcpcd daemon.")
            (provision '(networking))
            (requirement '(user-processes udev))
            (actions (list (shepherd-configuration-action config-file)))
            (start
              #~(lambda _
                  (fork+exec-command
                    (list (string-append #$dhcpcd "/sbin/dhcpcd")
                          #$@command-args "-B" "-f" #$config-file #$@ifaces))))
            (stop #~(make-kill-destructor))))))

(define dhcpcd-service-type
  (service-type (name 'dhcpcd)
                (description "Run the dhcpcd daemon.")
                (extensions
                 (list (service-extension account-service-type
                                          (const dhcpcd-account-service))
                       (service-extension shepherd-root-service-type
                                          dhcpcd-shepherd-service)))
                (compose concatenate)
                (default-value (dhcpcd-configuration))))
