;;; -*- lisp -*-
;;; Add ~/.emacs.d to load-path

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
