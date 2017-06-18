;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")


;; load the packaged named xclip.
(load "xclip") ;; best not to include the ending “.el” or “.elc”


(turn-on-xclip)

(setq-default case-fold-search nil)
