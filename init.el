;; -*- lexical-binding: t -*-

(setq inhibit-startup-screen t)
(setq use-dialog-box nil)
(setq truncate-lines t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)

(setq whitespace-line-column 120)
(setq whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

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
(setq eldoc-echo-area-use-multiline-p nil)

(setq dired-listing-switches "--group-directories-first -alh")
(setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backup")))))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(column-number-mode)
(delete-selection-mode)
(electric-pair-mode)

(global-whitespace-mode)
(save-place-mode)

(setq-default display-line-numbers-width 3)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

(recentf-mode)
(show-paren-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package helm
  :ensure t
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("C-x C-b" . helm-buffers-list)
  ("C-x C-d" . helm-browse-project)
  ("C-x r p" . helm-projects-history)
  ("C-x r b" . helm-filtered-bookmarks)
  ("M-s o" . helm-occur)
  ("C-c C-f" . helm-recentf)
  :config
  ;; (setq completion-styles '(flex))
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

(use-package helm-ls-git
  :ensure t)

(use-package helm-descbinds
  :ensure t
  :config (helm-descbinds-mode))

(use-package helm-xref
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
		doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package all-the-icons
  :ensure t)

(use-package beacon
  :ensure t
  :config (beacon-mode))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (add-hook 'after-init-hook #'global-company-mode))

(use-package undo-tree
  :ensure t
  :init
  (setq undo-tree-history-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "undo-tree-history")))))
  (global-undo-tree-mode))

(use-package eglot
  :ensure t
  :pin gnu
  :config (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
  :init
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'go-mode-hook 'eglot-ensure)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'cmake-mode-hook 'eglot-ensure))

(use-package rainbow-mode
  :ensure t
  :config (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package which-key
  :ensure t
  :config
  (setq which-key-idle-delay 0.1)
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

(use-package expand-region
  :ensure t
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))

;; (use-package evil
;;   :ensure t
;;   :init
;;   (evil-mode))

(use-package magit
  :ensure t)

(use-package goto-chg
  :ensure t
  :bind
  ("C-," . goto-last-change)
  ("C-." . goto-last-change-reverse))

(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C-<" . mc/mark-previous-like-this)
  ("C->" . mc/mark-next-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  ("C-M-<" . mc/skip-to-previous-like-this)
  ("C-M->" . mc/skip-to-next-like-this))

(use-package rfc-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-project-detection 'auto)
  (doom-modeline-mode))

(use-package keycast
  :ensure t
  :config
  (define-minor-mode keycast-mode
	""
	:global t
	(if keycast-mode
		(add-hook 'pre-command-hook 'keycast--update t)
	  (remove-hook 'pre-command-hook 'keycast--update)))
  (add-to-list 'global-mode-string '("" keycast-mode-line))
  (keycast-mode))

(use-package move-text
  :ensure t
  :bind
  ("M-<up>" . move-text-up)
  ("M-<down>" . move-text-down))

(use-package cmake-mode
  :ensure t)

(use-package dimmer
  :ensure t
  :config
  (dimmer-configure-which-key)
  (dimmer-configure-helm)
  (dimmer-configure-magit)
  (dimmer-mode t))
