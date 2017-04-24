;; This file defines package dependencies

(require 'package)
(require 'cl)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(defvar prelude-packages
  '(
    all-the-icons
    atom-one-dark-theme
    aggressive-indent
    alchemist
    company
    dockerfile-mode
    doom-themes
    elixir-mode
    elm-mode
    evil
    evil-leader
    evil-surround
    exec-path-from-shell
    flycheck
    flycheck-credo
    flycheck-mix
    flycheck-rust
    flycheck-elm
    git-gutter-fringe
    helm
    helm-projectile
    helm-ag
    ;; hlinum
    neotree
    nlinum
    perspective
    persp-projectile
    popwin
    projectile
    racer
    rust-mode
    smart-mode-line
    smart-mode-line-powerline-theme
  )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  "Check if all packages in `prelude-packages' are installed."
  (every #'package-installed-p prelude-packages))

(defun prelude-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package prelude-packages)
    (add-to-list 'prelude-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun prelude-require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'prelude-require-package packages))

(define-obsolete-function-alias 'prelude-ensure-module-deps 'prelude-require-packages)

(defun prelude-install-packages ()
  "Install all packages listed in `prelude-packages'."
  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (prelude-require-packages prelude-packages)))

;; run package installation
(prelude-install-packages)
