;;; don't show boot message
(setq inhibit-startup-message t)

;;; don't beep and don't flash display
;;; http://homepage.mac.com/zenitani/elisp-j.htm
(setq ring-bell-function 'ignore)

;;; treat escape-sequence
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set 'ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; bold the matching parens
(show-paren-mode)

;;; show column number
(column-number-mode t)

;;; Hide password on shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;;; Remove menu bar when emacs was launch with -nw option
;;; http://www.cozmixng.org/~kou/emacs/dot_emacs
(if window-system (menu-bar-mode 1) (menu-bar-mode -1))


;;; disable line folding back
;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=truncate-lines
(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)

;;; Emacs 23のwhitespaceを使って、jaspace.elのように全角スペースを表示する方法
;;; http://d.hatena.ne.jp/tunefs/20100811/p1
(setq whitespace-style
      '(tabs spaces space-mark))
(setq whitespace-space-regexp "\\( +\\|\u3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])))
(require 'whitespace)
(global-whitespace-mode 1)

;;; Enable linum-mode always
;;; http://stackoverflow.com/questions/2034470/how-do-i-enable-line-numbers-on-the-left-everytime-i-open-emacs
(global-linum-mode t)
(global-set-key "\C-cl" 'linum-mode)
(setq linum-format "%4d |")
