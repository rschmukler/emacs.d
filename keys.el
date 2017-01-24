;; Configuration related to keys

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "SPC" 'mode-line-other-buffer
  "f" 'helm-projectile-ag
  "n" 'neotree-project-dir
  "s" 'split-window-below
  "v" 'split-window-right
  "]" 'flycheck-next-error
  "[" 'flycheck-previous-error
)

;; Neotree
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;; Helm
(define-key helm-map (kbd "C-j")  'helm-next-line)
(define-key helm-map (kbd "C-k")  'helm-previous-line)
(define-key helm-map (kbd "TAB")  'helm-execute-persistent-action)

(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-k") 'windmove-up)

(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)
(define-key evil-normal-state-map (kbd "C-b s") 'helm-projectile-switch-project)
(define-key evil-normal-state-map (kbd "g c") 'comment-or-uncomment-region)

(global-set-key (kbd "S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-<up>") 'shrink-window)
(global-set-key (kbd "S-<down>") 'enlarge-window)
(global-set-key (kbd "<escape>") 'keyboard-quit)

(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-j") 'company-select-next)
  (define-key company-active-map (kbd "C-k") 'company-select-previous)
)

;; Elixir based key bindings
(add-hook 'elixir-mode-hook
	  (lambda ()
	    (evil-leader/set-key
	      "d" 'alchemist-help-lookup-doc
	      "l" 'alchemist-goto-definition-at-point
	      "t" 'alchemist-project-toggle-file-and-tests
	      "T" 'alchemist-mix-test-stale
	      "m" 'alchemist-goto-list-symbol-definitions
	    )
	  ))



;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
