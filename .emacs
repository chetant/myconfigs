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
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux"
      c-basic-offset 2)

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

(global-smartscan-mode t)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

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
(global-set-key (kbd "<f5>") 'recompile)


;; Pygmalion commands.
(setq compilation-auto-jump-to-first-error 1)

(defun column-number-at-pos (point)
  (save-excursion
    (goto-char point)
    (beginning-of-line)
    (+ 1 (- point (point)))))

(defun pygmalion-command (cmd)
  (compilation-start
    (concat "pygmalion "
            cmd
            " "
            (buffer-file-name)
            " "
            (number-to-string (line-number-at-pos))
            " "
            (number-to-string (column-number-at-pos (point))))))

(defun pygmalion-file-command (cmd)
  (compilation-start
    (concat "pygmalion "
            cmd
            " "
            (buffer-file-name))))

(defun pygmalion-dot-command (cmd)
  (compilation-start
    (concat "pygmalion "
            cmd
            " "
            (buffer-file-name)
            " "
            (number-to-string (line-number-at-pos))
            " "
            (number-to-string (column-number-at-pos (point)))
            " | dot -Tpdf > /tmp/pygmalion."
            cmd
            ".pdf && open /tmp/pygmalion."
            cmd
            ".pdf")))

(defun pygmalion-file-dot-command (cmd)
  (compilation-start
    (concat "pygmalion "
            cmd
            " "
            (buffer-file-name)
            " | dot -Tpdf > /tmp/pygmalion."
            cmd
            ".pdf && open /tmp/pygmalion."
            cmd
            ".pdf")))

(defun pygmalion-go-to-definition () (interactive) (pygmalion-command "definition"))
(defun pygmalion-go-to-declaration () (interactive) (pygmalion-command "declaration"))
(defun pygmalion-callers () (interactive) (pygmalion-command "callers"))
(defun pygmalion-callees () (interactive) (pygmalion-command "callees"))
(defun pygmalion-bases () (interactive) (pygmalion-command "bases"))
(defun pygmalion-overrides () (interactive) (pygmalion-command "overrides"))
(defun pygmalion-members () (interactive) (pygmalion-command "members"))
(defun pygmalion-references () (interactive) (pygmalion-command "references"))
(defun pygmalion-hierarchy () (interactive) (pygmalion-dot-command "hierarchy"))
(defun pygmalion-inclusions () (interactive) (pygmalion-file-command "inclusions"))
(defun pygmalion-includers () (interactive) (pygmalion-file-command "includers"))
(defun pygmalion-inclusion-hierarchy () (interactive) (pygmalion-file-dot-command "inclusion-hierarchy"))

;; (eval-after-load "cc-mode"
;;   '(progn
;;       (define-key c-mode-base-map (kbd "M-p M-d") 'pygmalion-go-to-definition)
;;       (define-key c-mode-base-map (kbd "M-p M-D") 'pygmalion-go-to-declaration)
;;       (define-key c-mode-base-map (kbd "M-p M-c") 'pygmalion-callers)
;;       (define-key c-mode-base-map (kbd "M-p M-C") 'pygmalion-callees)
;;       (define-key c-mode-base-map (kbd "M-p M-b") 'pygmalion-bases)
;;       (define-key c-mode-base-map (kbd "M-p M-o") 'pygmalion-overrides)
;;       (define-key c-mode-base-map (kbd "M-p M-m") 'pygmalion-members)
;;       (define-key c-mode-base-map (kbd "M-p M-r") 'pygmalion-references)
;;       (define-key c-mode-base-map (kbd "M-p M-h") 'pygmalion-hierarchy)
;;       (define-key c-mode-base-map (kbd "M-p M-i") 'pygmalion-inclusions)
;;       (define-key c-mode-base-map (kbd "M-p M-I") 'pygmalion-includers)
;;       (define-key c-mode-base-map (kbd "M-p M-i M-h") 'pygmalion-inclusion-hierarchy)))
