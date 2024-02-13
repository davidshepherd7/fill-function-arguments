(require 'f)

(defvar fill-function-arguments-support-path
  (f-dirname load-file-name))

(defvar fill-function-arguments-features-path
  (f-parent fill-function-arguments-support-path))

(defvar fill-function-arguments-root-path
  (f-parent fill-function-arguments-features-path))

(add-to-list 'load-path fill-function-arguments-root-path)

(require 'fill-function-arguments)
(require 'espuds)
(require 'ert)

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )


(setq load-prefer-newer t)

