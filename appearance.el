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

(set-face-background 'region "#464740")

;; Highlight current line
(global-hl-line-mode 1)

;; Create function for mac-fullscreen
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

(load-theme 'zenburn t)
(set-face-background 'default "#3a3a3a") ;; a little darker background please
;; Highlight in yasnippet
;(set-face-background 'yas/field-highlight-face "#333399")

;; Preeeetty font in Emacs 24/Ubuntu
(if is-mac nil
  (set-default-font "Consolas"))

;; mac friendly font
(when is-mac
 (custom-set-faces
  '(default ((t (:height 180 :family "Inconsolata" :weight medium))))
   )
 )

;(if is-mac nil
;  (set-default-font "DejaVu Sans Mono")

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

(provide 'appearance)
