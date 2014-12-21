;; all the mac specific setup
;;----------------------------

;; right option isn't emacs.. so that we can make {  and }
(when is-mac
  (setq mac-right-option-modifier nil)
  (setq mac-left-option-modifier 'Meta)
  )

(defun read-system-path ()
  (with-temp-buffer
    (insert-file-contents "/etc/paths")
    (goto-char (point-min))
    (replace-regexp "\n" ":")
    (thing-at-point 'line)))

;; Setup environment variables from the user's shell.
(when is-mac
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))


(setenv "PATH" (read-system-path))
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))

;; mac friendly font
(when is-mac
 (custom-set-faces
  '(default ((t (:height 180 :family "Inconsolata" :weight medium))))
   )
 )


(message "setup mac")
(provide 'setup-mac)
