(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-paren nil)
 '(column-number-mode t)
 '(conda-anaconda-home "/opt/homebrew/Caskroom/miniforge/base")
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(leuven))
 '(custom-safe-themes
   '("5e5771e6ea0c9500aa87e987ace1d9f401585e22a976777b6090a1554f3771c6" default))
 '(inhibit-startup-screen t)
 '(org-babel-load-languages '((python . t)))
 '(package-selected-packages
   '(gptel company lsp-jedi lsp-mode python org magit magit-delta github-theme ag yaml-mode cuda-mode auto-highlight-symbol pyenv-mode conda flycheck suscolors-theme eglot smartscan window-numbering))
 '(show-paren-mode t)
 '(show-paren-style 'expression)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package emacs
  :init
  (defun chetan-swap-buffers ()
  "Swap current buffer in window with one from the last window"
  (interactive)
  (let* ((current-window (get-buffer-window))
         (current-buffer (current-buffer))
         (last-window (previous-window current-window))
         (last-buffer (window-buffer last-window)))
    (progn
      (set-window-buffer last-window current-buffer)
      (set-window-buffer current-window last-buffer)
      (select-window last-window))))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq-default indent-tabs-mode nil)
  (setq split-height-threshold 100)
  (global-auto-revert-mode 1)

  (global-set-key (kbd "<C-tab>") 'other-window)
  (global-set-key (kbd "C-/") 'comment-or-uncomment-region)
  (global-set-key (kbd "C-z") 'undo)
  (global-set-key (kbd "<f5>") 'recompile)
  (global-set-key (kbd "s-/") 'completion-at-point)

  (global-set-key (kbd "M-}") 'smartscan-symbol-go-forward)
  (global-set-key (kbd "M-{") 'smartscan-symbol-go-backward)

  (global-set-key (kbd "C-?") 'python-shell-send-region)

  (global-set-key (kbd "M-RET") 'chetan-swap-buffers)

  ;; wrap these macos specific key bindings to only be enabled for macos
  (when (eq system-type 'darwin)
    (global-set-key (kbd "<home>") 'move-beginning-of-line)
    (global-set-key (kbd "<end>") 'move-end-of-line)))

(use-package cc-mode
  :init
  (setq c-default-style "linux"
        c-basic-offset 2))

(use-package lsp-jedi
  :ensure t)

(use-package conda
  :ensure t
  :config
  (defun chetan-set-conda-python ()
    (setq python-shell-interpreter (executable-find "python")))
  :hook
  (conda-postactivate . chetan-set-conda-python))

(use-package org
  :init
  (setq org-startup-truncated nil)
  (setq org-src-tab-acts-natively t)
  (setq org-src-fontify-natively t)  

  (defun chetan-org-insert-python-code-block ()
    "Insert python code block"
    (interactive)
    (insert "\n#+begin_src python\n\n#+end_src\n")
    (previous-line 2)
    (goto-char (line-end-position)))

  ;; (defun chetan-org-delete-code-and-results-blocks ()
  ;;   "Delete the Org code block and its associated results block where the cursor is currently located."
  ;;   (interactive)
  ;;   (let ((code-start (re-search-backward "^#\+begin_src" nil t))
  ;;         (code-end (and code-start (re-search-forward "^#\+end_src" nil t)))
  ;;         (results-start (and code-end (re-search-forward "^#\+RESULTS:" nil t)))
  ;;         (results-end (and results-start (re-search-forward "^$" nil t))))
  ;;     (when (and code-start code-end)
  ;;       (delete-region code-start (1+ code-end))
  ;;       (when (and results-start results-end)
  ;;         (delete-region results-start (1+ results-end))))))

  :bind
  (:map org-mode-map
        ;; remove some default org-mode bindings that make navigation hard
        ("C-<up>") . nil)
        ("C-<down>". nil)
        ("C-<left>". nil)
        ("C-<right>". nil)
        ("C-S-<up>". nil)
        ("C-S-<down>". nil)
        ("C-S-<left>". nil)
        ("C-S-<right>". nil)
        ("S-<up>". nil)
        ("S-<down>". nil)
        ("S-<left>". nil)
        ("S-<right>". nil)
        ;; add some org-mode bindings
        ("C-M-<down>" . org-babel-next-src-block)
        ("C-M-<up>" . org-babel-previous-src-block)
        ("C-M-<return>" . chetan-org-insert-python-code-block))

(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize))

(use-package window-numbering
  :config
  (window-numbering-mode t))

(use-package smartscan
  :config
  (global-smartscan-mode t))

(use-package auto-highlight-symbol
  :config
  (global-auto-highlight-symbol-mode t))

(use-package gptel
              :config
              (setq
               gptel-model "llama-3-70b"
               gptel-backend (gptel-make-openai "llama-cpp"
                               :stream t
                               :protocol "http"
                               :host "localhost:8080"
                               :models '("llama-3-70b")))
              (add-hook 'gptel-post-response-functions 'gptel-end-of-response))
