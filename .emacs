;;Repository:
(require 'package)
(add-to-list 'package-archives
    '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;Monokai theme:
(require 'monokai-theme)
(load-theme 'monokai t)

;;No Splash & GUI
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;Line Numbers & highlight:
(global-hl-line-mode 1)
(global-linum-mode 1)
    
;;Scroll Smooth
(setq scroll-margin 2)
(setq scroll-conservatively 101)

;;Tabs to spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;Turn off backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;;Ido-mode:
(ido-mode 1)

;; Setting path by appending a new path to existing path
(setenv "PATH"
  (concat
   "C:/MinGW/msys/1.0/bin" ";"
   (getenv "PATH")))

;; save bookmarks:
(setq bookmark-default-file "~/.emacs.d/bookmarks" bookmark-save-flag 1)

;;Change buffer:
(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "<C-left>") 'previous-buffer)
(global-set-key (kbd "<C-right>") 'next-buffer)

;;Parenthesis highlight:
(require 'paren)
(setq show-paren-delay 0)
(show-paren-mode 1)
(set-face-background 'show-paren-match "#FD971F")
(set-face-foreground 'show-paren-match "#272822")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;;Server-mode:
(require 'server)
(and (>= emacs-major-version 23)
    (defun server-ensure-safe-dir (dir) "Noop" t))
(server-start)
;;(desktop-save-mode 1)


;;Evil mode:
(require 'evil)
(evil-mode 1)

;;Highlight time
(setq evil-flash-delay 10)

;;Cursor collor:
(setq evil-emacs-state-cursor '("#F92672" box))
(setq evil-normal-state-cursor '("#21889B" box))
(setq evil-visual-state-cursor '("#FD971F" box))
(setq evil-insert-state-cursor '("#21889B" bar))
(setq evil-replace-state-cursor '("#21889B" bar))
(setq evil-operator-state-cursor '("#21889B" hollow))

;;Evil-leader:
(require 'evil-leader)
(global-evil-leader-mode 1)
(evil-leader/set-leader ";")
(evil-leader/set-key
  "k" 'kill-this-buffer
  "d" 'delete-window
  "b" 'ibuffer
  "s" 'rm-sandbox
  "<tab>" 'other-window)

;; esc quits:
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)



;; Functions
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*")
      (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(defun rm-sandbox (arg ext)
  (interactive "P\nsExtension: ")
  (find-file
   (expand-file-name
    (concat "sandbox." ext)
    "~/.sandbox")))

