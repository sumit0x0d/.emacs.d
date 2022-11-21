(setq inhibit-startup-screen t)
(setq frame-title-format "<%f>")
(setq use-dialog-box nil)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)

(global-whitespace-mode)

(setq whitespace-line-column 80)
(setq whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

;; (ido-mode)
;; (ido-everywhere t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-case-fold t)
;; (setq ido-use-virtual-buffers t)
;; (icomplete-mode)
;; (setq completion-styles '(flex))
;; (icomplete-vertical-mode)
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;; (global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-set-key (kbd "<backspace>") 'delete-backward-char)

(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)

(setq dired-listing-switches "-ahl")

(setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backup")))))
(setq auto-save-file-name-transforms `((".*" , temporary-file-directory t)))

(save-place-mode)
(column-number-mode)
(delete-selection-mode)
(electric-pair-mode)
(recentf-mode)
(show-paren-mode)

(setq require-final-newline t)
(setq-default truncate-lines t)
(setq-default display-line-numbers-width 3)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(setq eldoc-echo-area-use-multiline-p nil)

(global-hl-line-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package diminish
  :ensure t
  :pin gnu)

(diminish 'global-whitespace-mode)
(diminish 'abbrev-mode)
(diminish 'eldoc-mode)

(use-package undo-tree
  :ensure t
  :pin gnu
  :diminish undo-tree-mode
  :config
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-history-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "undo-tree-history")))))
  (global-undo-tree-mode))

(use-package beacon
  :ensure t
  :pin gnu
  :diminish beacon-mode
  :config (beacon-mode))

(use-package company
  :ensure t
  :defer t
  :pin gnu
  :diminish company-mode
  :init
  (setq company-idle-delay 0.0)
  (setq company-minimum-prefix-length 2)
  (add-hook 'after-init-hook #'global-company-mode))

(use-package eglot
  :ensure t
  :defer t
  :pin gnu
  :config (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
  :init
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'go-mode-hook 'eglot-ensure)
  (add-hook 'rust-mode-hook 'eglot-ensure))

(use-package rainbow-mode
  :ensure t
  :pin gnu
  :diminish rainbow-mode
  :config (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package which-key
  :ensure t
  :pin gnu
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0)
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :pin gnu
  :diminish yas-minor-mode
  :config (yas-global-mode))

(use-package expand-region
  :ensure t
  :pin gnu
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))

(use-package spacemacs-theme
  :ensure t
  :defer t
  :pin nongnu
  :init (load-theme 'spacemacs-dark t))

(use-package keycast
  :ensure t
  :pin nongnu)

(use-package evil
  :ensure t
  :pin nongnu)

(use-package magit
  :ensure t
  :pin nongnu)

(use-package goto-chg
  :ensure t
  :pin nongnu
  :bind
  ("C-," . goto-last-change)
  ("C-." . goto-last-change-reverse))

(use-package rainbow-delimiters
  :ensure t
  :pin nongnu
  :diminish rainbow-delimiters-mode
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package multiple-cursors
  :ensure t
  :pin nongnu
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C-<" . mc/mark-previous-like-this)
  ("C->" . mc/mark-next-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  ("C-M-<" . mc/skip-to-previous-like-this)
  ("C-M->" . mc/skip-to-next-like-this))

(use-package rfc-mode
  :ensure t
  :pin nongnu)

(use-package markdown-mode
  :ensure t
  :pin nongnu)

(use-package rust-mode
  :ensure t
  :pin nongnu)

(use-package go-mode
  :ensure t
  :pin nongnu)

(use-package json-mode
  :ensure t
  :pin gnu)

(use-package helm
  :ensure t
  :pin melpa
  :diminish helm-mode
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("C-x C-b" . helm-buffers-list)
  ("C-x C-d" . helm-browse-project)
  ("C-x r b" . helm-filtered-bookmarks)
  ("M-s o" . helm-occur)
  ("C-c C-f" . helm-recentf)
  :config
  (setq completion-styles '(flex))
  ;; (setq helm-mode-fuzzy-match t)
  ;; (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-move-to-line-cycle-in-source nil)
  (setq helm-display-header-line nil)
  (set-face-attribute 'helm-source-header nil :height 0.1)
  (helm-autoresize-mode)
  (setq helm-autoresize-max-height 30)
  (setq helm-autoresize-min-height 30)
  (setq helm-split-window-in-side-p t)
  (helm-mode))

(use-package move-text
  :ensure t
  :pin melpa
  :bind
  ("M-<up>" . move-text-up)
  ("M-<down>" . move-text-down))

(use-package cmake-mode
  :ensure t
  :pin melpa)

(use-package powerline
  :ensure t
  :pin melpa
  :init
  (powerline-default-theme))

(use-package helm-ls-git
  :ensure t
  :pin melpa)

(use-package helm-descbinds
  :ensure t
  :pin melpa
  :config (helm-descbinds-mode))

(use-package helm-xref
  :ensure t
  :pin melpa)
