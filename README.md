# fill-function-arguments
Add/remove line breaks between function arguments and similar constructs

[![actions](https://github.com/davidshepherd7/fill-function-arguments/workflows/CI/badge.svg)](https://github.com/davidshepherd7/fill-function-arguments/actions)
[![MELPA](https://melpa.org/packages/fill-function-arguments-badge.svg)](https://melpa.org/#/fill-function-arguments)
[![MELPA stable](http://stable.melpa.org/packages/fill-function-arguments-badge.svg)](http://stable.melpa.org/#/fill-function-arguments)

# Usage

Put point inside the brackets and call `fill-function-arguments-dwim` to convert

    frobinate_foos(bar, baz, a_long_argument_just_for_fun, get_value(x, y))

to
    
    frobinate_foos(
        bar,
        baz,
        a_long_argument_just_for_fun,
        get_value(x, y)
    )
    
and back.

Also works with arrays (`[x, y, z]`) and dictionary literals (`{a: b, c: 1}`).

If no function call is found `fill-function-arguments-dwim` will call `fill-paragraph`, 
so you can replace an existing `fill-paragraph` keybinding with it.

Recommended binding:

    (add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "M-q") #'fill-function-arguments-dwim)))

(note: some modes, e.g. C-derived modes, bind their own fill paragraph function which will override this so for those modes you'll need to bind the key in that specific mode).

Also works well with html/xml tags with some customisation:

    (add-hook 'sgml-mode-hook (lambda ()
                              (setq-local fill-function-arguments-first-argument-same-line t)
                              (setq-local fill-function-arguments-argument-sep " ")
                              (local-set-key (kbd "M-q") #'fill-function-arguments-dwim)))

And for lisps:

    (add-hook 'emacs-lisp-mode-hook (lambda ()
                                      (setq-local fill-function-arguments-first-argument-same-line t)
                                      (setq-local fill-function-arguments-second-argument-same-line t)
                                      (setq-local fill-function-arguments-last-argument-same-line t)
                                      (setq-local fill-function-arguments-argument-separator " ")))


By default fill function arguments does not fix the indentation for you (I use
[aggressive-indent-mode](https://github.com/Malabarba/aggressive-indent-mode)
for this). You can enable automatic indentation after converting to the
multiline form by setting `fill-function-arguments-indent-after-fill` to `t`.

# Changelog

## Unstable

* Fix not passing along interactive arguments to fill-paragraph.

# Related

This is effectively the emacs version of
[vim-argwrap](https://github.com/FooSoft/vim-argwrap), although it was developed
completely independently.
