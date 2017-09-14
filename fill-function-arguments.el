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

(defcustom fall-through-to-fill-paragraph
  t
  "If true dwim will fill paragraphs when in comments or strings"
  :group 'fill-function-arguments)

(defcustom first-argument-same-line
  nil
  "If true keep the first argument on the same line as the opening paren (e.g. as needed by xml tags)"
  :group 'fill-function-arguments
  )

(defcustom second-argument-same-line
  nil
  "If true keep the second argument on the same line as the first argument.

e.g. as used in lisps like `(foo x
                                 bar)'"
  :group 'fill-function-arguments
  )

(defcustom last-argument-same-line
  nil
  "If true keep the last argument on the same line as the closing paren (e.g. as done in lisp)"
  :group 'fill-function-arguments
  )

(defcustom argument-separator
  ","
  "Character separating arguments"
  :group 'fill-function-arguments
  )



;;; Helpers

(defun -in-comment-p ()
  "Check if we are inside a comment"
  (nth 4 (syntax-ppss)))

(defun -in-docs-p ()
  "Check if we are inside a string or comment"
  (nth 8 (syntax-ppss)))

(defun -opening-paren-location ()
  (nth 1 (syntax-ppss)))

(defun -enclosing-paren ()
  "Return the opening parenthesis of the enclosing parens, or nil
        if not inside any parens."
  (let ((ppss (syntax-ppss)))
    (when (nth 1 ppss)
      (char-after (nth 1 ppss)))))

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
  (equal (line-number-at-pos (point-max)) 1))

(defun -suppress-argument-fill-p ()
  (and fall-through-to-fill-paragraph
       (or (-in-comment-p)
           (-in-docs-p)
           (and (not (derived-mode-p 'prog-mode))
                (or (not (derived-mode-p 'sgml-mode))
                    (not (equal (-enclosing-paren) ?<))))
           )))



;;; Main functions

(defun to-single-line ()
  (interactive)
  (save-excursion
    (save-restriction
      (-narrow-to-funcall)
      (while (not (-single-line-p))
        (goto-char (point-max))
        (delete-indentation)))))

(defun to-multi-line ()
  (interactive)
  (let ((initial-opening-paren (-opening-paren-location)))
    (save-excursion
      (save-restriction
        (-narrow-to-funcall)
        (goto-char (point-min))

        ;; newline after opening paren
        (forward-char)
        (when (not first-argument-same-line)
          (insert "\n"))

        (when second-argument-same-line
          ;; Just move point after the second argument before we start
          (search-forward argument-separator nil t))

        ;; Split the arguments
        (while (search-forward argument-separator nil t)
          ;; We have to save the match data here because the functions below
          ;; could (and sometimes do) modify it.
          (let ((saved-match-data (match-data)))
            (when (save-excursion (and (not (-in-docs-p))
                                       (equal (-opening-paren-location) initial-opening-paren)))
              (set-match-data saved-match-data)
              (replace-match (concat argument-separator "\n")))))

        ;; Newline before closing paren
        (when (not last-argument-same-line)
          (goto-char (point-max))
          (backward-char)
          (insert "\n"))))))

(defun dwim ()
  (interactive)
  (save-restriction
    (-narrow-to-funcall)
    (cond
     ((-suppress-argument-fill-p) (fill-paragraph))
     ((-single-line-p) (to-multi-line))
     (t (to-single-line)))))



  
  ) ; end of namespace

(provide 'fill-function-arguments)

;;; fill-function-arguments.el ends here
