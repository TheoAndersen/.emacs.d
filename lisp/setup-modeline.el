(use-package diminish
  :ensure t
  :init
  (defmacro rename-modeline (package-name mode new-name)
    `(eval-after-load ,package-name
       '(defadvice ,mode (after rename-modeline activate)
          (setq mode-name ,new-name)))))

(setq-default mode-line-
              '("%e" ; print error message about full memory.
                mode-line-front-space
                                        ; mode-line-mule-info
                                        ; mode-line-client
                                        ; mode-line-modified
                                        ; mode-line-remote
                                        ; mode-line-frame-identification
                mode-line-buffer-identification
                "   "
                                        ; mode-line-position
                                        ; (vc-mode vc-mode)
                                        ; "  "
                mode-line-modes
                "   "
                                        ; mode-line-misc-info
                display-time-string
                "   "
                battery-mode-line-string
                mode-line-end-spaces)
              )

(display-time-mode 1)
(setq display-time-format "%a %m/%d%t%R") ;"%a %m/%d%t%R")
(display-battery-mode 1)
(setq battery-mode-line-format "%b%p%%") ; Default: "[%b%p%%]"

(diminish 'isearch-mode)

(provide 'setup-modeline)
