;;; package.elの設定
;;; http://rubikitch.com/package-initialize/
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;; package.elで自動インストール
;;; http://wagavulin.hatenablog.com/entry/2016/07/04/211631
(defvar my-favorite-package-list
  '(popup
    auto-complete
    popwin
    fuzzy-format
    ruby-block
    markdown-mode
    haml-mode
    auto-install
    init-loader
    ruby-electric)
  "packages to be installed")

(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(dolist (pkg my-favorite-package-list)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;; auto-install.elの設定
;;; http://rubikitch.com/package-initialize/
(require 'auto-install)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(auto-install-compatibility-setup)

;;; Setting for init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
