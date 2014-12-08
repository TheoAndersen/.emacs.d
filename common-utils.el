(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  ;; (untabify (point-min) (point-max)) ;; uncommented because it interfered with Makefile-mode where makefiles requires tabs..
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

(defmacro λ (&rest body)
  `(lambda ()
     (interactive)
     ,@body))

(global-set-key (kbd "C-c n") 'cleanup-buffer)

(provide 'common-utils)
