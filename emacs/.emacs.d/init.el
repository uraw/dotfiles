;;; -*- lisp -*-
;;; Add ~/.emacs.d to load-path
(setq load-path
      (append
       (list
	(expand-file-name "~/.emacs.d/")
	(expand-file-name "~/.emacs.d/auto-install")
	)
       load-path))

;;; init-loader.el
;;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
;;; http://tech.kayac.com/archive/divide-dot-emacs.html
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
