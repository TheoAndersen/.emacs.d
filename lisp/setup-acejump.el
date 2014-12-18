(use-package ace-jump-mode
  :ensure t
  :bind ("C-ø" . ace-jump-char-mode)
  :init
  (use-package ace-jump-buffer
    :ensure t)
  (use-package ace-link
    :ensure t
    :init
    (ace-link-setup-default))
  (use-package ace-jump-zap
    :ensure t)
  (bind-keys :prefix-map ace-jump-map
             :prefix "C-c j"
             ("c" . ace-jump-char-mode)
             ("l" . ace-jump-line-mode)
             ("w" . ace-jump-word-mode)
             ("b" . ace-jump-buffer)
             ("o" . ace-jump-buffer-other-window)
             ("p" . ace-jump-projectile-buffers)
             ("z" . ace-jump-zap-to-char)
             ("Z" . ace-jump-zap-up-to-char)))

(bind-key "C-x SPC" 'cycle-spacing)

(provide 'setup-acejump)
