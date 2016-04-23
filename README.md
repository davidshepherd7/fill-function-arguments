# fill-function-arguments
Add/remove line breaks between function arguments in C-like languages

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
    
and back. Also works with arrays (`[x, y, z]`).

If no function call is found `fill-function-arguments-dwim` will call `fill-paragraph`, 
so you can replace an existing `fill-paragraph` keybinding with it.

# Installation

Drop `fill-function-arguments.el` into your path and `require` it.

I haven't bothered to put this on melpa yet because I'm not sure if anyone else would use 
it... let me know if you want it on melpa.
