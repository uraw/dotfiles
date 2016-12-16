;;; undo limitation
(setq undo-limit 1000000)
(setq undo-strong-limit 1300000)

;;; Do not create back up file
;;; http://www.cozmixng.org/~kou/emacs/dot_emacs
(setq backup-inhibited t)

;;; Always insert final new line
;;; http://www.cozmixng.org/~kou/emacs/dot_emacs
(setq require-final-newline t)

;;; recentf-mode
(recentf-mode)

;;; Save M-x command history
;;; http://qiita.com/akisute3@github/items/4b489c0abbb39a5dcc45
(setq desktop-globals-to-save '(extended-command-history))
(setq desktop-files-not-to-save "")
(desktop-save-mode 1)
