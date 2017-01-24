;; Used to load packages installed via "package.el"

;; Base Plugins and configuration
;;
(require 'evil)
(evil-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)

;; Projectile related configuration
(require 'projectile)
(setq projectile-remember-window-configs t)
;; (require 'perspective)
;; (persp-mode)
;; (require 'persp-projectile)



(require 'helm)
(helm-mode 1)
(require 'helm-projectile)
(require 'helm-ag)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)

(setq helm-locate-fuzzy-match t)
;; (helm-projectile-toggle 1)

(defun helm-projectile-persp-switch-project ()
  "Switch Projectile Projects in Persp using Helm"
  (interactive)
  (helm :buffer "*helm projectile*"
        :prompt "Select Project: "
        :sources 'helm-source-projectile-projects
        :action (lambda (project) (message "Switching to project %s" project)))
)

;; disable popwin-mode in an active Helm session It should be disabled
;; otherwise it will conflict with other window opened by Helm persistent
;; action, such as *Help* window.
(require 'popwin)
(push '("^\*helm.+\*$" :regexp t) popwin:special-display-config)
(add-hook 'helm-after-initialize-hook (lambda ()
                                        (popwin:display-buffer helm-buffer t)
                                        (popwin-mode -1)))
;;  Restore popwin-mode after a Helm session finishes.
(add-hook 'helm-cleanup-hook (lambda () (popwin-mode 1)))



(require 'neotree)
(require 'all-the-icons)
(setq neo-theme 'icons)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
	(file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
	(if (neo-global--window-exists-p)
	    (progn
	      (neotree-dir project-dir)
	      (neotree-find file-name)))
      (message "Could not find git project root."))))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq-default company-idle-delay 0)

(require 'flycheck)
(require 'flycheck-mix)
(require 'flycheck-credo)
(eval-after-load 'flycheck (lambda ()
  (flycheck-credo-setup)
  (flycheck-mix-setup)

  (flycheck-define-checker elixir-dialyzer
    "Erlang syntax checker based on dialyzer."
    :command ("mix" "dialyzer" "--fullpath" "--no-check")
    :predicate
    (lambda ()
      (and
       (flycheck-buffer-saved-p)
       (file-exists-p "deps/dialyxir")))
    :error-patterns
    ((warning line-start
              (file-name)
              ":"
              line
              ": warning: "
              (message)
              line-end)
     (error line-start
            (file-name)
            ":"
            line
            ":"
            (message)
            line-end))
    :working-directory elixir-flycheck-project-root
    :modes elixir-mode)
   (add-to-list 'flycheck-checkers 'elixir-dialyzer t)

))
(add-hook 'elixir-mode-hook 'flycheck-mode)

;; Fix Emacs GUI $PATH bindings
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;
;; Git Gutter Related Settings
;;

(require 'git-gutter-fringe)
(global-git-gutter-mode 1)
(setq-default fringes-outside-margins t)
(define-fringe-bitmap 'git-gutter-fr:added
  [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
  nil nil 'center)
(define-fringe-bitmap 'git-gutter-fr:modified
  [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
  nil nil 'center)
(define-fringe-bitmap 'git-gutter-fr:deleted
  [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248]
  nil nil 'center)

   ;; Refreshing git-gutter
   (advice-add 'evil-force-normal-state :after 'git-gutter)
   (add-hook 'focus-in-hook 'git-gutter:update-all-windows)

;; Colored fringe bars


;; Elixir Specific plugins
;;
(require 'alchemist)
(require 'elixir-mode)
