(setq inhibit-startup-screen t)
(setq frame-title-format "<%f>")
(setq use-dialog-box nil)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package diminish
  :ensure t
  :defer t)

(use-package beacon
  :ensure t
  :defer t
  :diminish beacon-mode
  :init (beacon-mode))

(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  :init (add-hook 'after-init-hook 'global-company-mode))

(use-package eglot
  :ensure t
  :defer t
  :config (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
  :init
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'go-mode-hook 'eglot-ensure))

(use-package rainbow-mode
  :ensure t
  :defer t
  :hook (prog-mode-hook . rainbow-mode))

(use-package which-key
  :ensure t
  :defer t
  :diminish which-key-mode
  :config (setq which-key-idle-delay 3)
  :init (which-key-mode))

(use-package yasnippet
  :ensure t
  :defer t
  :diminish yas-minor-mode
  :init (yas-global-mode))

(use-package expand-region
  :ensure t
  :defer t
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))

(use-package evil
  :ensure t)

;; NonGNU

(use-package magit
  :ensure t
  :defer t)

(use-package goto-chg
  :ensure t
  :defer t
  :bind
  ("C-," . goto-last-change)
  ("C-." . goto-last-change-reverse))

(use-package helm
  :ensure t
  :defer t
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
  (setq helm-mode-fuzzy-match t)
  ;; (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-move-to-line-cycle-in-source nil)
  ;; (setq helm-display-header-line nil)
  ;; (set-face-attribute 'helm-source-header nil :height 0.1)
  ;; (helm-autoresize-mode)
  ;; (setq helm-autoresize-max-height 30)
  ;; (setq helm-autoresize-min-height 30)
  :init (helm-mode))

(use-package rainbow-delimiters
  :ensure t
  :defer t
  :diminish rainbow-delimiters-mode
  :init (rainbow-delimiters-mode))

(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("<C-m> <" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  ("C-M-<" . mc/skip-to-previous-like-this)
  ("C-M->" . mc/skip-to-next-like-this))

(use-package rfc-mode
  :ensure t
  :defer t)

(use-package spacemacs-theme
  :ensure t
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package markdown-mode
  :ensure t
  :defer t)

(use-package rust-mode
  :ensure t
  :defer t)

(use-package go-mode
  :ensure t
  :defer t)

(use-package json-mode
  :ensure t
  :defer t)

(use-package keycast
  :ensure t
  :defer t)

;; Melpa

(use-package move-text
  :ensure t
  :defer t
  :bind
  ("M-<up>" . move-text-up)
  ("M-<down>" . move-text-down))

(use-package spaceline
  :ensure t
  :defer t
  :init
  (spaceline-emacs-theme)
  (spaceline-helm-mode))

(use-package helm-ls-git
  :ensure t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 4)

(setq-default whitespace-line-column 120)
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

(global-set-key (kbd "<backspace>") 'delete-backward-char)
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;; (global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
(setq eldoc-echo-area-use-multiline-p nil)
(setq dired-listing-switches "-ahl")
(setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(column-number-mode)
(delete-selection-mode)
(electric-pair-mode)

(global-whitespace-mode)
(diminish 'global-whitespace-mode)

(global-linum-mode)
(recentf-mode)
(show-paren-mode)

(diminish 'abbrev-mode)
(diminish 'eldoc-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(t: yasnippet which-key use-package spacemacs-theme spaceline rust-mode rfc-mode rainbow-mode rainbow-delimiters multiple-cursors move-text markdown-mode keycast json-mode helm-themes helm-ls-git goto-chg go-mode expand-region eglot diminish company beacon)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
