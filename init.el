;;-----------------|
;;  Initial Setup  |
;;_________________|

; no splash screen
(setq inhibit-startup-message t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; right option is'nt emacs.. so that we can make {  and }
(setq mac-right-option-modifier nil)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(defun read-system-path ()
  (with-temp-buffer
    (insert-file-contents "/etc/paths")
    (goto-char (point-min))
    (replace-regexp "\n" ":")
    (thing-at-point 'line)))

(setenv "PATH" (read-system-path))
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))



;;---------------------------------------|
;;  Backup / Autosave and locking files  |
;;_______________________________________|

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

; Don't use lock files (.#<file>) because they annoy build systems
(setq create-lockfiles nil)

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))


;;---------------------------|
;;  Which system are we on?  |
;;___________________________|

; is mac?
(setq is-mac (equal system-type 'darwin))

;; Create function for mac-fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; mac friendly font
;(set-face-attribute 'default nil :font "Monaco" :height 140)
(set-face-attribute 'default nil :height 140)

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote toggle-fullscreen))


;;---------------------------------------------
;; Load / install and setup the right packages
;;_____________________________________________


(package-initialize)


;(require 'erlang-config)
;(require 'tramp)
;(require 'perspective)
;(setq tramp-default-method "ftp")

(desktop-save-mode 1)

(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(magit
    git-commit-mode
    gitconfig-mode
    gitignore-mode
    smooth-scrolling
    undo-tree
    js2-mode
    js2-refactor
    smex
    zoom-frm
    frame-cmds
    frame-fns
    expand-region
    perspective
    ace-jump-mode
    ace-jump-buffer)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(require 'sane-defaults)

;; Setup environment variables from the user's shell.
(when is-mac
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; Language specific setup files
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
  
;;; Smart M-x is smart
;(require 'smex)
;(smex-initialize)

(require 'key-bindings)
;(require 'expand-region)
(require 'appearance)
