(require 'omnisharp)
(require 'popup)
(require 'csharp-mode)
(require 'company)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HOV GENERELLE GENVEJSTASTER FOR PROGRAMMERING ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ? F1 skal være hjælp ligemeget hvad... hjælp på den nuværende type
;; ? Tab skal complete autocomplete ?
;; x M-SPC er autocomplete (da C-SPC er mark, som man ellers normalt
;; ? Hvad er det nu som altid bygger?
;; ? Noget skal gøre at man kan se oversigt over folder struktur


;; farverne er helt æmrkelige
;; flycheck er slet ikke tydeligt.. man kan ikke se hvad der er fejl og hvad der ikke er

(setq omnisharp-server-executable-path "/Users/Theo/Downloads/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")

(define-key csharp-mode-map (kbd "C-S-b") 'omnisharp-build-in-emacs)
(define-key csharp-mode-map (kbd "M-SPC") 'omnisharp-auto-complete)
(define-key csharp-mode-map (kbd "C-,") 'omnisharp-helm-find-symbols)
(define-key csharp-mode-map (kbd "<f12>") 'omnisharp-go-to-definition)
(define-key csharp-mode-map (kbd "C-<f12>") 'omnisharp-helm-find-usages)
(define-key csharp-mode-map (kbd "S-<f12>") 'omnisharp-find-implementations)
(define-key csharp-mode-map (kbd "C-.") 'omnisharp-run-code-action-refactoring)
(define-key csharp-mode-map (kbd "C-r r") 'omnisharp-rename)
(define-key csharp-mode-map (kbd "C-r u") 'omnisharp-fix-usings) ;; adds missing as well
;;(define-key csharp-mode-map (kbd "C-r m") 'omnisharp-?? extract method?
;; - Refactorings can do this... but specific points to do this would be nice
;; add new csharp file

(defun my-csharp-mode ()
;  (add-to-list 'company-backends 'company-omnisharp)
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode) ;; how do i make it only open when omnisharp is loaded?
  (turn-on-eldoc-mode))

(setq omnisharp-company-strip-trailing-brackets nil)
(add-hook 'csharp-mode-hook 'my-csharp-mode)

(message "--> Loaded setup-csharp")
(provide 'setup-csharp)
