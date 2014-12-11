(if is-mac nil ; windows
  (setq load-path (cons  "C:/Program Files/erl6.0/lib/tools-2.6.14/emacs" load-path))
  (setq erlang-root-dir "C:/Program Files/erl6.0/lib/")
  (setq exec-path (cons "C:/Program Files/erl6.0/lib/bin" exec-path))
)

(when is-mac
  (setq load-path (cons  "/usr/local/Cellar/erlang/17.3/lib/erlang/tools-2.6.6.4/emacs" load-path))
  (setq erlang-root-dir "/usr/local/Cellar/erlang/17.3/lib/erlang/lib")
  (setq exec-path (cons "/usr/local/Cellar/erlang/17.3/lib/erlang/bin" exec-path))
)

(require 'erlang-start)
(require 'erlang-flymake)
(require 'erlang-eunit)
;;(require 'edts)

;; C-, find symbol
;; M-<space> autocomplete (and with documentation)

(define-key edts-mode-map (kbd "<f12>") 'edts-find-source-under-point)
(define-key edts-mode-map (kbd "C-,") 'helm-projectile-grep)
(define-key edts-mode-map (kbd "C-S-b") 'edts-code-compile-and-display)
(define-key edts-mode-map (kbd "M-SPC") 'auto-complete)

(add-hook 'erlang-mode-hook
     (lambda ()
        (setq inferior-erlang-machine-options
                        '(
                        "-sname" "emacs"
                        "-pa" "apps/*/ebin"
                        ;"-boot" "start_sasl"
                        ))
        (imenu-add-to-menubar "imenu")
        ))


(defun my-after-init-hook ()
  (require 'edts-start))

(add-hook 'after-init-hook 'my-after-init-hook)

;;(add-to-list 'ac-modes 'erlang-mode)

(provide 'setup-erlang-mode)
