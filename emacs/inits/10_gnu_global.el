;;; GNU global-auto-complete-mode
;;; http://www.gnu.org/software/global/
(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))

(add-hook 'java-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))

(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\M-a" 'gtags-pop-stack)
         (local-set-key "\M-j" 'gtags-find-with-grep)
	 (local-set-key "\M-f" 'gtags-find-file)
         ))

(setq gtags-select-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\M-a" 'gtags-pop-stack)
         (local-set-key "\M-j" 'gtags-find-with-grep)
         ))

					; indent
(add-hook 'c-mode-hook
	  (lambda()
	    (message "hook")
	    (c-set-style "linux")
	    (setq tab-width 4)
	    (setq indent-tabs-mode nil)
	    (setq c-basic-offset tab-width)))

(add-hook 'c++-mode-hook
          (lambda()
            (message "hook")
            (c-set-style "linux")
            (setq tab-width 8)
            (setq indent-tabs-mode nil)))

(add-hook 'java-mode-hook
	  (lambda ()
	    (message "hook")
	    (setq tab-width 4)
	    (setq indent-tabs-mode nil)
	    (setq c-basic-offset tab-width)))

(global-font-lock-mode t)


