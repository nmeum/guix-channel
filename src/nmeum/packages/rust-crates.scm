(define-module (nmeum packages rust-crates)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages rust-crates)
  #:export (lookup-cargo-inputs))

(define rust-ahash-0.8.12
  (crate-source "ahash" "0.8.12"
                "0xbsp9rlm5ki017c0w6ay8kjwinwm8knjncci95mii30rmwz25as"))

(define rust-allocator-api2-0.2.21
  (crate-source "allocator-api2" "0.2.21"
                "08zrzs022xwndihvzdn78yqarv2b9696y67i6h78nla3ww87jgb8"))

(define rust-android-system-properties-0.1.5
  (crate-source "android_system_properties" "0.1.5"
                "04b3wrz12837j7mdczqd95b732gw5q7q66cv4yn4646lvccp57l1"))

(define rust-anyhow-1.0.102
  (crate-source "anyhow" "1.0.102"
                "0b447dra1v12z474c6z4jmicdmc5yxz5bakympdnij44ckw2s83z"))

(define rust-async-lock-3.4.2
  (crate-source "async-lock" "3.4.2"
                "04c3xrrdrfrvh9v0ajxrangpy38qi76qq268zslphnxxjqjpy3r9"))

(define rust-async-trait-0.1.89
  (crate-source "async-trait" "0.1.89"
                "1fsxxmz3rzx1prn1h3rs7kyjhkap60i7xvi0ldapkvbb14nssdch"))

