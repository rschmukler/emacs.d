; This file handles all theming related configuration of my Emacs

; Set a transparent background
(set-frame-parameter (selected-frame) 'alpha '(85))
(add-to-list 'default-frame-alist '(alpha . (85)))

; Disable the menu bar, tool bar and scroll bar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

; Set a nice font
(add-to-list 'default-frame-alist '(font . "Hasklig"))

(setq org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)

;; Use doom theme

(require 'doom-themes)
(load-theme 'doom-one t)

(require 'doom-neotree)
