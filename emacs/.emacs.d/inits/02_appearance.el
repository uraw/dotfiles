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

;;; for shell-mode
;;; hide password
(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)

;;; Remove menu bar when emacs was launch with -nw option
;;; http://www.cozmixng.org/~kou/emacs/dot_emacs
(if window-system (menu-bar-mode 1) (menu-bar-mode -1))


;;; disable line folding back
;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=truncate-lines
(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)

;;; jaspace.el
;;; http://homepage3.nifty.com/satomii/software/elisp.ja.html
;(require 'jaspace)
;
;;; タブ, 全角スペース、改行直前の半角スペースを表示する
;(when (require 'jaspace nil t)
;  (when (boundp 'jaspace-modes)
;    (setq jaspace-modes (append jaspace-modes
;(list 'php-mode
;				      'yaml-mode
;				      'javascript-mode
;				      'ruby-mode
;				      'text-mode
;				      'fundamental-mode))))
;  (when (boundp 'jaspace-alternate-jaspace-string)
;    (setq jaspace-alternate-jaspace-string "□"))
;;  (when (boundp 'jaspace-highlight-tabs)
;;    (setq jaspace-highlight-tabs ?^))
;  (add-hook 'jaspace-mode-off-hook
;	    (lambda()
;	      (when (boundp 'show-trailing-whitespace)
;		(setq show-trailing-whitespace nil))))
;  (add-hook 'jaspace-mode-hook
;	    (lambda()
;	      (progn
;		(when (boundp 'show-trailing-whitespace)
;		  (setq show-trailing-whitespace t))
;		(face-spec-set 'jaspace-highlight-jaspace-face
;			       '((((class color) (background light))
;				  (:foreground "blue"))
;				 (t (:foreground "green"))))
;		(face-spec-set 'jaspace-highlight-tab-face
;			       '((((class color) (background light))
;				  (:foreground "red"
;					       :background "unspecified"
;					       :strike-through nil
;					       :underline nil))
;				 (t (:foreground "purple"
;						 :background "unspecified"
;						 :strike-through nil
;						 :underline nil))))
;		(face-spec-set 'trailing-whitespace
;			       '((((class color) (background light))
;				  (:foreground "red"
;					       :background "unspecified"
;					       :strike-through nil
;					       :underline t))
;				 (t (:foreground "purple"
;						 :background "unspecified"
;						 :strike-through nil
;						 :underline t))))))))


;; Use monospace font for the sentence of Japanese and ASCII character both mixed up together
;; http://blog.livedoor.jp/tek_nishi/archives/8590439.html

(set-face-attribute 'default nil :family "Menlo" :height 140)
(set-fontset-font (frame-parameter nil 'font)
		  'japanese-jisx0208
		  (font-spec :family "Hiragino Kaku Gothic ProN"))
(add-to-list 'face-font-rescale-alist
	     '(".*Hiragino Kaku Gothic ProN.*" . 1.2))
