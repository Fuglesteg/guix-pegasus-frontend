(use-modules (guix packages)
             (guix git-download)
             (guix build-system qt)
             ((guix licenses) #:prefix license:)
             (gnu packages qt)
             (gnu packages cmake)
             (gnu packages sdl))

 (let ((commit "cc2497abf7ebb12e0cbdb57a16addaf62d6f50bd")
       (revision "1"))
   (package
    (name "pegasus-frontend")
    (version (git-version "0.1" revision commit))
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/mmatyas/pegasus-frontend")
            (commit commit)
            (recursive? #t)))
      (sha256 (base32 "01p1nyqh7rqhap0qsc1b3y8kfqgpzia60cvdg6p927sv42mzmpw9"))
      (file-name (git-file-name name version))))
    (build-system qt-build-system)
    (arguments (list #:qtbase qtbase-5 #:tests? #f))
    (inputs (list sdl2
                  qtsvg-5
                  qttools-5
                  qtdeclarative-5
                  qtgraphicaleffects
                  qtmultimedia-5))
    (synopsis "") (description "") (license license:expat) (home-page "")))

