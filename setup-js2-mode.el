2;;--- Js2 mode settings
;;-----------------------
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-auto-indent-flag t)
(setq-default js2-global-externs '("module" "require" "jQuery" "$" "_" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-indent-on-enter-key t)
(require 'js2-mode)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(provide 'setup-js2-mode)
