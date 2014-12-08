(require 'magit)

(global-set-key (kbd "C-c m") 'magit-status)
(define-key magit-status-mode-map (kbd "C-g") 'magit-quit-session)

;; appearance
(set-face-foreground 'magit-diff-file-header "yellow")
(set-face-foreground 'magit-diff-hunk-header "yellow")
(set-face-background 'magit-item-highlight "#0f004d")
(set-face-foreground 'magit-diff-none "#666666")
(set-face-foreground 'magit-diff-add "#00cc33")
(set-face-attribute 'magit-diff-add nil :inherit 'diff-context)
(set-face-foreground 'magit-diff-del "#a4121e")
(set-face-attribute 'magit-diff-del nil :inherit 'diff-context)

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

;; (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)


(autoload 'magit-status "magit")

(provide 'setup-magit)
