;;Repository
(require 'package)
(setq package-archives '(
    ("gnu" . "https://elpa.gnu.org/packages/")
    ("marmalade" . "https://marmalade-repo.org/packages/")
    ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;;Monokai theme
(require 'monokai-theme)
(load-theme 'monokai t)

;;No Splash & GUI
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;Prefer Unicode
(prefer-coding-system 'utf-8)

;;Line Numbers & highlight
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

;;Ido-mode
(ido-mode 1)

;; Setting path by appending a new path to existing path
(setenv "PATH"
  (concat
   "C:/MinGW/msys/1.0/bin" ";"
   (getenv "PATH")))

;; save bookmarks
(setq bookmark-default-file "~/.emacs.d/bookmarks" bookmark-save-flag 1)

;;Haskell mode
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;;Change buffer
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

;;Server-mode
(require 'server)
(and (>= emacs-major-version 23)
    (defun server-ensure-safe-dir (dir) "Noop" t))
(server-start)
;;(desktop-save-mode 1)


;;Evil mode
(require 'evil)
(evil-mode 1)

;;Highlight time
(setq evil-flash-delay 10)

;;Cursor collor
(setq evil-emacs-state-cursor '("#F92672" box))
(setq evil-normal-state-cursor '("#21889B" box))
(setq evil-visual-state-cursor '("#FD971F" box))
(setq evil-insert-state-cursor '("#21889B" bar))
(setq evil-replace-state-cursor '("#21889B" bar))
(setq evil-operator-state-cursor '("#21889B" hollow))

;;Evil-leader
(require 'evil-leader)
(global-evil-leader-mode 1)
(evil-leader/set-leader ";")
(evil-leader/set-key
  "d" 'delete-window
  "b" 'ibuffer
  "s" 'rm-sandbox)

;;Easymotion
(evilem-default-keybindings "SPC")
(setq evilm-style "At")

;;Evil Ex
(evil-ex-define-cmd "wq" 'write-and-kill-buffer)

;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;;Evil remap
(define-key evil-normal-state-map (kbd "C-SPC") 'completion-at-point)
(define-key evil-insert-state-map (kbd "C-SPC") 'completion-at-point)

;;Eww
(setq shr-color-visible-luminance-min 85)
(setq eww-search-prefix "https://www.google.com.br/search?q=")
(evil-define-key 'normal eww-mode-map "o" 'eww)
(evil-define-key 'normal eww-mode-map "T" 'eww/toggle-display-img)
(evil-define-key 'normal eww-mode-map "f" 'ace-link-eww)

;; Functions
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*")
      (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))


(defun rm-sandbox (arg ext)
  "Edit the sandbox file"
  (interactive "P\nsExtension: ")
  (find-file
   (expand-file-name
    (concat "sandbox." ext)
    "~/.sandbox")))

(defun write-and-kill-buffer ()
  "Write and close buffer"
  (interactive)
  (save-buffer)
  (kill-this-buffer))

(defvar-local eww/display-img t)

(defun eww/toggle-display-img ()
  "Toggle images display on current buffer."
  (interactive)
  (setq eww/display-img
    (null eww/display-img))
  (eww/switch-display eww/display-img))

(defun eww/switch-display (invert &optional object)
  "Move the 'display property at POS to 'display-backup.
   Only applies if display property is an image.
   If INVERT is non-nil, move from 'display-backup to 'display instead.
   Optional OBJECT specifies the string or buffer. Nil means current buffer."
  (let* ((inhibit-read-only t)
         (from (if invert 'display-backup 'display))
         (to (if invert 'display 'display-backup))
         (pos (point-min))
         left prop)
    (while (and pos (/= pos (point-max)))
      (if (get-text-property pos from object)
          (setq left pos)
        (setq left (next-single-property-change pos from object)))
      (if (or (null left) (= left (point-max)))
          (setq pos nil)
        (setq prop (get-text-property left from object))
        (setq pos (or (next-single-property-change left from object)
                      (point-max)))
        (when (eq (car prop) 'image)
          (add-text-properties left pos (list from nil to prop) object))))))
