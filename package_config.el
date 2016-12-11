;; Used to load packages installed via "package.el"

;; Base Plugins and configuration
;;
(require 'evil)
(evil-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "s" 'split-window-below
  "v" 'split-window-right)

(require 'neotree)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Elixir Specific plugins
;;
(require 'alchemist)
(require 'elixir-mode)
