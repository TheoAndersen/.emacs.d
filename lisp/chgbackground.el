(defun chgbackground-is-kbd-q-mapped-to-self-insert-commandp ()
  (equal (key-binding (kbd "q"))
         'self-insert-command)
  )

;; (defun chgbackground-is-kbd-q-mapped-to-self-insert-command ()
;;   (interactive)
;;   (if (chgbackground-is-kbd-q-mapped-to-self-insert-commandp)
;;       (message (concat "yes" (buffer-name)))
;;     (message (concat "no" (buffer-name))))
;; )

(defun chgbackground-is-C-g-mapped-to-other-than-keyboard-quitp ()
  (not (equal (key-binding (kbd "C-g"))
              'keyboard-quit))
  )

;; (defun chgbackground-is-C-g-mapped-to-other-than-keyboard-quit ()
;;   (interactive)
;;   (if (chgbackground-is-C-g-mapped-to-other-than-keyboard-quitp)
;;       (message (concat "yes" (concat (buffer-name) (key-binding "C-g"))))
;;     (message (concat "no" (buffer-name))))
;;   )



(defun chgbackground-buffer-is-quitabblep ()
  ;; (not (chgbackground-is-kbd-q-mapped-to-self-insert-commandp))
   (or (not (chgbackground-is-kbd-q-mapped-to-self-insert-commandp))
       (chgbackground-is-C-g-mapped-to-other-than-keyboard-quitp)
       )
   )

(defface my-special-face
  '((t :background "#383B35"));#2F362A"))
  "face with different background-color for quitabble buffers"
  )

(defun chgbackground-change-when-buffer-is-quitabble-msg ()
  (interactive)
  ;; (if (not (minibufferp (buffer-name)))
      (if (chgbackground-buffer-is-quitabblep)
           (message (concat "Is quittable: " (buffer-name)));(fapce-remap-add-relative 'default 'my-special-face)
      (message (concat "not quittable: " (buffer-name))))
      )




(defun chgbackground-change-when-buffer-is-quitabble ()
  ;; (interactive)
   ;; (chgbackground-change-when-buffer-is-quitabble-msg)
  ;; (if (not (minibufferp (buffer-name)))
      (if (chgbackground-buffer-is-quitabblep)
          (face-remap-add-relative 'default 'my-special-face)
        )
    ;; )
  )

(defun chgbackground-set-backgroundcolor ()
  (interactive)
  (face-remap-add-relative 'default 'my-special-face)
)

(global-set-key (kbd "C-M-<f12>") 'chgbackground-set-backgroundcolor)

(add-hook 'after-change-major-mode-hook
          (lambda ()
           (chgbackground-change-when-buffer-is-quitabble)
           )
          )

(add-hook 'helm-after-action-hook
          (lambda ()
            (message (concat "helm-mode-hook (HEST): " (buffer-name)))
           )
          )

(provide 'chgbackground)

;; helm-adaptive-mode-hook 	helm-after-action-hook
;; helm-after-initialize-hook 	helm-after-persistent-action-hook
;; helm-after-update-hook 	helm-before-action-hook
;; helm-before-initialize-hook 	helm-cleanup-hook
;; helm-exit-minibuffer-hook 	helm-find-files-after-init-hook
;; helm-find-files-before-init-hook 	helm-goto-line-before-hook
;; helm-grep-mode-hook 	helm-match-plugin-mode-hook
;; helm-moccur-mode-hook 	helm-mode-hook
;; helm-move-selection-after-hook 	helm-move-selection-before-hook
;; helm-occur-match-plugin-mode-hook 	helm-select-action-hook
;; helm-update-hook