(define rust-atomic-waker-1.1.2
  (crate-source "atomic-waker" "1.1.2"
                "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))

(define rust-autocfg-1.5.0
  (crate-source "autocfg" "1.5.0"
                "1s77f98id9l4af4alklmzq46f21c980v13z2r1pcxx6bqgw0d1n0"))

(define rust-base64-0.22.1
  (crate-source "base64" "0.22.1"
                "1imqzgh7bxcikp5vx3shqvw9j09g9ly0xr0jma0q66i52r7jbcvj"))

(define rust-bitflags-2.11.0
  (crate-source "bitflags" "2.11.0"
                "1bwjibwry5nfwsfm9kjg2dqx5n5nja9xymwbfl6svnn8jsz6ff44"))

(define rust-block-buffer-0.10.4
  (crate-source "block-buffer" "0.10.4"
                "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))

(define rust-bumpalo-3.20.2
  (crate-source "bumpalo" "3.20.2"
                "1jrgxlff76k9glam0akhwpil2fr1w32gbjdf5hpipc7ld2c7h82x"))

(define rust-bytes-1.11.1
  (crate-source "bytes" "1.11.1"
                "0czwlhbq8z29wq0ia87yass2mzy1y0jcasjb8ghriiybnwrqfx0y"))

(define rust-calcard-0.2.0
  (crate-source "calcard" "0.2.0"
                "0mdlgci96fghiw11qc5dsjcz6gcr9xcmck72nknglk40kwwk61xw"))

(define rust-camino-1.2.2
  (crate-source "camino" "1.2.2"
                "0j0ayqfbbl8bxg0795ssk1hzkjix3dvl2kk63hdgzf9cd5nscag6"))

(define rust-cc-1.2.56
  (crate-source "cc" "1.2.56"
                "1chvh9g2izhqad7vzy4cc7xpdljdvqpsr6x6hv1hmyqv3mlkbgxf"))

(define rust-cfg-if-1.0.4
  (crate-source "cfg-if" "1.0.4"
                "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))

(define rust-chrono-0.4.43
  (crate-source "chrono" "0.4.43"
                "06312amlyys4kkjazl13mbxw0j2f7zxygzjkr1yk7s2sn57p9i7s"))

(define rust-chrono-tz-0.10.4
  (crate-source "chrono-tz" "0.10.4"
                "1hr6rmdvqwgk748g2f69mnk97fzhdkfzaczvdn0wz4pdjy2rl4x6"))

(define rust-colored-3.1.1
  (crate-source "colored" "3.1.1"
                "0d5cpbgvyvmmky199s885s6385ykd75q6qg3d2kcxjxq563ldygs"))

(define rust-concurrent-queue-2.5.0
  (crate-source "concurrent-queue" "2.5.0"
                "0wrr3mzq2ijdkxwndhf79k952cp4zkz35ray8hvsxl96xrx1k82c"))

(define rust-core-foundation-0.10.1
  (crate-source "core-foundation" "0.10.1"
                "1xjns6dqf36rni2x9f47b65grxwdm20kwdg9lhmzdrrkwadcv9mj"))

(define rust-core-foundation-sys-0.8.7
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "core-foundation-sys" "0.8.7"
                "12w8j73lazxmr1z0h98hf3z623kl8ms7g07jch7n4p8f9nwlhdkp"))

(define rust-cpufeatures-0.2.17
  (crate-source "cpufeatures" "0.2.17"
                "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))

(define rust-crossbeam-channel-0.5.15
  (crate-source "crossbeam-channel" "0.5.15"
                "1cicd9ins0fkpfgvz9vhz3m9rpkh6n8d3437c3wnfsdkd3wgif42"))

(define rust-crossbeam-epoch-0.9.18
  (crate-source "crossbeam-epoch" "0.9.18"
                "03j2np8llwf376m3fxqx859mgp9f83hj1w34153c7a9c7i5ar0jv"))

(define rust-crossbeam-utils-0.8.21
  (crate-source "crossbeam-utils" "0.8.21"
                "0a3aa2bmc8q35fb67432w16wvi54sfmb69rk9h5bhd18vw0c99fh"))

(define rust-crypto-common-0.1.7
  (crate-source "crypto-common" "0.1.7"
                "02nn2rhfy7kvdkdjl457q2z0mklcvj9h662xrq6dzhfialh2kj3q"))

(define rust-deranged-0.5.8
  (crate-source "deranged" "0.5.8"
                "0711df3w16vx80k55ivkwzwswziinj4dz05xci3rvmn15g615n3w"))

(define rust-digest-0.10.7
  (crate-source "digest" "0.10.7"
                "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))

(define rust-domain-0.11.1
  (crate-source "domain" "0.11.1"
                "07fhv36a67zspjll1642v7gad635x70w3pqmzf350zfzh9gz2zvz"))

(define rust-domain-macros-0.11.1
  (crate-source "domain-macros" "0.11.1"
                "1dzmx31kqr3ans8vp0dipyb02i97mmk515cisq96h7s1mnb6f6ld"))

(define rust-equivalent-1.0.2
  (crate-source "equivalent" "1.0.2"
                "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))

(define rust-errno-0.3.14
  (crate-source "errno" "0.3.14"
                "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))

(define rust-event-listener-5.4.1
  (crate-source "event-listener" "5.4.1"
                "1asnp3agbr8shcl001yd935m167ammyi8hnvl0q1ycajryn6cfz1"))

(define rust-event-listener-strategy-0.5.4
  (crate-source "event-listener-strategy" "0.5.4"
                "14rv18av8s7n8yixg38bxp5vg2qs394rl1w052by5npzmbgz7scb"))

(define rust-fastrand-2.3.0
  (crate-source "fastrand" "2.3.0"
                "1ghiahsw1jd68df895cy5h3gzwk30hndidn3b682zmshpgmrx41p"))

(define rust-find-msvc-tools-0.1.9
  (crate-source "find-msvc-tools" "0.1.9"
                "10nmi0qdskq6l7zwxw5g56xny7hb624iki1c39d907qmfh3vrbjv"))

(define rust-foldhash-0.1.5
  (crate-source "foldhash" "0.1.5"
                "1wisr1xlc2bj7hk4rgkcjkz3j2x4dhd1h9lwk7mj8p71qpdgbi6r"))

(define rust-futures-channel-0.3.32
  (crate-source "futures-channel" "0.3.32"
                "07fcyzrmbmh7fh4ainilf1s7gnwvnk07phdq77jkb9fpa2ffifq7"))

(define rust-futures-core-0.3.32
  (crate-source "futures-core" "0.3.32"
                "07bbvwjbm5g2i330nyr1kcvjapkmdqzl4r6mqv75ivvjaa0m0d3y"))

(define rust-futures-macro-0.3.32
  (crate-source "futures-macro" "0.3.32"
                "0ys4b1lk7s0bsj29pv42bxsaavalch35rprp64s964p40c1bfdg8"))

(define rust-futures-task-0.3.32
  (crate-source "futures-task" "0.3.32"
                "14s3vqf8llz3kjza33vn4ixg6kwxp61xrysn716h0cwwsnri2xq3"))

(define rust-futures-util-0.3.32
  (crate-source "futures-util" "0.3.32"
                "1mn60lw5kh32hz9isinjlpw34zx708fk5q1x0m40n6g6jq9a971q"))

(define rust-generic-array-0.14.7
  (crate-source "generic-array" "0.14.7"
                "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))

(define rust-getrandom-0.2.17
  (crate-source "getrandom" "0.2.17"
                "1l2ac6jfj9xhpjjgmcx6s1x89bbnw9x6j9258yy6xjkzpq0bqapz"))

(define rust-getrandom-0.3.4
  (crate-source "getrandom" "0.3.4"
                "1zbpvpicry9lrbjmkd4msgj3ihff1q92i334chk7pzf46xffz7c9"))

(define rust-getrandom-0.4.1
  (crate-source "getrandom" "0.4.1"
                "1v7fm84f2jh6x7w3bd2ncl3sw29wnb0rhg7xya1pd30i02cg77hk"))

(define rust-hashbrown-0.14.5
  (crate-source "hashbrown" "0.14.5"
                "1wa1vy1xs3mp11bn3z9dv0jricgr6a2j0zkf1g19yz3vw4il89z5"))

(define rust-hashbrown-0.15.5
  (crate-source "hashbrown" "0.15.5"
                "189qaczmjxnikm9db748xyhiw04kpmhm9xj9k9hg0sgx7pjwyacj"))

(define rust-hashbrown-0.16.1
  (crate-source "hashbrown" "0.16.1"
                "004i3njw38ji3bzdp9z178ba9x3k0c1pgy8x69pj7yfppv4iq7c4"))

(define rust-hashify-0.2.7
  (crate-source "hashify" "0.2.7"
                "0k2x1vrkafnhhwk5y8yh6a835f81fizwpqygak9nm8mm1slkx7hl"))

(define rust-heck-0.5.0
  (crate-source "heck" "0.5.0"
                "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))

(define rust-hex-0.4.3
  (crate-source "hex" "0.4.3"
                "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))

(define rust-http-1.4.0
  (crate-source "http" "1.4.0"
                "06iind4cwsj1d6q8c2xgq8i2wka4ps74kmws24gsi1bzdlw2mfp3"))

(define rust-http-body-1.0.1
  (crate-source "http-body" "1.0.1"
                "111ir5k2b9ihz5nr9cz7cwm7fnydca7dx4hc7vr16scfzghxrzhy"))

(define rust-http-body-util-0.1.3
  (crate-source "http-body-util" "0.1.3"
                "0jm6jv4gxsnlsi1kzdyffjrj8cfr3zninnxpw73mvkxy4qzdj8dh"))

(define rust-httparse-1.10.1
  (crate-source "httparse" "1.10.1"
                "11ycd554bw2dkgw0q61xsa7a4jn1wb1xbfacmf3dbwsikvkkvgvd"))

(define rust-httpdate-1.0.3
  (crate-source "httpdate" "1.0.3"
                "1aa9rd2sac0zhjqh24c9xvir96g188zldkx0hr6dnnlx5904cfyz"))

(define rust-hyper-1.8.1
  (crate-source "hyper" "1.8.1"
                "04cxr8j5y86bhxxlyqb8xkxjskpajk7cxwfzzk4v3my3a3rd9cia"))

(define rust-hyper-rustls-0.27.7
  (crate-source "hyper-rustls" "0.27.7"
                "0n6g8998szbzhnvcs1b7ibn745grxiqmlpg53xz206v826v3xjg3"))

(define rust-hyper-util-0.1.20
  (crate-source "hyper-util" "0.1.20"
                "186zdc58hmm663csmjvrzgkr6jdh93sfmi3q2pxi57gcaqjpqm4n"))

(define rust-hyperlocal-0.9.1
  (crate-source "hyperlocal" "0.9.1"
                "1iy8rhsap5iyigj6s86nk449zl5bahjycy2mswy6nlllp7imqv4q"))

(define rust-iana-time-zone-0.1.65
  (crate-source "iana-time-zone" "0.1.65"
                "0w64khw5p8s4nzwcf36bwnsmqzf61vpwk9ca1920x82bk6nwj6z3"))

(define rust-iana-time-zone-haiku-0.1.2
  (crate-source "iana-time-zone-haiku" "0.1.2"
                "17r6jmj31chn7xs9698r122mapq85mfnv98bb4pg6spm0si2f67k"))

(define rust-id-arena-2.3.0
  (crate-source "id-arena" "2.3.0"
                "0m6rs0jcaj4mg33gkv98d71w3hridghp5c4yr928hplpkgbnfc1x"))

(define rust-indexmap-2.13.0
  (crate-source "indexmap" "2.13.0"
                "05qh5c4h2hrnyypphxpwflk45syqbzvqsvvyxg43mp576w2ff53p"))

(define rust-inotify-0.11.0
  (crate-source "inotify" "0.11.0"
                "1wq8m657rl085cg59p38sc5y62xy9yhhpvxbkd7n1awi4zzwqzgk"))

(define rust-inotify-sys-0.1.5
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "inotify-sys" "0.1.5"
                "1syhjgvkram88my04kv03s0zwa66mdwa5v7ddja3pzwvx2sh4p70"))

(define rust-itoa-1.0.17
  (crate-source "itoa" "1.0.17"
                "1lh93xydrdn1g9x547bd05g0d3hra7pd1k4jfd2z1pl1h5hwdv4j"))

(define rust-jmap-tools-0.1.4
  (crate-source "jmap-tools" "0.1.4"
                "1v9fiwc56ab7p8yhm25vv2g5yljj95ng05x64pfc996l3y3bf4qr"))

(define rust-js-sys-0.3.88
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "js-sys" "0.3.88"
                "0gaizs0fw0win4pjdd685i11i6r8mw0zyfjvqbwnca6jwgrhkry7"))

(define rust-leb128fmt-0.1.0
  (crate-source "leb128fmt" "0.1.0"
                "1chxm1484a0bly6anh6bd7a99sn355ymlagnwj3yajafnpldkv89"))

(define rust-lexopt-0.3.1
  (crate-source "lexopt" "0.3.1"
                "19zklfskhlvrfbl55h9g2a1v61k2jxcj4d1fqkk6nbxyzjhy584z"))

(define rust-libc-0.2.182
  (crate-source "libc" "0.2.182"
                "04k1w1mq9f4cxv520dbr5xw1i7xkbc9fcrvaggyjy25jdkdvl038"))

(define rust-libdav-0.10.2
  (crate-source "libdav" "0.10.2"
                "1ghjckhk8xsmmr67v2migfz3v9s6gag59rq9w4h3mzsaz7gnvvxr"))

(define rust-libjmap-0.1.1
  (crate-source "libjmap" "0.1.1"
                "0y8n9f22a940hl02zaq166dmqszf0apmc1dbgcvybdkvz1g3b264"))

(define rust-linux-raw-sys-0.12.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "linux-raw-sys" "0.12.1"
                "0lwasljrqxjjfk9l2j8lyib1babh2qjlnhylqzl01nihw14nk9ij"))

(define rust-lock-api-0.4.14
  (crate-source "lock_api" "0.4.14"
                "0rg9mhx7vdpajfxvdjmgmlyrn20ligzqvn8ifmaz7dc79gkrjhr2"))

(define rust-log-0.4.29
  (crate-source "log" "0.4.29"
                "15q8j9c8g5zpkcw0hnd6cf2z7fxqnvsjh3rw5mv5q10r83i34l2y"))

(define rust-mail-builder-0.4.4
  (crate-source "mail-builder" "0.4.4"
                "0fs7214f92cav734hi0n9cr6fh3q1dv4vccal89l131k0zrrh2ch"))

(define rust-mail-parser-0.11.2
  (crate-source "mail-parser" "0.11.2"
                "15w8zl8xmczfqqy5wlhspj9yw3x4wmp0lgk89jx96xb949jksapq"))

(define rust-memchr-2.8.0
  (crate-source "memchr" "2.8.0"
                "0y9zzxcqxvdqg6wyag7vc3h0blhdn7hkq164bxyx2vph8zs5ijpq"))

(define rust-mime-0.3.17
  (crate-source "mime" "0.3.17"
                "16hkibgvb9klh0w0jk5crr5xv90l3wlf77ggymzjmvl1818vnxv8"))

(define rust-mio-1.1.1
  (crate-source "mio" "1.1.1"
                "1z2phpalqbdgihrcjp8y09l3kgq6309jnhnr6h11l9s7mnqcm6x6"))

(define rust-moka-0.12.13
  (crate-source "moka" "0.12.13"
                "0zkbdywr87jh63cd2yds16lhdh82ic07lxp0dgpl9m6fa0n87b5l"))

(define rust-num-conv-0.2.0
  (crate-source "num-conv" "0.2.0"
                "0l4hj7lp8zbb9am4j3p7vlcv47y9bbazinvnxx9zjhiwkibyr5yg"))

(define rust-num-traits-0.2.19
  (crate-source "num-traits" "0.2.19"
                "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))

(define rust-octseq-0.5.2
  (crate-source "octseq" "0.5.2"
                "04pycbrcxlmhxqmrs4jgd0kqjk9pwjil6zr4fp2wwi4wgjikqv0j"))

(define rust-once-cell-1.21.3
  (crate-source "once_cell" "1.21.3"
                "0b9x77lb9f1j6nqgf5aka4s2qj0nly176bpbrv6f9iakk5ff3xa2"))

(define rust-openssl-probe-0.2.1
  (crate-source "openssl-probe" "0.2.1"
                "1gpwpb7smfhkscwvbri8xzbab39wcnby1jgz1s49vf1aqgsdx1vw"))

(define rust-parking-2.2.1
  (crate-source "parking" "2.2.1"
                "1fnfgmzkfpjd69v4j9x737b1k8pnn054bvzcn5dm3pkgq595d3gk"))

(define rust-parking-lot-0.12.5
  (crate-source "parking_lot" "0.12.5"
                "06jsqh9aqmc94j2rlm8gpccilqm6bskbd67zf6ypfc0f4m9p91ck"))

(define rust-parking-lot-core-0.9.12
  (crate-source "parking_lot_core" "0.9.12"
                "1hb4rggy70fwa1w9nb0svbyflzdc69h047482v2z3sx2hmcnh896"))

(define rust-phf-0.12.1
  (crate-source "phf" "0.12.1"
                "1dz85g1wshfca83mrq3va9rm9n8qcdjlpv1i3908y5zc9j4p6cli"))

(define rust-phf-shared-0.12.1
  (crate-source "phf_shared" "0.12.1"
                "10cr16wpmbjxd7w6k98sxw9yw3zxnzscybl9jzyq3digi045a006"))

(define rust-pin-project-lite-0.2.16
  (crate-source "pin-project-lite" "0.2.16"
                "16wzc7z7dfkf9bmjin22f5282783f6mdksnr0nv0j5ym5f9gyg1v"))

(define rust-pin-utils-0.1.0
  (crate-source "pin-utils" "0.1.0"
                "117ir7vslsl2z1a7qzhws4pd01cg2d3338c47swjyvqv2n60v1wb"))

(define rust-pkg-config-0.3.32
  (crate-source "pkg-config" "0.3.32"
                "0k4h3gnzs94sjb2ix6jyksacs52cf1fanpwsmlhjnwrdnp8dppby"))

(define rust-portable-atomic-1.13.1
  (crate-source "portable-atomic" "1.13.1"
                "0j8vlar3n5acyigq8q6f4wjx3k3s5yz0rlpqrv76j73gi5qr8fn3"))

(define rust-powerfmt-0.2.0
  (crate-source "powerfmt" "0.2.0"
                "14ckj2xdpkhv3h6l5sdmb9f1d57z8hbfpdldjc2vl5givq2y77j3"))

(define rust-ppv-lite86-0.2.21
  (crate-source "ppv-lite86" "0.2.21"
                "1abxx6qz5qnd43br1dd9b2savpihzjza8gb4fbzdql1gxp2f7sl5"))

(define rust-prettyplease-0.2.37
  (crate-source "prettyplease" "0.2.37"
                "0azn11i1kh0byabhsgab6kqs74zyrg69xkirzgqyhz6xmjnsi727"))

(define rust-proc-macro2-1.0.106
  (crate-source "proc-macro2" "1.0.106"
                "0d09nczyaj67x4ihqr5p7gxbkz38gxhk4asc0k8q23g9n85hzl4g"))

(define rust-quote-1.0.44
  (crate-source "quote" "1.0.44"
                "1r7c7hxl66vz3q9qizgjhy77pdrrypqgk4ghc7260xvvfb7ypci1"))

(define rust-r-efi-5.3.0
  (crate-source "r-efi" "5.3.0"
                "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))

(define rust-rand-0.8.5
  (crate-source "rand" "0.8.5"
                "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))

(define rust-rand-0.9.2
  (crate-source "rand" "0.9.2"
                "1lah73ainvrgl7brcxx0pwhpnqa3sm3qaj672034jz8i0q7pgckd"))

(define rust-rand-chacha-0.3.1
  (crate-source "rand_chacha" "0.3.1"
                "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))

(define rust-rand-chacha-0.9.0
  (crate-source "rand_chacha" "0.9.0"
                "1jr5ygix7r60pz0s1cv3ms1f6pd1i9pcdmnxzzhjc3zn3mgjn0nk"))

(define rust-rand-core-0.6.4
  (crate-source "rand_core" "0.6.4"
                "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))

(define rust-rand-core-0.9.5
  (crate-source "rand_core" "0.9.5"
                "0g6qc5r3f0hdmz9b11nripyp9qqrzb0xqk9piip8w8qlvqkcibvn"))

(define rust-redox-syscall-0.5.18
  (crate-source "redox_syscall" "0.5.18"
                "0b9n38zsxylql36vybw18if68yc9jczxmbyzdwyhb9sifmag4azd"))

(define rust-ring-0.17.14
  (crate-source "ring" "0.17.14"
                "1dw32gv19ccq4hsx3ribhpdzri1vnrlcfqb2vj41xn4l49n9ws54"))

(define rust-roxmltree-0.21.1
  (crate-source "roxmltree" "0.21.1"
                "1fxc3jgvl2rk05bw0hj86azqg6mzlijh06gyi9pw69b1qw84p5pi"))

(define rust-rustix-1.1.4
  (crate-source "rustix" "1.1.4"
                "14511f9yjqh0ix07xjrjpllah3325774gfwi9zpq72sip5jlbzmn"))

(define rust-rustls-0.23.36
  (crate-source "rustls" "0.23.36"
                "06w0077ssk3blpp93613lkny046mwj0nhxjgc7cmg9nf70yz6rf6"))

(define rust-rustls-native-certs-0.8.3
  (crate-source "rustls-native-certs" "0.8.3"
                "0qrajg2n90bcr3bcq6j95gjm7a9lirfkkdmjj32419dyyzan0931"))

(define rust-rustls-pki-types-1.14.0
  (crate-source "rustls-pki-types" "1.14.0"
                "1p9zsgslvwzzkzhm6bqicffqndr4jpx67992b0vl0pi21a5hy15y"))

(define rust-rustls-webpki-0.103.9
  (crate-source "rustls-webpki" "0.103.9"
                "0lwg1nnyv7pp2lfwwjhy81bxm233am99jnsp3iymdhd6k8827pyp"))

(define rust-rustversion-1.0.22
  (crate-source "rustversion" "1.0.22"
                "0vfl70jhv72scd9rfqgr2n11m5i9l1acnk684m2w83w0zbqdx75k"))

(define rust-scfg-0.3.1
  (crate-source "scfg" "0.3.1"
                "1xfqn2yy75jg0jzwh9x4bxfi575csgrjjym32sf93hhg9nmknf59"))

(define rust-schannel-0.1.28
  (crate-source "schannel" "0.1.28"
                "1qb6s5gyxfz2inz753a4z3mc1d266mwvz0c5w7ppd3h44swq27c9"))

(define rust-scopeguard-1.2.0
  (crate-source "scopeguard" "1.2.0"
                "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))

(define rust-security-framework-3.7.0
  (crate-source "security-framework" "3.7.0"
                "07fd0j29j8yczb3hd430vwz784lx9knb5xwbvqna1nbkbivvrx5p"))

(define rust-security-framework-sys-2.17.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "security-framework-sys" "2.17.0"
                "1qr0w0y9iwvmv3hwg653q1igngnc5b74xcf0679cbv23z0fnkqkc"))

(define rust-semver-1.0.27
  (crate-source "semver" "1.0.27"
                "1qmi3akfrnqc2hfkdgcxhld5bv961wbk8my3ascv5068mc5fnryp"))

(define rust-serde-1.0.228
  (crate-source "serde" "1.0.228"
                "17mf4hhjxv5m90g42wmlbc61hdhlm6j9hwfkpcnd72rpgzm993ls"))

(define rust-serde-core-1.0.228
  (crate-source "serde_core" "1.0.228"
                "1bb7id2xwx8izq50098s5j2sqrrvk31jbbrjqygyan6ask3qbls1"))

(define rust-serde-derive-1.0.228
  (crate-source "serde_derive" "1.0.228"
                "0y8xm7fvmr2kjcd029g9fijpndh8csv5m20g4bd76w8qschg4h6m"))

(define rust-serde-json-1.0.149
  (crate-source "serde_json" "1.0.149"
                "11jdx4vilzrjjd1dpgy67x5lgzr0laplz30dhv75lnf5ffa07z43"))

(define rust-sha1-smol-1.0.1
  (crate-source "sha1_smol" "1.0.1"
                "0pbh2xjfnzgblws3hims0ib5bphv7r5rfdpizyh51vnzvnribymv"))

(define rust-sha2-0.10.9
  (crate-source "sha2" "0.10.9"
                "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))

(define rust-shell-words-1.1.1
  (crate-source "shell-words" "1.1.1"
                "0xzd5p53xl0ndnk63r0by52rhdrh6pd37szfxszkg73zb6ffcvyw"))

(define rust-shlex-1.3.0
  (crate-source "shlex" "1.3.0"
                "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))

(define rust-simple-logger-5.2.0
  (crate-source "simple_logger" "5.2.0"
                "05qw0xv4ifhlpwd79gyrcqzndwynyrp6y6kyck7gj6v6jq78s0y7"))

(define rust-siphasher-1.0.2
  (crate-source "siphasher" "1.0.2"
                "13k7cfbpcm8qgj9p2n8dwg9skv9s0hxk5my30j5chy1p4l78bamj"))

(define rust-slab-0.4.12
  (crate-source "slab" "0.4.12"
                "1xcwik6s6zbd3lf51kkrcicdq2j4c1fw0yjdai2apy9467i0sy8c"))

(define rust-smallvec-1.15.1
  (crate-source "smallvec" "1.15.1"
                "00xxdxxpgyq5vjnpljvkmy99xij5rxgh913ii1v16kzynnivgcb7"))

(define rust-socket2-0.6.2
  (crate-source "socket2" "0.6.2"
                "1q073zkvz96h216mfz6niqk2kjqrgqv2va6zj34qh84zv4xamx46"))

(define rust-sqlite-0.37.0
  (crate-source "sqlite" "0.37.0"
                "10s7kkypkvnx5dkxdi1vaj8vby015irvmnqh757iadhrl40rqvpn"))

(define rust-sqlite3-src-0.7.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "sqlite3-src" "0.7.0"
                "081i23jsrmzna0j2q63sb4ipz8pllnb1fhlywqrhlsw8c34d7dp5"))

(define rust-sqlite3-sys-0.18.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "sqlite3-sys" "0.18.0"
                "0fbh4rjq4kc1mx6rigap6xzl5n7skbi9wyhjh581sfn1mnbisy57"))

(define rust-subtle-2.6.1
  (crate-source "subtle" "2.6.1"
                "14ijxaymghbl1p0wql9cib5zlwiina7kall6w7g89csprkgbvhhk"))

(define rust-syn-2.0.117
  (crate-source "syn" "2.0.117"
                "16cv7c0wbn8amxc54n4w15kxlx5ypdmla8s0gxr2l7bv7s0bhrg6"))

(define rust-sync-wrapper-1.0.2
  (crate-source "sync_wrapper" "1.0.2"
                "0qvjyasd6w18mjg5xlaq5jgy84jsjfsvmnn12c13gypxbv75dwhb"))

(define rust-tagptr-0.2.0
  (crate-source "tagptr" "0.2.0"
                "05r4mwvlsclx1ayj65hpzjv3dn4wpi8j4xm695vydccf9k7r683v"))

(define rust-tempfile-3.25.0
  (crate-source "tempfile" "3.25.0"
                "1wg5jnzbgpb1wmw396v31f0c70dvj5mpik7rk7fzdccmghgpjdh1"))

(define rust-thiserror-2.0.18
  (crate-source "thiserror" "2.0.18"
                "1i7vcmw9900bvsmay7mww04ahahab7wmr8s925xc083rpjybb222"))

(define rust-thiserror-impl-2.0.18
  (crate-source "thiserror-impl" "2.0.18"
                "1mf1vrbbimj1g6dvhdgzjmn6q09yflz2b92zs1j9n3k7cxzyxi7b"))

(define rust-time-0.3.47
  (crate-source "time" "0.3.47"
                "0b7g9ly2iabrlgizliz6v5x23yq5d6bpp0mqz6407z1s526d8fvl"))

(define rust-time-core-0.1.8
  (crate-source "time-core" "0.1.8"
                "1jidl426mw48i7hjj4hs9vxgd9lwqq4vyalm4q8d7y4iwz7y353n"))

(define rust-tokio-1.49.0
  (crate-source "tokio" "1.49.0"
                "11ix3pl03s0bp71q3wddrbf8xr0cpn47d7fzr6m42r3kswy918kj"))

(define rust-tokio-macros-2.6.0
  (crate-source "tokio-macros" "2.6.0"
                "19czvgliginbzyhhfbmj77wazqn2y8g27y2nirfajdlm41bphh5g"))

(define rust-tokio-rustls-0.26.4
  (crate-source "tokio-rustls" "0.26.4"
                "0qggwknz9w4bbsv1z158hlnpkm97j3w8v31586jipn99byaala8p"))

(define rust-tower-0.5.3
  (crate-source "tower" "0.5.3"
                "1m5i3a2z1sgs8nnz1hgfq2nr4clpdmizlp1d9qsg358ma5iyzrgb"))

(define rust-tower-http-0.6.8
  (crate-source "tower-http" "0.6.8"
                "1y514jwzbyrmrkbaajpwmss4rg0mak82k16d6588w9ncaffmbrnl"))

(define rust-tower-layer-0.3.3
  (crate-source "tower-layer" "0.3.3"
                "03kq92fdzxin51w8iqix06dcfgydyvx7yr6izjq0p626v9n2l70j"))

(define rust-tower-service-0.3.3
  (crate-source "tower-service" "0.3.3"
                "1hzfkvkci33ra94xjx64vv3pp0sq346w06fpkcdwjcid7zhvdycd"))

(define rust-tracing-0.1.44
  (crate-source "tracing" "0.1.44"
                "006ilqkg1lmfdh3xhg3z762izfwmxcvz0w7m4qx2qajbz9i1drv3"))

(define rust-tracing-attributes-0.1.31
  (crate-source "tracing-attributes" "0.1.31"
                "1np8d77shfvz0n7camx2bsf1qw0zg331lra0hxb4cdwnxjjwz43l"))

(define rust-tracing-core-0.1.36
  (crate-source "tracing-core" "0.1.36"
                "16mpbz6p8vd6j7sf925k9k8wzvm9vdfsjbynbmaxxyq6v7wwm5yv"))

(define rust-try-lock-0.2.5
  (crate-source "try-lock" "0.2.5"
                "0jqijrrvm1pyq34zn1jmy2vihd4jcrjlvsh4alkjahhssjnsn8g4"))

(define rust-typenum-1.19.0
  (crate-source "typenum" "1.19.0"
                "1fw2mpbn2vmqan56j1b3fbpcdg80mz26fm53fs16bq5xcq84hban"))

(define rust-unicode-ident-1.0.24
  (crate-source "unicode-ident" "1.0.24"
                "0xfs8y1g7syl2iykji8zk5hgfi5jw819f5zsrbaxmlzwsly33r76"))

(define rust-unicode-xid-0.2.6
  (crate-source "unicode-xid" "0.2.6"
                "0lzqaky89fq0bcrh6jj6bhlz37scfd8c7dsj5dq7y32if56c1hgb"))

(define rust-untrusted-0.9.0
  (crate-source "untrusted" "0.9.0"
                "1ha7ib98vkc538x0z60gfn0fc5whqdd85mb87dvisdcaifi6vjwf"))

(define rust-uuid-1.21.0
  (crate-source "uuid" "1.21.0"
                "1nsxfd17gfkvl1jmwcy5lnq6z32b8kf19is04byl6b95an2k6wmn"))

(define rust-version-check-0.9.5
  (crate-source "version_check" "0.9.5"
                "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))

(define rust-vparser-1.2.0
  (crate-source "vparser" "1.2.0"
                "1f4al4x8mfcaychbhirgs3l5zdqibcpimbmml7mfv3af6vynhdkz"))

(define rust-vstorage-0.6.0
  (crate-source "vstorage" "0.6.0"
                "1r76s7dd8jgs1j3yqr0iffshnksiiw104sa44cqkv7zamb1q6fiz"))

(define rust-want-0.3.1
  (crate-source "want" "0.3.1"
                "03hbfrnvqqdchb5kgxyavb9jabwza0dmh2vw5kg0dq8rxl57d9xz"))

(define rust-wasi-0.11.1+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.1+wasi-snapshot-preview1"
                "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))

(define rust-wasip2-1.0.2+wasi-0.2.9
  (crate-source "wasip2" "1.0.2+wasi-0.2.9"
                "1xdw7v08jpfjdg94sp4lbdgzwa587m5ifpz6fpdnkh02kwizj5wm"))

(define rust-wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06
  (crate-source "wasip3" "0.4.0+wasi-0.3.0-rc-2026-01-06"
                "19dc8p0y2mfrvgk3qw3c3240nfbylv22mvyxz84dqpgai2zzha2l"))

(define rust-wasm-bindgen-0.2.111
  (crate-source "wasm-bindgen" "0.2.111"
                "1b6qxm8wps17izn08b9xhiz1swzx38mpj5zq4iw5nbv76laxy6pc"))

(define rust-wasm-bindgen-macro-0.2.111
  (crate-source "wasm-bindgen-macro" "0.2.111"
                "1cdk8sjmzzsvlzpz8pv9aj4m8l0l16ibklnlmriidch8ghqkirhr"))

(define rust-wasm-bindgen-macro-support-0.2.111
  (crate-source "wasm-bindgen-macro-support" "0.2.111"
                "1bq2j60bajjf4ldsbflgsc0izwc8r5pyjmslyvah6k8ia047cr1c"))

(define rust-wasm-bindgen-shared-0.2.111
  (crate-source "wasm-bindgen-shared" "0.2.111"
                "0hfa42772ycq8b180w6k7ax8jn246r50pc4y6fiwyxv1w97wvvk0"))

(define rust-wasm-encoder-0.244.0
  (crate-source "wasm-encoder" "0.244.0"
                "06c35kv4h42vk3k51xjz1x6hn3mqwfswycmr6ziky033zvr6a04r"))

(define rust-wasm-metadata-0.244.0
  (crate-source "wasm-metadata" "0.244.0"
                "02f9dhlnryd2l7zf03whlxai5sv26x4spfibjdvc3g9gd8z3a3mv"))

(define rust-wasmparser-0.244.0
  (crate-source "wasmparser" "0.244.0"
                "1zi821hrlsxfhn39nqpmgzc0wk7ax3dv6vrs5cw6kb0v5v3hgf27"))

(define rust-windows-aarch64-gnullvm-0.52.6
  (crate-source "windows_aarch64_gnullvm" "0.52.6"
                "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))

(define rust-windows-aarch64-gnullvm-0.53.1
  (crate-source "windows_aarch64_gnullvm" "0.53.1"
                "0lqvdm510mka9w26vmga7hbkmrw9glzc90l4gya5qbxlm1pl3n59"))

(define rust-windows-aarch64-msvc-0.52.6
  (crate-source "windows_aarch64_msvc" "0.52.6"
                "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))

(define rust-windows-aarch64-msvc-0.53.1
  (crate-source "windows_aarch64_msvc" "0.53.1"
                "01jh2adlwx043rji888b22whx4bm8alrk3khjpik5xn20kl85mxr"))

(define rust-windows-core-0.62.2
  (crate-source "windows-core" "0.62.2"
                "1swxpv1a8qvn3bkxv8cn663238h2jccq35ff3nsj61jdsca3ms5q"))

(define rust-windows-i686-gnu-0.52.6
  (crate-source "windows_i686_gnu" "0.52.6"
                "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))

(define rust-windows-i686-gnu-0.53.1
  (crate-source "windows_i686_gnu" "0.53.1"
                "18wkcm82ldyg4figcsidzwbg1pqd49jpm98crfz0j7nqd6h6s3ln"))

(define rust-windows-i686-gnullvm-0.52.6
  (crate-source "windows_i686_gnullvm" "0.52.6"
                "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))

(define rust-windows-i686-gnullvm-0.53.1
  (crate-source "windows_i686_gnullvm" "0.53.1"
                "030qaxqc4salz6l4immfb6sykc6gmhyir9wzn2w8mxj8038mjwzs"))

(define rust-windows-i686-msvc-0.52.6
  (crate-source "windows_i686_msvc" "0.52.6"
                "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))

(define rust-windows-i686-msvc-0.53.1
  (crate-source "windows_i686_msvc" "0.53.1"
                "1hi6scw3mn2pbdl30ji5i4y8vvspb9b66l98kkz350pig58wfyhy"))

(define rust-windows-implement-0.60.2
  (crate-source "windows-implement" "0.60.2"
                "1psxhmklzcf3wjs4b8qb42qb6znvc142cb5pa74rsyxm1822wgh5"))

(define rust-windows-interface-0.59.3
  (crate-source "windows-interface" "0.59.3"
                "0n73cwrn4247d0axrk7gjp08p34x1723483jxjxjdfkh4m56qc9z"))

(define rust-windows-link-0.2.1
  (crate-source "windows-link" "0.2.1"
                "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))

(define rust-windows-result-0.4.1
  (crate-source "windows-result" "0.4.1"
                "1d9yhmrmmfqh56zlj751s5wfm9a2aa7az9rd7nn5027nxa4zm0bp"))

(define rust-windows-strings-0.5.1
  (crate-source "windows-strings" "0.5.1"
                "14bhng9jqv4fyl7lqjz3az7vzh8pw0w4am49fsqgcz67d67x0dvq"))

(define rust-windows-sys-0.52.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.52.0"
                "0gd3v4ji88490zgb6b5mq5zgbvwv7zx1ibn8v3x83rwcdbryaar8"))

(define rust-windows-sys-0.60.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.60.2"
                "1jrbc615ihqnhjhxplr2kw7rasrskv9wj3lr80hgfd42sbj01xgj"))

(define rust-windows-sys-0.61.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.61.2"
                "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))

(define rust-windows-targets-0.52.6
  (crate-source "windows-targets" "0.52.6"
                "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))

(define rust-windows-targets-0.53.5
  (crate-source "windows-targets" "0.53.5"
                "1wv9j2gv3l6wj3gkw5j1kr6ymb5q6dfc42yvydjhv3mqa7szjia9"))

(define rust-windows-x86-64-gnu-0.52.6
  (crate-source "windows_x86_64_gnu" "0.52.6"
                "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))

(define rust-windows-x86-64-gnu-0.53.1
  (crate-source "windows_x86_64_gnu" "0.53.1"
                "16d4yiysmfdlsrghndr97y57gh3kljkwhfdbcs05m1jasz6l4f4w"))

(define rust-windows-x86-64-gnullvm-0.52.6
  (crate-source "windows_x86_64_gnullvm" "0.52.6"
                "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))

(define rust-windows-x86-64-gnullvm-0.53.1
  (crate-source "windows_x86_64_gnullvm" "0.53.1"
                "1qbspgv4g3q0vygkg8rnql5c6z3caqv38japiynyivh75ng1gyhg"))

(define rust-windows-x86-64-msvc-0.52.6
  (crate-source "windows_x86_64_msvc" "0.52.6"
                "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))

(define rust-windows-x86-64-msvc-0.53.1
  (crate-source "windows_x86_64_msvc" "0.53.1"
                "0l6npq76vlq4ksn4bwsncpr8508mk0gmznm6wnhjg95d19gzzfyn"))

(define rust-wit-bindgen-0.51.0
  (crate-source "wit-bindgen" "0.51.0"
                "19fazgch8sq5cvjv3ynhhfh5d5x08jq2pkw8jfb05vbcyqcr496p"))

(define rust-wit-bindgen-core-0.51.0
  (crate-source "wit-bindgen-core" "0.51.0"
                "1p2jszqsqbx8k7y8nwvxg65wqzxjm048ba5phaq8r9iy9ildwqga"))

(define rust-wit-bindgen-rust-0.51.0
  (crate-source "wit-bindgen-rust" "0.51.0"
                "08bzn5fsvkb9x9wyvyx98qglknj2075xk1n7c5jxv15jykh6didp"))

(define rust-wit-bindgen-rust-macro-0.51.0
  (crate-source "wit-bindgen-rust-macro" "0.51.0"
                "0ymizapzv2id89igxsz2n587y2hlfypf6n8kyp68x976fzyrn3qc"))

(define rust-wit-component-0.244.0
  (crate-source "wit-component" "0.244.0"
                "1clwxgsgdns3zj2fqnrjcp8y5gazwfa1k0sy5cbk0fsmx4hflrlx"))

(define rust-wit-parser-0.244.0
  (crate-source "wit-parser" "0.244.0"
                "0dm7avvdxryxd5b02l0g5h6933z1cw5z0d4wynvq2cywq55srj7c"))

(define rust-zerocopy-0.8.39
  (crate-source "zerocopy" "0.8.39"
                "0jmf1iqns5sq07k3dscsgyc706pycar67rrq4j9nrnzacgb3avfv"))

(define rust-zerocopy-derive-0.8.39
  (crate-source "zerocopy-derive" "0.8.39"
                "05z5yfq0mx3xdqadrgq5sd4d03nl82d9r0vp1qchaip9d4qws8j1"))

(define rust-zeroize-1.8.2
  (crate-source "zeroize" "1.8.2"
                "1l48zxgcv34d7kjskr610zqsm6j2b4fcr2vfh9jm9j1jgvk58wdr"))

(define rust-zmij-1.0.21
  (crate-source "zmij" "1.0.21"
                "1amb5i6gz7yjb0dnmz5y669674pqmwbj44p4yfxfv2ncgvk8x15q"))

(define-cargo-inputs lookup-cargo-inputs
                     (pimsync =>
                              (list rust-ahash-0.8.12
                               rust-allocator-api2-0.2.21
                               rust-android-system-properties-0.1.5
                               rust-anyhow-1.0.102
                               rust-async-lock-3.4.2
                               rust-async-trait-0.1.89
                               rust-atomic-waker-1.1.2
                               rust-autocfg-1.5.0
                               rust-base64-0.22.1
                               rust-bitflags-2.11.0
                               rust-block-buffer-0.10.4
                               rust-bumpalo-3.20.2
                               rust-bytes-1.11.1
                               rust-calcard-0.2.0
                               rust-camino-1.2.2
                               rust-cc-1.2.56
                               rust-cfg-if-1.0.4
                               rust-chrono-0.4.43
                               rust-chrono-tz-0.10.4
                               rust-colored-3.1.1
                               rust-concurrent-queue-2.5.0
                               rust-core-foundation-0.10.1
                               rust-core-foundation-sys-0.8.7
                               rust-cpufeatures-0.2.17
                               rust-crossbeam-channel-0.5.15
                               rust-crossbeam-epoch-0.9.18
                               rust-crossbeam-utils-0.8.21
                               rust-crypto-common-0.1.7
                               rust-deranged-0.5.8
                               rust-digest-0.10.7
                               rust-domain-0.11.1
                               rust-domain-macros-0.11.1
                               rust-equivalent-1.0.2
                               rust-errno-0.3.14
                               rust-event-listener-5.4.1
                               rust-event-listener-strategy-0.5.4
                               rust-fastrand-2.3.0
                               rust-find-msvc-tools-0.1.9
                               rust-foldhash-0.1.5
                               rust-futures-channel-0.3.32
                               rust-futures-core-0.3.32
                               rust-futures-macro-0.3.32
                               rust-futures-task-0.3.32
                               rust-futures-util-0.3.32
                               rust-generic-array-0.14.7
                               rust-getrandom-0.2.17
                               rust-getrandom-0.3.4
                               rust-getrandom-0.4.1
                               rust-hashbrown-0.14.5
                               rust-hashbrown-0.15.5
                               rust-hashbrown-0.16.1
                               rust-hashify-0.2.7
                               rust-heck-0.5.0
                               rust-hex-0.4.3
                               rust-http-1.4.0
                               rust-http-body-1.0.1
                               rust-http-body-util-0.1.3
                               rust-httparse-1.10.1
                               rust-httpdate-1.0.3
                               rust-hyper-1.8.1
                               rust-hyper-rustls-0.27.7
                               rust-hyper-util-0.1.20
                               rust-hyperlocal-0.9.1
                               rust-iana-time-zone-0.1.65
                               rust-iana-time-zone-haiku-0.1.2
                               rust-id-arena-2.3.0
                               rust-indexmap-2.13.0
                               rust-inotify-0.11.0
                               rust-inotify-sys-0.1.5
                               rust-itoa-1.0.17
                               rust-jmap-tools-0.1.4
                               rust-js-sys-0.3.88
                               rust-leb128fmt-0.1.0
                               rust-lexopt-0.3.1
                               rust-libc-0.2.182
                               rust-libdav-0.10.2
                               rust-libjmap-0.1.1
                               rust-linux-raw-sys-0.12.1
                               rust-lock-api-0.4.14
                               rust-log-0.4.29
                               rust-mail-builder-0.4.4
                               rust-mail-parser-0.11.2
                               rust-memchr-2.8.0
                               rust-mime-0.3.17
                               rust-mio-1.1.1
                               rust-moka-0.12.13
                               rust-num-conv-0.2.0
                               rust-num-traits-0.2.19
                               rust-octseq-0.5.2
                               rust-once-cell-1.21.3
                               rust-openssl-probe-0.2.1
                               rust-parking-2.2.1
                               rust-parking-lot-0.12.5
                               rust-parking-lot-core-0.9.12
                               rust-phf-0.12.1
                               rust-phf-shared-0.12.1
                               rust-pin-project-lite-0.2.16
                               rust-pin-utils-0.1.0
                               rust-pkg-config-0.3.32
                               rust-portable-atomic-1.13.1
                               rust-powerfmt-0.2.0
                               rust-ppv-lite86-0.2.21
                               rust-prettyplease-0.2.37
                               rust-proc-macro2-1.0.106
                               rust-quote-1.0.44
                               rust-r-efi-5.3.0
                               rust-rand-0.8.5
                               rust-rand-0.9.2
                               rust-rand-chacha-0.3.1
                               rust-rand-chacha-0.9.0
                               rust-rand-core-0.6.4
                               rust-rand-core-0.9.5
                               rust-redox-syscall-0.5.18
                               rust-ring-0.17.14
                               rust-roxmltree-0.21.1
                               rust-rustix-1.1.4
                               rust-rustls-0.23.36
                               rust-rustls-native-certs-0.8.3
                               rust-rustls-pki-types-1.14.0
                               rust-rustls-webpki-0.103.9
                               rust-rustversion-1.0.22
                               rust-scfg-0.3.1
                               rust-schannel-0.1.28
                               rust-scopeguard-1.2.0
                               rust-security-framework-3.7.0
                               rust-security-framework-sys-2.17.0
                               rust-semver-1.0.27
                               rust-serde-1.0.228
                               rust-serde-core-1.0.228
                               rust-serde-derive-1.0.228
                               rust-serde-json-1.0.149
                               rust-sha1-smol-1.0.1
                               rust-sha2-0.10.9
                               rust-shell-words-1.1.1
                               rust-shlex-1.3.0
                               rust-simple-logger-5.2.0
                               rust-siphasher-1.0.2
                               rust-slab-0.4.12
                               rust-smallvec-1.15.1
                               rust-socket2-0.6.2
                               rust-sqlite-0.37.0
                               rust-sqlite3-src-0.7.0
                               rust-sqlite3-sys-0.18.0
                               rust-subtle-2.6.1
                               rust-syn-2.0.117
                               rust-sync-wrapper-1.0.2
                               rust-tagptr-0.2.0
                               rust-tempfile-3.25.0
                               rust-thiserror-2.0.18
                               rust-thiserror-impl-2.0.18
                               rust-time-0.3.47
                               rust-time-core-0.1.8
                               rust-tokio-1.49.0
                               rust-tokio-macros-2.6.0
                               rust-tokio-rustls-0.26.4
                               rust-tower-0.5.3
                               rust-tower-http-0.6.8
                               rust-tower-layer-0.3.3
                               rust-tower-service-0.3.3
                               rust-tracing-0.1.44
                               rust-tracing-attributes-0.1.31
                               rust-tracing-core-0.1.36
                               rust-try-lock-0.2.5
                               rust-typenum-1.19.0
                               rust-unicode-ident-1.0.24
                               rust-unicode-xid-0.2.6
                               rust-untrusted-0.9.0
                               rust-uuid-1.21.0
                               rust-version-check-0.9.5
                               rust-vparser-1.2.0
                               rust-vstorage-0.6.0
                               rust-want-0.3.1
                               rust-wasi-0.11.1+wasi-snapshot-preview1
                               rust-wasip2-1.0.2+wasi-0.2.9
                               rust-wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06
                               rust-wasm-bindgen-0.2.111
                               rust-wasm-bindgen-macro-0.2.111
                               rust-wasm-bindgen-macro-support-0.2.111
                               rust-wasm-bindgen-shared-0.2.111
                               rust-wasm-encoder-0.244.0
                               rust-wasm-metadata-0.244.0
                               rust-wasmparser-0.244.0
                               rust-windows-core-0.62.2
                               rust-windows-implement-0.60.2
                               rust-windows-interface-0.59.3
                               rust-windows-link-0.2.1
                               rust-windows-result-0.4.1
                               rust-windows-strings-0.5.1
                               rust-windows-sys-0.52.0
                               rust-windows-sys-0.60.2
                               rust-windows-sys-0.61.2
                               rust-windows-targets-0.52.6
                               rust-windows-targets-0.53.5
                               rust-windows-aarch64-gnullvm-0.52.6
                               rust-windows-aarch64-gnullvm-0.53.1
                               rust-windows-aarch64-msvc-0.52.6
                               rust-windows-aarch64-msvc-0.53.1
                               rust-windows-i686-gnu-0.52.6
                               rust-windows-i686-gnu-0.53.1
                               rust-windows-i686-gnullvm-0.52.6
                               rust-windows-i686-gnullvm-0.53.1
                               rust-windows-i686-msvc-0.52.6
                               rust-windows-i686-msvc-0.53.1
                               rust-windows-x86-64-gnu-0.52.6
                               rust-windows-x86-64-gnu-0.53.1
                               rust-windows-x86-64-gnullvm-0.52.6
                               rust-windows-x86-64-gnullvm-0.53.1
                               rust-windows-x86-64-msvc-0.52.6
                               rust-windows-x86-64-msvc-0.53.1
                               rust-wit-bindgen-0.51.0
                               rust-wit-bindgen-core-0.51.0
                               rust-wit-bindgen-rust-0.51.0
                               rust-wit-bindgen-rust-macro-0.51.0
                               rust-wit-component-0.244.0
                               rust-wit-parser-0.244.0
                               rust-zerocopy-0.8.39
                               rust-zerocopy-derive-0.8.39
                               rust-zeroize-1.8.2
                               rust-zmij-1.0.21)))
