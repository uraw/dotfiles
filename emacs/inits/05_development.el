;;; fuzzy-format.el
;;; http://www.emacswiki.org/emacs/FuzzyFormat
(require 'fuzzy-format)
(setq fuzzy-format-default-indent-tabs-mode nil)
(setq fuzzy-format-auto-indent t)
(global-fuzzy-format-mode t)

;; Show function name which I'm in
;; http://www.cozmixng.org/~kou/emacs/dot_emacs
(require 'which-func)
;(which-func-mode t)
(which-function-mode)
(eval-after-load "which-func"
  '(setq which-func-modes '(java-mode)))
;(setq which-func-modes (append which-func-modes '(java-mode)))

;;; auto-complete.el
;;; http://www.emacswiki.org/emacs/AutoComplete
(require 'auto-complete)
(global-auto-complete-mode t)

;;; ruby-electric
;;; https://github.com/qoobaa/ruby-electric/raw/master/ruby-electric.el
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;;; ruby-block
;;; https://github.com/adolfosousa/ruby-block.el/raw/master/ruby-block.el
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;;; python indentation
;;; http://q.hatena.ne.jp/1189586222
(add-hook 'python-mode-hook
	  (lambda ()
	    (setq tab-width 4)
	    (setq python-indent 4)
	    (setq indent-tabs-mode nil)
	    (define-key (current-local-map) "\C-h" 'python-backspace)
	    ))

;;; magit-status
;;; https://magit.vc/manual/magit.html#Getting-Started
(global-set-key (kbd "C-x g") 'magit-status)
