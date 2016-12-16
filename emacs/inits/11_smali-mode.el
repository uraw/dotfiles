;;; smali-mode.el
;;; https://github.com/strazzere/Emacs-Smali
; load the smali/baksmali mode
(autoload 'smali-mode "smali-mode" "Major mode for editing and viewing smali issues" t)
(setq auto-mode-alist (cons '(".smali$" . smali-mode) auto-mode-alist))
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
