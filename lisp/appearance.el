; no splash screen
(setq inhibit-startup-message t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Create function for mac-fullscreent
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote toggle-fullscreen))

(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")

;; Customize background color of lighlighted line
;; (set-face-background 'hl-line "#222222")

;; Highlight current line
(global-hl-line-mode 1)

;; Theme adjustmens
(load-theme 'zenburn t)
(set-face-background 'default "#3a3a3a") ;; a little darker background please
;(set-face-background 'helm-ff-file "#2F362A")
;(set-face-background 'helm-header "2F362A")
(set-face-attribute 'region nil :background "#000") ;; To hard to see regions if not very black
;; (set-face-attribute 'helm-ff-file nil :background "#2F362A")
;; (set-face-attribute 'helm-ff-directory nil :background "#2F362A")
;; (set-face-attribute 'helm-ff-executable nil :background "#2F362A")
;; (set-face-attribute 'helm-ff-invalid-symlink nil :background "#2F362A")
;; (set-face-attribute 'helm-ff-symlink nil :background "#2F362A")
;; (set-face-attribute 'helm-ff-prefix nil :background "#2F362A")
;; (set-face-attribute 'helm-header nil :background "#2F362A")


;; Highlight in yasnippet
;(set-face-background 'yas/field-highlight-face "#333399")

;; org-mode colors
(setq org-todo-keyword-faces
      '(
        ("INPR" . (:foreground "yellow" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("IMPEDED" . (:foreground "red" :weight bold))
        ))

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; Make zooming affect frame instead of buffers
(require 'zoom-frm)

;; Sweet window-splits
(defadvice split-window-right (after balance activate) (balance-windows))
(defadvice delete-window (after balance activate) (balance-windows))

(require 'chgbackground)

(provide 'appearance)
