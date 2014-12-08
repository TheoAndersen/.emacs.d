(require 'dired+)
(require 'dired-details+)

;; Make dired less verbosep
(diredp-make-find-file-keys-reuse-dirs)
(setq-default dired-details-hidden-string " ") ; string before each line in dired

(define-key dired-mode-map "i" 'dired-subtree-insert)
(define-key dired-mode-map ";" 'dired-subtree-remove)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(provide 'setup-dired)
