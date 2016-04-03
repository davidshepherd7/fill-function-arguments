;;; fill-function-arguments.el --- Convert function arguments to/from single line -*- lexical-binding: t; -*-

;; Copyright (C) 2015 Free Software Foundation, Inc.

;; Author: David Shepherd <davidshepherd7@gmail.com>
;; Version: 0.3
;; Package-Requires: ((names "20150618.0") (emacs "24.5"))
;; Keywords:
;; URL: https://github.com/davidshepherd7/fill-function-arguments

;;; Commentary:


;;; Code:

(require 'names)


;; namespacing using names.el:
;;;###autoload
(define-namespace fill-function-arguments-

;; Tell names that it's ok to expand things inside these threading macros.
:functionlike-macros (-->)



;;; Helpers

(defun max-line ()
  "Return the vertical position of point-max"
  (line-number-at-pos (point-max)))

(defun -opening-paren-location ()
  (nth 1 (syntax-ppss)))

(defun -paren-locations ()
  "Get a pair containing the enclosing parens"
  (let ((start (-opening-paren-location)))
    (when start
      (cons start
            ;; matching paren
            (save-excursion
              (goto-char start)
              (forward-sexp)
              (point))))))

(defun -narrow-to-funcall ()
  (interactive)
  (let ((l (-paren-locations)))
    (when l
      (narrow-to-region (car l) (cdr l)))
    t))

(defun -single-line-p()
  "Is the current function call on a single line?"
  (-narrow-to-funcall)
  (let ((out (equal (max-line) 1)))
    (widen)
    out))

  

;;; Main functions

  (defun to-single-line ()
    (interactive)
    (-narrow-to-funcall)
    (save-excursion
      (while (not (-single-line-p))
        (goto-char (point-max))
        (delete-indentation)))
    (widen))

  (defun to-multi-line ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      ;; (while (search-forward)))
      ))

  (defun fill-function-dwim ()
    (interactive)
    (if (-single-line-p)
        (to-multi-line)
      (to-single-line)))

  
  ) ; end of namespace

(provide 'fill-function-arguments)

;;; fill-function-arguments.el ends here
