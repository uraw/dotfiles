;; http://butamamire.jp/blog/2008/01/10_ruby-mode.html
;; (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
;; (setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
;; (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

;; ruby-electric.el --- electric editing commands for ruby files
;(require 'ruby-electric)
;(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
;
;(setq ruby-indent-level 2)
;(setq ruby-indent-tabs-mode nil)
