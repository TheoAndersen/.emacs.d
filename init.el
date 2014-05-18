;;-----------------|
;;  Initial Setup  |
;;_________________|

; no splash screen
(setq inhibit-startup-message t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

; is mac?
(setq is-mac (equal system-type 'darwin))

;; right option isn't emacs.. so that we can make {  and }
(when is-mac
  (setq mac-right-option-modifier nil)
  )

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

(when is-mac
  (defun read-system-path ()
    (with-temp-buffer
      (insert-file-contents "/etc/paths")
      (goto-char (point-min))
      (replace-regexp "\n" ":")
      (thing-at-point 'line)))
)

(when is-mac
  (setenv "PATH" (read-system-path))
  (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
  )

;;---------------------------------------|
;;  Backup / Autosave and locking files  |
;;_______________________________________|

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

; Don't use lock files (.#<file>) because they annoy build systems
(setq create-lockfiles nil)

;;; backup/autosave to specific .emacs.d directories
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))


;;---------------------------|
;;  Which system are we on?  |
;;___________________________|


;; Create function for mac-fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; mac friendly font
;(set-face-attribute 'default nil :font "Monaco" :height
;(set-face-attribute 'default nil :height 140)
(custom-set-faces
  '(default ((t (:height 140 :family "Inconsolata"))))
 )


;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote toggle-fullscreen))


;;---------------------------------------------
;; Load / install and setup the right packages
;;_____________________________________________


(package-initialize)

(desktop-save-mode 1)

(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(magit
     diminish
     dired+
     dired-details+
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
     ace-jump-buffer
     ido-ubiquitous
     auto-complete)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(require 'setup-erlang-mode)
(require 'sane-defaults)

;; Setup environment variables from the user's shell.
(when is-mac
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

(defmacro λ (&rest body)
  `(lambda ()
     (interactive)
     ,@body))

;; setup files - keep extension specific setup here, to enable/disable extensions
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'magit '(require 'setup-magit))

;;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Make dired less verbose
(require 'dired+)
(require 'dired-details+)
(diredp-make-find-file-keys-reuse-dirs)
(setq-default dired-details-hidden-string " ") ; string before each line in dired

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'erlang-mode)

(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace)
  (set-buffer-file-coding-system 'utf-8))

;; Various superfluous white-space. Just say no.
(add-hook 'before-save-hook 'cleanup-buffer-safe)

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (cleanup-buffer-safe)
  (indent-region (point-min) (point-max)))

(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Use ido everywhere
(require 'ido)
(ido-mode t)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

;; (ido-ubiquitous-use-new-completing-read webjump 'webjump)
;; (ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
;; (ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)


(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")

(require 'key-bindings)

(require 'appearance)
