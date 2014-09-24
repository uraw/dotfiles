;;; auto-complete.el
;;; http://www.emacswiki.org/emacs/AutoComplete
(require 'auto-complete)
(global-auto-complete-mode t)

;; Delay untill showing complete list
;; Now default delay is too long for me
;; http://cx4a.org/software/auto-complete/manual.ja.html#.E8.A3.9C.E5.AE.8C.E3.83.A1.E3.83.8B.E3.83.A5.E3.83.BC.E3.82.92.E8.87.AA.E5.8B.95.E3.81.A7.E8.A1.A8.E7.A4.BA.E3.81.97.E3.81.AA.E3.81.84
(setq ac-auto-show-menu 0.2)
