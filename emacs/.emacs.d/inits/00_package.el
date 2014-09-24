(require 'package)

;;; Add MELPA repository to package-archives
;;; http://tech.kayac.com/archive/divide-dot-emacs.html
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize) ;; it may set load-path...?

(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    auto-complete
    fuzzy-format
    helm
    markdown-mode
    popup
    yaml-mode
    markdown-mode
    ))

(let ((not-installed (loop for x in installing-package-list
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))
