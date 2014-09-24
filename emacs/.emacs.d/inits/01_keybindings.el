;;; undo
(global-set-key "\C-_" 'undo)

;;; C-h as backspace
(global-set-key "\C-h" 'delete-backward-char)

;;; Go to line
(global-set-key "\M-g" 'goto-line)

;;; auto indent
(global-set-key "\C-j" 'newline-and-indent)
(global-set-key "\C-m" 'newline)

;;; comment region
(global-set-key "\C-c\C-c" 'comment-region)

;;; Jump to matching paren
;; http://d.hatena.ne.jp/higepon/20080328/1206670271
;; We can use C-M-n and C-M-p.

