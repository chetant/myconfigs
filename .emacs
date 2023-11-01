(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-paren nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(ag yaml-mode cuda-mode auto-highlight-symbol pyenv-mode conda flycheck suscolors-theme eglot smartscan window-numbering))
 '(show-paren-mode t)
 '(show-paren-style 'expression)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux"
      c-basic-offset 2)
(when (and (equal emacs-version "27.2")
           (eql system-type 'darwin))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(require 'conda)
(defun chetan-set-conda-python ()
  (setq python-shell-interpreter (executable-find "python")))
(add-hook 'conda-postactivate-hook 'chetan-set-conda-python)

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

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'window-numbering)
(window-numbering-mode t)

(global-smartscan-mode t)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "s-/") 'completion-at-point)

(global-set-key (kbd "M-}") 'smartscan-symbol-go-forward)
(global-set-key (kbd "M-{") 'smartscan-symbol-go-backward)

(global-set-key (kbd "C-?") 'python-shell-send-region)

(global-set-key (kbd "M-RET") 'chetan-swap-buffers)

; macos specific
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

(setq split-height-threshold 100)
(setq org-startup-truncated nil)
