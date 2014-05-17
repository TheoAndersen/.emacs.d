(setq load-path (cons  "usr/local/Cellar/erlang/R16B03-1/lib/erlang/tools-2.6.6.4/emacs" load-path))
(setq erlang-root-dir "/usr/local/Cellar/erlang/R16B03-1/lib/erlang/lib")
(setq exec-path (cons "/usr/local/Cellar/erlang/R16B03-1/lib/erlang/bin" exec-path))
(require 'erlang-start)
(require 'erlang-flymake)
(require 'erlang-eunit)

(add-hook 'erlang-mode-hook
     (lambda ()
        (setq inferior-erlang-machine-options
                        '(
                        "-sname" "emacs"
                        "-pa" "apps/*/ebin"
                        ;"-boot" "start_sasl"
                        ))
          (imenu-add-to-menubar "imenu")))

(provide 'setup-erlang-mode)
