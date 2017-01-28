EMACS=emacs
CASK ?= cask

build :
	cask exec $(EMACS) -Q --batch --eval             \
	    "(progn                                \
	      (setq byte-compile-error-on-warn t)  \
	      (batch-byte-compile))" fill-function-arguments.el

clean :
	@rm -f *.elc

ecukes: build
	${CASK} exec ecukes

test: build
	${CASK} exec ecukes

install:
	${CASK} install

.PHONY:	all unit ecukes install clean build
