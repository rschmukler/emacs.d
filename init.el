
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;; Some base configuration

(setq inhibit-startup-screen t)
(setq backup-directory-alist `(("." . "~/.emacs-tmp/")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs-tmp/" t)))

;; Spaces vs Tabs, haha
(setq c-basic-indent 2)
(setq c-default-style "linux")
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

;; Turn off line wrapping
(setq-default truncate-lines 1)

(load-user-file "package.el")
(load-user-file "package_config.el")
(load-user-file "theming.el")
(add-hook 'after-init-hook (lambda nil (load-user-file "keys.el")))

(evil-set-initial-state 'term-mode 'emacs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0f0db69b7a75a7466ef2c093e127a3fe3213ce79b87c95d39ed1eccd6fe69f74" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (helm-projectile git-gutter-fringe git-gutter nlinum helm-ag flycheck-mix atom-one-dark-theme swiper projectile neotree ivy helm-core helm font-lock+ flycheck elixir-mode counsel-projectile counsel company all-the-icons alchemist doom-themes evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun package-upgrade-all ()
  "Upgrade all packages automatically without showing *Packages* buffer."
  (interactive)
  (package-refresh-contents)
  (let (upgrades)
    (cl-flet ((get-version (name where)
                (let ((pkg (cadr (assq name where))))
                  (when pkg
                    (package-desc-version pkg)))))
      (dolist (package (mapcar #'car package-alist))
        (let ((in-archive (get-version package package-archive-contents)))
          (when (and in-archive
                     (version-list-< (get-version package package-alist)
                                     in-archive))
            (push (cadr (assq package package-archive-contents))
                  upgrades)))))
    (if upgrades
        (when (yes-or-no-p
               (message "Upgrade %d package%s (%s)? "
                        (length upgrades)
                        (if (= (length upgrades) 1) "" "s")
                        (mapconcat #'package-desc-full-name upgrades ", ")))
          (save-window-excursion
            (dolist (package-desc upgrades)
              (let ((old-package (cadr (assq (package-desc-name package-desc)
                                             package-alist))))
                (package-install package-desc)
                (package-delete  old-package)))))
      (message "All packages are up to date"))))
