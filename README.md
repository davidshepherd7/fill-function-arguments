# fill-function-arguments
Add/remove line breaks between function arguments and similar constructs

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


Also works well with xml tags with some customisation:

      (add-hook 'sgml-mode-hook (lambda ()
                              (setq-local fill-function-arguments-first-argument-same-line t)
                              (setq-local fill-function-arguments-argument-sep " ")
                              (local-set-key (kbd "M-q") #'fill-function-arguments-dwim)))

Should work for lisp-like languages in a similar way, but I haven't tried this yet.


# Non-features

* Doesn't try to fix the indentation. I use aggressive-indent-mode which
  automatically does this after every operation. Would probably be tricky to
  implement this so I doubt I will.

* Doesn't try to clean up trailing whitespace. I use ws-butler to automatically
  clean it up. Could probably implement this without too much difficulty if
  someone wants it (open an issue if you do).



# Installation

Drop `fill-function-arguments.el` into your path and `require` it.

I haven't bothered to put this on melpa yet because I'm not sure if anyone else would use 
it... let me know if you want it on melpa.
