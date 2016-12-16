;;; bind-key.el
(require 'bind-key)

;;; undo
(bind-key "C-_" 'undo)

;;; C-h as backspace
(bind-key* "C-h" 'delete-backward-char)

;;; Go to line
(bind-key "M-g" 'goto-line)

;;; auto indent
(bind-key "C-m" 'newline-and-indent)
(bind-key "C-j" 'newline)

;;; Jump to matching paren
;; http://d.hatena.ne.jp/higepon/20080328/1206670271
;; We can use C-M-n and C-M-p.

;;; tmux like window split
(bind-key "C-x |" 'split-window-right)
(bind-key "C-x -" 'split-window-below)

;;; Open recently used file
(bind-key "C-c C-f" 'recentf-open-files)
