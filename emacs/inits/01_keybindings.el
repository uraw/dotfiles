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

;;; Open recently used file
(bind-key "C-c C-f" 'recentf-open-files)

;;; tmux like window split
(bind-key "C-x |" 'split-window-right)
(bind-key "C-x -" 'split-window-below)

;;; Window move
;;; https://www.emacswiki.org/emacs/WindMove
(bind-key "C-c C-h" 'windmove-left)
(bind-key "C-c C-l" 'windmove-right)
(bind-key "C-c C-k" 'windmove-up)
(bind-key "C-c C-j" 'windmove-down)

;;; Window resize
;;; https://www.emacswiki.org/emacs/WindowResize
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the middle"
  (let* ((win-edges (window-edges))
	 (this-window-y-min (nth 1 win-edges))
	 (this-window-y-max (nth 3 win-edges))
	 (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the middle"
  (let* ((win-edges (window-edges))
	 (this-window-x-min (nth 0 win-edges))
	 (this-window-x-max (nth 2 win-edges))
	 (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -5))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 5))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -5))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 5))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -5))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 5))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -5))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 5))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -5))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 5))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -5))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 5))))

(global-set-key (kbd "C-c h") 'win-resize-enlarge-vert)
(global-set-key (kbd "C-c l") 'win-resize-minimize-vert)
(global-set-key (kbd "C-c k") 'win-resize-enlarge-horiz)
(global-set-key (kbd "C-c j") 'win-resize-minimize-horiz)
