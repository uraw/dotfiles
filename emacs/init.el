;; <leaf-install-code>

;; Enabling running method below;
;;  emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My snippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst IS-MAC (eq system-type 'darwin))
(defconst IS-LINUX (eq system-type 'gnu/linux))
(defconst IS-WINDOW-SYSTEM (not (null (memq window-system '(mac ns x)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My leaves
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf leaf-utilities
  (leaf macrostep
    :url "https://github.com/joddie/macrostep"
    :ensure t
    :bind ("C-c e" . macrostep-expand))
  (leaf leaf-convert
    :url "https://github.com/conao3/leaf-convert.el"
    :ensure t)
  (leaf leaf-tree
    :url "https://github.com/conao3/leaf-tree.el"
    :ensure t
    :custom
    (imenu-list-size . 30)
    (imenu-list-position . 'left))
  (leaf cus-edit
    :doc "divide cusomizes that emacs try to add init.el, into custom.el"
    :url "https://zenn.dev/zenwerk/scraps/b1280f66c8d11a"
    :custom (custom-file . '(locate-user-emacs-file "custom.el"))
    )
  )

(leaf major-modes
  :config
  (leaf cc-mode
    :doc "major mode for editing C and similar languages"
    :defvar (c-basic-offset)
    :hook
    (c-mode-hook . '((c-set-style "bsd")
                     (setq c-basic-offset 4)))
    (c++-mode-hook . '((c-set-style "bsd")
                       (setq c-basic-offset 4))))
  (leaf go-mode
    :doc "Major mode for the Go programming language"
    :url "https://github.com/dominikh/go-mode.el"
    :ensure t)
  (leaf markdown-mode
    :doc "Major mode for Markdown-formatted text"
    :url "https://jblevins.org/projects/markdown-mode/"
    :ensure t
    :bind ("C-c m" . markdown-mode)
    :custom
    (markdown-fontify-code-blocks-natively . t)  ;; enable syntax highlight in code block
    :config
    (custom-set-faces
     '(hl-line ((t (:underline t))))
     '(markdown-header-delimiter-face ((t (:inherit nil :foreground "color-161" :weight bold))))
     '(markdown-header-face ((t (:inherit nil :background "color-242" :underline t :weight bold))))
     '(markdown-header-face-1 ((t (:inherit nil :foreground "color-40" :weight bold :height 1.0))))
     '(markdown-header-face-2 ((t (:inherit nil :foreground "color-33" :height 1.0))))
     '(markdown-header-face-3 ((t (:foreground "color-178" :height 1.0))))
     '(markdown-header-face-4 ((t (:foreground "color-105" :height 1.0))))
     '(markdown-header-face-5 ((t (:foreground "color-219" :weight bold :height 1.0))))
     '(markdown-header-face-6 ((t (:foreground "color-244" :weight bold))))
     '(markdown-list-face ((t (:foreground "color-135"))))
     ))
  (leaf yaml-mode
    :doc "Major mode for editing YAML files"
    :url "https://github.com/yoshiki/yaml-mode"
    :ensure t)
  (leaf rust-mode
    :doc "A major-mode for editing Rust source code"
    :url "https://github.com/rust-lang/rust-mode"
    :ensure t)
  (leaf toml-mode
    :doc "Major mode for editing TOML files"
    :url "https://github.com/dryman/toml-mode.el"
    :ensure t)
  (leaf crontab-mode
    :doc "Major mode for crontab(5)"
    :url "https://github.com/emacs-pe/crontab-mode"
    :ensure t)
  (leaf arm-mode
    :el-get charJe/arm-mode
    :require t)
  (leaf fish-mode
    :doc "Major mode for fish shell scripts"
    :ensure t)
  (leaf makefile-mode
    :hook (makefile-gmake-mode-hook . (lambda () (setq indent-tabs-mode t))))
  )

(leaf system
  :config
  (leaf exec-path-for-brew
    :url "https://blog.kyanny.me/entry/2014/09/12/135629"
    :config
    (cond (IS-MAC
           (add-to-list 'exec-path "/opt/homebrew/bin")))
    (cond (IS-LINUX
           (add-to-list 'exec-path "/home/linuxbrew/bin"))))
  (leaf exec-path-from-shell
    :doc "Get environment variables such as $PATH from the shell"
    :url "https://github.com/purcell/exec-path-from-shell"
    :when IS-WINDOW-SYSTEM
    :ensure t
    :custom
    (exec-path-from-shell-check-startup-files . nil)
    (exec-path-from-shell-arguments . nil)
    (exec-path-from-shell-variables . '("PATH" "SHELL"))
    :config (exec-path-from-shell-initialize))
  (leaf suppress-cl-deprecated-message
    :custom (byte-compile-warnings '(not cl-functions obsolete)))
  (leaf gcmh
    :doc "the Garbage Collector Magic Hack"
    :url "https://gitlab.com/koral/gcmh"
    :ensure t
    :blackout t
    :custom (gcmh-verbose . t)
    :config (gcmh-mode 1))
  (leaf savehist-mode
    :url "http://emacs.rubikitch.com/savehist/"
    :config (savehist-mode 1))
  )

(leaf completion
  :config
  (leaf popon
    :url "https://codeberg.org/akib/emacs-popon.git"
    :unless (display-graphic-p)
    :el-get (emacs-popon :url "https://codeberg.org/akib/emacs-popon.git"))
  (leaf corfu-terminal
    :url "https://codeberg.org/akib/emacs-corfu-terminal.git"
    :after corfu
    :unless (display-graphic-p)
    :el-get (emacs-corfu-terminal :url "https://codeberg.org/akib/emacs-corfu-terminal.git")
    :config (corfu-terminal-mode 1))
  (leaf corfu
    :url "https://github.com/minad/corfu"
    :ensure t
    :init (global-corfu-mode)
    :custom
    (corfu-cycle . t)  ; cycle list
    (corfu-auto . t) ; automatically start completion
    (corfu-count . 30)
    (corfu-preselect . 'prompt)
    (corfu-auto-prefix . 1)
    (corfu-auto-delay . 0)
    (completion-cycle-threshold . 3) ; TAB cycle if there are only few candidates
    (tab-always-indent . 'complete)
    :bind (:corfu-map
           ("RET" . nil)
           ("<return>" . nil)
           ("TAB" . corfu-insert)
           ("<tab>" . corfu-insert)
           )
    )
  (leaf cape
    :url "https://github.com/minad/cape"
    :ensure t
    :bind (("C-c p p" . completion-at-point)
         ("C-c p t" . complete-tag)
         ("C-c p d" . cape-dabbrev)
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
    :init
    ;; Add `completion-at-point-functions', used by `completion-at-point'.
    ;; NOTE: The order matters!
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-elisp-block)
    ;;(add-to-list 'completion-at-point-functions #'cape-history)
    ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
    ;;(add-to-list 'completion-at-point-functions #'cape-tex)
    ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
    ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
    ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
    ;;(add-to-list 'completion-at-point-functions #'cape-dict)
    ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
    ;;(add-to-list 'completion-at-point-functions #'cape-line)
    )
  )

(leaf programing
  (leaf lsp)
  (leaf python
    :custom
    (python-indent-guess-indent-offset . nil)
    (python-indent . 4)
    :config
    (leaf elpy
      :doc "Emacs Python Development Environment"
      :url "https://github.com/jorgenschaefer/elpy"
      :ensure t
      :after highlight-indentation pyvenv yasnippet
      :defer-config
      (leaf elpy-customize
        :custom
        (python-shell-interpreter . "ipython3")
        (python-shell-interpreter-args . "-i")
        (elpy-rpc-python-command . "python3")
        (python-check-command . "pflake8")
        :config
        (custom-set-variables
         '(elpy-modules
           (quote
            (elpy-module-eldoc
             elpy-module-flymake
             elpy-module-folding
             elpy-module-pyvenv
             elpy-module-django
             elpy-module-sane-defaults))))))
    (leaf py-isort
      :doc "Use isort to sort the imports in a Python buffer"
      :url "http://paetzke.me/project/py-isort.el"
      :ensure t
      :hook (before-save-hook . py-isort-before-save))
    )
  (leaf syntax-check
    :config
    (leaf flycheck
      :doc "On-the-fly syntax checking"
      :url "http://www.flycheck.org"
      :ensure t
      :defer-config
      (leaf disable-flycheck-for-emacs-lisp
        :url "https://stackoverflow.com/questions/15552349/how-to-disable-flycheck-warning-while-editing-emacs-lisp-scripts"
        :custom
        (flycheck-disabled-checkers . '(emacs-lisp-checkdoc)))
      (leaf flycheck-for-python
        :custom
        (flycheck-python-flake8-executable . "pflake8")))
    )
  (leaf tag-jump
    :config
    (leaf dumb-jump
      :doc "Jump to definition for 50+ languages without configuration"
      :url "https://github.com/jacktasia/dumb-jump"
      :ensure t
      :config (dumb-jump-mode)
      :custom
      (dumb-jump-force-searcher . 'rg)
      (dumb-jump-prefere-searcher . 'rg)
      :hook (xref-backend-functions . dumb-jump-xref-activate)
      )
    )
  (leaf indentation
    :config
    (leaf fuzzy-format
      :doc "select indent-tabs-mode and format code automatically."
      :url "http://code.101000lab.org, http://trac.codecheck.in"
      :el-get emacsmirror/fuzzy-format
      :require t)
    (leaf indent-with-4-spaces
      :doc "indent with 4 spaces without tab"
      :custom
      (indent-tabs-mode . nil)
      (tab-width . 4))
    )
  (leaf appearance
    :config
    (leaf symbol-overlay
      :doc "Highlight symbols with keymap-enabled overlays"
      :url "https://github.com/wolray/symbol-overlay/"
      :ensure t
      :blackout t
      :hook (prog-mode-hook . symbol-overlay-mode))
    (leaf highlight-numbers
      :doc "Highlight numbers in source code"
      :url "https://github.com/Fanael/highlight-numbers"
      :ensure t
      :hook (prog-mode-hook . highlight-numbers-mode))
    (leaf highlight-escape-sequences
      :doc "Highlight escape sequences"
      :url "https://github.com/dgutov/highlight-escape-sequences"
      :ensure t
      :hook (prog-mode-hook . hes-mode))
    (leaf whitespace-trailing
      :custom (show-trailing-whitespace . t))
    )
  )

(leaf user-interface
  :config
  (leaf popup
    :doc "Visual Popup User Interface, such as popup tooltip and popup menus"
    :url "https://github.com/auto-complete/popup-el"
    :ensure t)
  (leaf which-key
    :doc "Display available keybindings in popup"
    :url "https://github.com/justbur/emacs-which-key"
    :ensure t
    :blackout t
    :global-minor-mode which-key-mode
    :custom
    (which-key-idle-delay . 0.4)
    (which-key-idle-secondary-delay . 0.4))
  (leaf popwin
    :doc "Popup Window Manager"
    :url "https://github.com/emacsorphanage/popwin"
    :ensure t
    :config
    (popwin-mode 1)
    (push '("*xref*") popwin:special-display-config)
    (push '("*Warnings*") popwin:special-display-config)
    )
  (leaf y-or-n-p
    :doc "Use y/n instead of yes/no"
    :config
    (defalias 'yes-or-no-p 'y-or-n-p))
  (leaf vertico
    :url "https://github.com/minad/vertico/"
    :ensure t
    :added "2023-07-28"
    :custom
    (vertico-count . 20)
    (vertico-cycle . t)
    :init (vertico-mode)
    :config
    (leaf vertico-directory
      :url "https://github.com/katsusuke/.emacs.d/commit/159cbf64c46679106c1d45eb223d0380944f3ce3#commitcomment-66343609"
      :bind (:vertico-map ("C-l" . vertico-directory-up)))
    (leaf consult
      :url "https://github.com/minad/consult"
      :ensure t
      :bind
      ("C-x b" . consult-buffer)
      ("M-y"   . consult-yank-from-kill-ring)
      ("C-M-s" . consult-line)
      ("C-x t" . consult-recent-file)
      :custom
      (xref-show-xrefs-function . #'consult-xref)
      (xref-show-definitions-function . #'consult-xref)
      )
    (leaf orderless
      :url "https://github.com/oantolin/orderless"
      :ensure t
      :custom
      (completion-styles . '(orderless basic))
      (completion-category-defaults . nil)
      (completion-category-overrides '((file (styles partial-completion)))))
    )
  (leaf marginalia
    :url "https://github.com/minad/marginalia"
    :ensure t
    :hook (emacs-startup-hook . marginalia-mode)
    :bind (:minibuffer-local-map ("M-S-a" . marginalia-cycle)))
  )

(leaf language
  :config
  (leaf ispell
    :doc "interface to spell checkers"
    :when (executable-find "aspell")
    :custom
    (ispell-program-name . '(executable-find "aspell"))
    (ispell-extra-args   . '("--sug-mode=ultra" "--lang=en_US" "--camel-case")))
  (leaf flyspell
    :doc "On-the-fly spell checker"
    :hook (prog-mode-hook . flyspell-prog-mode))
  (leaf google-translate
    :doc "Emacs interface to Google Translate"
    :url ("https://github.com/atykhonov/google-translate"
          "http://emacs.rubikitch.com/google-translate-sentence/")
    :require t
    :ensure t
    :bind ("C-c t" . google-translate-enja-or-jaen)
    :defun google-translate-enja-or-jaen google-translate-json-suggestion google-translate-translate
    :defvar google-translate-english-chars
    :defer-config
    (defvar google-translate-english-chars "[:ascii:]’“”–"
      "これらの文字が含まれているときは英語とみなす")
    (defun google-translate-enja-or-jaen (&optional string)
      "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
      (interactive)
      (setq string
            (cond ((stringp string) string)
                  (current-prefix-arg
                   (read-string "Google Translate: "))
                  ((use-region-p)
                   (buffer-substring (region-beginning) (region-end)))
                  (t
                   (save-excursion
                     (let (s)
                       (forward-char 1)
                       (backward-sentence)
                       (setq s (point))
                       (forward-sentence)
                       (buffer-substring s (point)))))))
      (let* ((asciip (string-match
                      (format "\\`[%s]+\\'" google-translate-english-chars)
                      string)))
        (run-at-time 0.1 nil 'deactivate-mark)
        (google-translate-translate
         (if asciip "en" "ja")
         (if asciip "ja" "en")
         string))))
  )

(leaf git
  :config
  (leaf magit
    :doc "A Git porcelain inside Emacs."
    :url "https://github.com/magit/magit"
    :ensure t
    :after compat git-commit magit-section with-editor
    :bind ("C-x g" . magit-status))
  )


(leaf utility
  :config
  (leaf discover-my-major
    :doc "Discover key bindings and their meaning for the current Emacs major mode"
    :url "https://framagit.org/steckerhalter/discover-my-major"
    :ensure t
    :after makey
    :bind ("<help> M" . discover-my-major))
  )

(leaf frame-operation
  :config
  (leaf frame-resize-way
    :custom (frame-resize-pixelwise . t))
  )

(leaf window-operation
  :config
  (leaf opposite-window
    :doc "The opposite of forward-window"
    :bind ("C-x O" . (lambda () (interactive) (other-window -1))))
  (leaf split-window
    :doc "Split window as tmux"
    :bind
    ("C-x -" . (lambda nil (interactive) (split-window-below) (other-window 1)))
    ("C-x |" . (lambda nil (interactive) (split-window-right) (other-window 1)))
    )
  (leaf resize-window
    :doc "Resize window as tmux"
    :bind
    ("C-c l" . (lambda () (interactive) (enlarge-window-horizontally 8)))
    ("C-c h" . (lambda () (interactive) (shrink-window-horizontally 8)))
    ("C-c j" . (lambda () (interactive) (enlarge-window 8)))
    ("C-c k" . (lambda () (interactive) (shrink-window 8))))
  )

(leaf key-binds
  :config
  (leaf help-command
    :url "http://flex.phys.tohoku.ac.jp/texi/eljman/eljman_146.html"
    :bind ("M-h" . help-command))
  (leaf goto-line
    :doc "Goto line"
    :bind ("M-g" . goto-line))
  (leaf disable-c-t
    :doc "Disable transpose-character w/ C-t avoding collision for tmux"
    :bind ("C-t" . nil))
  (leaf just-one-space
    :doc "delete-horizontal-space may not be used"
    :url "https://ayatakesi.github.io/emacs/24.5/Deletion.html"
    :bind
    ("M-\\" . just-one-space)
    ("M-¥"  . just-one-space))
  (leaf new-line-indentation
    :doc "New line indentation"
    :bind
    ("C-m" . newline-and-indent)
    ("C-j" . newline))
  )

(leaf backup
  :config
  (leaf store-backup-in-tmpdir
    :doc "Store all backup up autosave files in the temporary directory"
    :url "https://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/"
    :custom
    (backup-directory-alist         . `((".*" . ,temporary-file-directory)))
    (auto-save-file-name-transforms . `((".*" ,temporary-file-directory t))))
  )

(leaf editor
  :config
  (leaf c-h-as-del
    :url "https://qiita.com/takc923/items/e279f223dbb4040b1157"
    :config
    (define-key key-translation-map (kbd "C-h") (kbd "<DEL>")))
  (leaf dmacro
    :doc "Repeated detection and execution of key operation"
    :url "https://github.com/emacs-jp/dmacro"
    :ensure t
    :blackout t
    :custom `((dmacro-key . ,(kbd "C-S-e")))
    :global-minor-mode global-dmacro-mode)
  (leaf undo
    :custom
    (undo-limit        . 1000000)
    (undo-strong-limit . 13000000))
  (leaf delete-rectangle
    :bind ("C-c :" . delete-rectangle))
  (leaf scroll-line-by-line
    :url ("http://www.emacswiki.org/emacs/SmoothScrolling"
          "https://stackoverflow.com/questions/1128927/how-to-scroll-line-by-line-in-gnu-emacs")
    :custom
    (scroll-step . 1)
    (scroll-conservatively . 10000))
  (leaf disable-auto-truncate-line
    :doc "truncate line in divided window"
    :url ("https://ayatakesi.github.io/emacs/25.1/Split-Window.html#Split-Window"
          "https://beiznotes.org/200907131247476145-2/")
    :custom
    (truncate-partial-width-windows . t)
    (truncate-lines . t))
  (leaf kill-whole-line
    :doc "C-k kill whole line at once"
    :custom (kill-whole-line . t))
  (leaf smartparens
    :doc "Parens pairs and tries to be smart"
    :url "https://github.com/Fuco1/smartparens"
    :ensure t
    :blackout t
    :global-minor-mode smartparens-global-mode)
  (leaf delsel
    :doc "delete selection if you insert"
    :global-minor-mode delete-selection-mode)
  (leaf autorevert
    :doc "revert buffers when fiels on disk change"
    :custom (auto-revert-interval . 0.1)
    :global-minor-mode global-auto-revert-mode)
  (leaf text-quoting-style-as-straight
    :url "https://ayatakesi.github.io/lispref/27.2/html/Text-Quoting-Style.html"
    :custom (text-quoting-style . 'straight))
  (leaf hs-minor-mode
    :hook (prog-mode-hook . hs-minor-mode)
    :bind ("C-c TAB" . hs-toggle-hiding)
    :blackout t)
  (leaf edit-indirect
    :doc "Edit regions in separate buffers"
    :url "https://github.com/Fanael/edit-indirect"
    :ensure t)
  (leaf migemo
    :doc "Japanese incremental search through dynamic pattern expansion"
    :url "https://github.com/emacs-jp/migemo"
    :ensure t
    :custom
    (migemo-command . "cmigemo")
    (migemo-options . '("-q" "--emacs"))
    (migemo-directory . "/opt/homebrew/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
    (migemo-user-dictionary . nil)
    (migemo-regex-dictionary . nil)
    (migemo-coding-system . 'utf-8-unix)
    (migemo-use-pattern-alist . t)
    (migemo-use-frequent-pattern-alist . t)
    (migemo-pattern-alist-length . 1024)
    :config
    (load-library "migemo")
    (migemo-init))
  )

(leaf history
  :config
  (leaf recentf
    :doc "setup a menu of recently opened files"
    :url ("https://tomoya.hatenadiary.org/entry/20110217/1297928222"
          "https://qiita.com/tadsan/items/68b53c2b0e8bb87a78d7")
    :config (recentf-mode 1)
    :custom
    (recentf-max-saved-items . 2000) ;; Keep latest 2000 files up
    (recentf-auto-cleanup    . 'never)
    (recentf-exclude         . '("/recentf" "COMMIT_EDITMSG"))
    (recent-auto-save-timer  . '(run-with-idle-timer 30 t 'recentf-save-list)))
  :custom
  (history-length . 1000)
  (history-delete-duplicates . t)
  )

(leaf file-save
  :config
  (leaf give-executable-permissionfile-on-save
    :doc "Add executable permission if a file has shebang"
    :hook (after-save-hook . executable-make-buffer-file-executable-if-script-p))
  (leaf add-newline-on-save
    :doc "Add final new line when file saved"
    :custom (require-final-newline . t))
  )

(leaf appearance
  :config
  (leaf theme
    :config
    (leaf doom-themes
      :doc "an opinionated pack of modern color-themes"
      :url "https://github.com/doomemacs/themes"
      :ensure t
      :config (load-theme 'doom-dark+ t))
    )
  (leaf hide-menu-bar
    :doc "Hide menu bar"
    :config (menu-bar-mode -1))
  (leaf hide-tool-bar
    :doc "Hide tool bar"
    :config (tool-bar-mode -1))
  (leaf highlight-current-line
    :doc "Hilight current line"
    :url "http://keisanbutsuriya.hateblo.jp/entry/2015/02/01/162035"
    :global-minor-mode global-hl-line-mode)
  (leaf font-face-for-darwin
    :if IS-MAC
    :config (set-face-attribute 'default nil
                                :height 160
                                :family "Monaco"))
  (leaf highlight-paren
    :doc "highlight matching paren"
    :custom (show-paren-delay . 0.1)
    :global-minor-mode show-paren-mode)
  (leaf quiet-start
    :doc "Disable Startup message buffer"
    :custom (inhibit-startup-message . t))
  (leaf rainbow-delimiters
    :ensure t
    :config (rainbow-delimiters-mode))
  (leaf enable-go-address-mode
    :doc "Highlight all the URLs in the buffer and turns them into clickable buttons"
    :global-minor-mode global-goto-address-mode)
  (leaf hide-password
    :doc "Hide password on shell-mode"
    :hook (comint-output-filter-functions . comint-watch-for-password-prompt))
  (leaf ansi-color
    :doc "Use same coloring as commandline by handling escape sequence in shell-mode"
    :url "http://d.hatena.ne.jp/hiboma/20061031/1162277851"
    :commands ansi-color-for-comint-mode-on
    :hook (shell-mode-hook . ansi-color-for-comint-mode-on))
  (leaf volatile-highlights
    :doc "Minor mode for visual feedback on some operations."
    :url "http://www.emacswiki.org/emacs/download/volatile-highlights.el"
    :ensure t
    :global-minor-mode volatile-highlights-mode
    :blackout t
    )
  (leaf ignore-bell
    :doc "Suppress beep"
    :url "https://qiita.com/ongaeshi/items/696407fc6c42072add54"
    :custom (ring-bell-function . 'ignore))
  (leaf status-line
    :config
    (leaf which-function
      :doc "Show current function name in status-line by which-function-mode"
      :url "https://stackoverflow.com/questions/16985544/display-function-name-in-status-line"
      :config (which-function-mode 1))
    (leaf column-number
      :doc "Show column number in mode-line"
      :global-minor-mode column-number-mode)
    (leaf line-nubmer
      :config (global-display-line-numbers-mode)))
  (leaf beacon
    :doc "Highlight the cursor whenever the window scrolls"
    :url "https://github.com/Malabarba/beacon"
    :ensure t
    :global-minor-mode beacon-mode)
  )

(leaf browsing
  :config
  (leaf ace-link
    :doc "Quickly follow links, for eww"
    :url "https://github.com/abo-abo/ace-link"
    :ensure t
    :after avy
    :config (ace-link-setup-default))
  (leaf background-color
    :url "https://futurismo.biz/archives/2950#%E8%83%8C%E6%99%AF%E8%89%B2%E3%81%AE%E8%A8%AD%E5%AE%9A"
    :defvar eww-disable-colorize
    :defun shr-colorize-region--disable
    :config
    (defvar eww-disable-colorize t)
    (defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
      (unless eww-disable-colorize
        (funcall orig start end fg)))
    (advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
    (advice-add 'eww-colorize-region :around 'shr-colorize-region--disable))
  (leaf use-google-as-default-search-engine
    :url "https://futurismo.biz/archives/2950#default-%E3%81%AE%E6%A4%9C%E7%B4%A2%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%B3%E3%82%92-google-%E3%81%AB%E5%A4%89%E6%9B%B4"
    :custom (eww-search-prefix . "https://www.google.co.jp/search?q="))
  )

(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:
