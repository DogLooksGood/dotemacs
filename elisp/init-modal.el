;;; -*- lexical-binding: t -*-

(straight-use-package '(meow :type git :host github :repo "DogLooksGood/meow"))

(+pdump-packages 'meow)

(defvar +magit-keymap
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "s") #'magit-status)
    (define-key keymap (kbd "b") #'magit-blame)
    (define-key keymap (kbd "d") #'magit-diff)
    keymap))

(defun meow-setup ()
  ;; Programmer Dvorak layout on ansi keyboard
  (setq meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-ansi
        meow-cheatsheet-layout meow-cheatsheet-layout-dvp)
  ;; it's not a good idea to have a complex leader keymap
  ;; here we create bindings for necessary, high frequency commands
  (meow-leader-define-key
   ;; reverse command query
   '("^" . meow-keypad-describe-key)
   ;; cheatsheet
   '("?" . meow-cheatsheet)
   ;; high frequency keybindings
   '("e" . "C-x C-e")
   '(")" . "C-)")
   '("}" . "C-}")
   '("." . "M-.")
   '("," . "M-,")
   ;; window management
   '("w" . other-window)
   '("W" . +rotate-window)
   '("o" . delete-other-windows)
   '("s" . +split-window-dwim)
   ;; high frequency commands
   '("$" . +change-theme)
   '(";" . comment-dwim)
   '("k" . kill-this-buffer)
   '("p" . project-find-file)
   '("j" . project-switch-to-buffer)
   '("d" . dired)
   '("b" . switch-to-buffer)
   '("r" . rg-project)
   '("f" . find-file)
   '("i" . imenu)
   '("a" . "M-x")
   (cons "v" +magit-keymap)
   ;; toggles
   '("t" . treemacs-select-window)
   '("L" . display-line-numbers-mode)
   '("T" . telega)
   '("P" . pass)
   '("R" . org-roam-mode)
   '("A" . org-agenda)
   '("D" . docker)
   '("W" . writeroom-mode))
  (meow-motion-overwrite-define-key
   '("'" . repeat))
  (meow-normal-define-key
   '("*" . meow-expand-0)
   '("=" . meow-expand-9)
   '("!" . meow-expand-8)
   '("[" . meow-expand-7)
   '("]" . meow-expand-6)
   '("{" . meow-expand-5)
   '("+" . meow-expand-4)
   '("}" . meow-expand-3)
   '(")" . meow-expand-2)
   '("(" . meow-expand-1)
   '("1" . digit-argument)
   '("2" . digit-argument)
   '("3" . digit-argument)
   '("4" . digit-argument)
   '("5" . digit-argument)
   '("6" . digit-argument)
   '("7" . digit-argument)
   '("8" . digit-argument)
   '("9" . digit-argument)
   '("0" . digit-argument)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("C" . meow-change-save)
   '("d" . meow-C-d)
   '("D" . meow-backspace)
   '("e" . meow-line)
   '("E" . meow-kmacro-lines)
   '("f" . meow-find)
   '("F" . meow-find-expand)
   '("g" . meow-cancel)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-join)
   '("k" . meow-kill)
   '("K" . meow-kill-append)
   '("l" . meow-till)
   '("L" . meow-till-expand)
   '("m" . meow-mark-word)
   '("M" . meow-mark-symbol)
   '("n" . meow-next)
   '("N" . meow-next-expand)
   '("o" . meow-block)
   '("O" . meow-block-expand)
   '("p" . meow-prev)
   '("P" . meow-prev-expand)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-search)
   '("S" . meow-pop-search)
   '("t" . meow-right)
   '("T" . meow-right-expand)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("V" . meow-kmacro-matches)
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("x" . meow-save)
   '("X" . meow-sync-grab)
   '("y" . meow-yank)
   '("Y" . meow-yank-pop)
   '("z" . meow-pop)
   '("Z" . meow-pop-all-selection)
   '("<" . meow-beginning-of-thing)
   '(">" . meow-end-of-thing)
   '("&" . meow-query-replace)
   '("%" . meow-query-replace-regexp)
   '("@" . recenter-top-bottom)
   '("'" . repeat)
   '("<escape>" . meow-last-buffer)
   '("\\" . quoted-insert)))

(setq
 meow-visit-sanitize-completion nil
 meow-esc-delay 0.001
 meow-keypad-describe-delay 0.5
 meow-select-on-change t
 meow-selection-command-fallback '((meow-replace . meow-page-up)
                                   (meow-change . meow-change-char)
                                   (meow-save . meow-save-empty)
                                   (meow-kill . meow-C-k)
                                   (meow-cancel . meow-page-down)
                                   (meow-pop . meow-pop-grab)
                                   (meow-delete . meow-C-d)))

(require 'meow)

(meow-global-mode 1)

(with-eval-after-load "meow"
  ;; make Meow usable in TUI Emacs
  (meow-esc-mode 1)
  ;; (add-hook 'meow-mode-hook 'meow-esc-mode)
  (add-to-list 'meow-mode-state-list '(inf-iex-mode . normal))
  (add-to-list 'meow-mode-state-list '(authinfo-mode . normal))
  (add-to-list 'meow-grab-fill-commands 'eval-expression)

  ;; use << and >> to select to bol/eol
  (add-to-list 'meow-char-thing-table '(?> . line))
  (add-to-list 'meow-char-thing-table '(?< . line))
  ;; define our command layout
  (meow-setup)
  ;; add indicator to modeline
  (meow-setup-indicator))

(provide 'init-modal)
