(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system qt)
             ((guix licenses)
              #:prefix license:)
             (gnu packages qt)
             (gnu packages gstreamer)
             (gnu packages sdl))

(package
  (name "pegasus-frontend")
  (version "weekly_2024w38")
  (source
   (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mmatyas/pegasus-frontend")
           (commit version)
           (recursive? #t)))
     (sha256
      (base32 "04773v3b50wya7w3hgy6j8sli07aimsfc8njqsycg9gbqygm183l"))
     (file-name (git-file-name name version))))
  (build-system qt-build-system)
  (arguments
   (list
    #:qtbase qtbase-5
    #:phases
    #~(modify-phases %standard-phases
        (add-after 'qt-wrap 'gst-wrap
          (lambda _
            (wrap-program (string-append #$output "/bin/pegasus-fe")
              `("GST_PLUGIN_SYSTEM_PATH" suffix
                (,(string-append #$gst-plugins-good "/lib/gstreamer-1.0"))))))
        (add-before 'check 'set-display
          (lambda _
            ;; Required for tests to not attempt to start an OpenGL context
            (setenv "QT_QUICK_BACKEND" "software"))))))
  (inputs (list sdl2
                qtbase-5
                qtsvg-5
                qtdeclarative-5
                qtgraphicaleffects
                qtmultimedia-5
                qtgamepad
                gst-plugins-good))
  (native-inputs (list qttools-5))
  (synopsis
   "A cross platform, customizable graphical frontend for launching emulators and managing your game collection.")
  (description
   "Pegasus is a graphical frontend for browsing your game library and launching all kinds of emulators from the same place. It's focusing on customizability, cross platform support (including embedded) and high performance.")
  (home-page "https://pegasus-frontend.org")
  (license license:gpl3))
