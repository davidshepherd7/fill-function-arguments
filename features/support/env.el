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



;; This fixes an issue in emacs 25.1 where the debugger would be invoked
;; incorrectly, breaking ert.
(when (and (= emacs-major-version 25) (< emacs-minor-version 2))
  (require 'cl-preloaded)
  (setf (symbol-function 'cl--assertion-failed)
        (lambda (form &optional string sargs args)
          "This function has been modified by espuds to remove an incorrect manual call
to the debugger in emacs 25.1. The modified version should only be used for
running the espuds tests."
          (if string
              (apply #'error string (append sargs args))
            (signal 'cl-assertion-failed `(,form ,@sargs))))))
