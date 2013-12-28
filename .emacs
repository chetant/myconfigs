(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-matching-paren nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defalias 'yes-or-no-p 'y-or-n-p)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(add-to-list 'package-archives 
    '("gnu" . 
      "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . 
      "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'window-numbering)
(window-numbering-mode t)

(require 'auto-complete)
(ac-define-source ghc-mod
    '((depends ghc)
      (candidates . (ghc-select-completion-symbol))
      (symbol . "s")
      (cache)))

(add-to-list 'load-path "~/haskell/ghc-mod/elisp")
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
(defun my-haskell-mode-hook ()
  (haskell-indent-mode 1)
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
		     ac-source-dictionary
		     ac-source-ghc-mod))
  (auto-complete-mode t)
  (setq ac-auto-start nil)
  (local-set-key (kbd "M-/") 'auto-complete)
  (ghc-init))

(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-z") 'undo)
