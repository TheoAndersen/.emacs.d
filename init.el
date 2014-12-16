
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

;;-------------------------|
;;  Setup load-path        |
;;-------------------------|

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq lisp-dir
      (expand-file-name "lisp" user-emacs-directory))


;; Set up load path
(add-to-list 'load-path lisp-dir)
;(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
;(dolist (project (directory-files site-lisp-dir t "\\w+"))
;  (when (file-directory-p project)
;    (add-to-list 'load-path project)))

(require 'common-utils)

;;---------------------------------------|
;;  Backup / Autosave and locking files  |
;;_______________________________________|

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq create-lockfiles nil) ; Don't use lock files (.#<file>) because they annoy build systems

;;; backup/autosave to specific .emacs.d directories
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;;-----------------------------------|
;; Load / install the right packages |
;;___________________________________|

(package-initialize)
;; (desktop-save-mode 1)

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
     zoom-frm
     frame-cmds
     frame-fns
     expand-region
     perspective
     ace-jump-mode
     ace-jump-buffer
     auto-complete
     find-file-in-project
     flycheck
     company
     csharp-mode
     helm
     helm-projectile
     zenburn-theme
     edts
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(package-initialize)

;;---------------------|
;; Setup the packages  |
;;---------------------|

(when is-mac
  (require 'setup-mac)
  )
(if (eq system-type 'windows-nt)
    (require 'setup-windows)
  )

(require 'sane-defaults)
(require 'key-bindings)
(require 'appearance)
(require 'setup-ffip)
(require 'setup-helm)
(require 'setup-magit)
;; (require 'setup-autocomplete)
(require 'multiple-cursors)
(require 'setup-elisp)
(require 'setup-erlang-mode)
(require 'setup-js2-mode)
(require 'setup-rgrep)
(require 'setup-dired)
(require 'setup-csharp)
;(eval-after-load 'csharp-mode '(require 'setup-csharp))
