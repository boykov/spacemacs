;;; core-keybindings.el --- Spacemacs Core File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(require 'core-funcs)

(defvar spacemacs/prefix-titles nil
  "alist for mapping command prefixes to long names.")

(defvar spacemacs-default-map (make-sparse-keymap)
  "Base keymap for all spacemacs leader key commands.")

(defun spacemacs/translate-C-i (_)
  "If `dotspacemacs-distinguish-gui-tab' is non nil, the raw key
sequence does not include <tab> or <kp-tab>, and we are in the
gui, translate to [C-i]. Otherwise, [9] (TAB)."
  (interactive)
  (if (and (not (cl-position 'tab (this-single-command-raw-keys)))
           (not (cl-position 'kp-tab (this-single-command-raw-keys)))
           dotspacemacs-distinguish-gui-tab
           (display-graphic-p))
      [C-i] [?\C-i]))
(define-key key-translation-map [?\C-i] 'spacemacs/translate-C-i)

;; (defun spacemacs/translate-C-m (_)
;;   "If `dotspacemacs-distinguish-gui-ret' is non nil, the raw key
;; sequence does not include <ret>, and we are in the gui, translate
;; to [C-m]. Otherwise, [9] (TAB)."
;;   (interactive)
;;   (if (and
;;        (not (cl-position 'return (this-single-command-raw-keys)))
;;        (not (cl-position 'kp-enter (this-single-command-raw-keys)))
;;        dotspacemacs-distinguish-gui-ret
;;        (display-graphic-p))
;;     [C-m] [?\C-m]))
;; (define-key key-translation-map [?\C-m] 'spacemacs/translate-C-m)

(defun spacemacs/set-leader-keys (key def &rest bindings)
  "Add KEY and DEF as key bindings under
`dotspacemacs-leader-key' and `dotspacemacs-emacs-leader-key'.
KEY should be a string suitable for passing to `kbd', and it
should not include the leaders. DEF is most likely a quoted
command. See `define-key' for more information about the possible
choices for DEF. This function simply uses `define-key' to add
the bindings.

For convenience, this function will accept additional KEY DEF
pairs. For example,

\(spacemacs/set-leader-keys
   \"a\" 'command1
   \"C-c\" 'command2
   \"bb\" 'command3\)"
  (while key
    (define-key spacemacs-default-map (kbd key) def)
    (setq key (pop bindings) def (pop bindings))))
(put 'spacemacs/set-leader-keys 'lisp-indent-function 'defun)

(defalias 'evil-leader/set-key 'spacemacs/set-leader-keys)

(defun spacemacs//acceptable-leader-p (key)
  "Return t if key is a string and non-empty."
  (and (stringp key) (not (string= key ""))))

(defun spacemacs//init-leader-mode-map (mode map &optional minor)
  "Check for MAP-prefix. If it doesn't exist yet, use `bind-map'
to create it and bind it to `dotspacemacs-major-mode-leader-key'
and `dotspacemacs-major-mode-emacs-leader-key'. If MODE is a
minor-mode, the third argument should be non nil."
  (let* ((prefix (intern (format "%s-prefix" map)))
         (leader1 (when (spacemacs//acceptable-leader-p
                         dotspacemacs-major-mode-leader-key)
                    dotspacemacs-major-mode-leader-key))
         (leader2 (when (spacemacs//acceptable-leader-p
                         dotspacemacs-leader-key)
                    (concat dotspacemacs-leader-key
                            (unless minor " m"))))
         (emacs-leader1 (when (spacemacs//acceptable-leader-p
                               dotspacemacs-major-mode-emacs-leader-key)
                          dotspacemacs-major-mode-emacs-leader-key))
         (emacs-leader2 (when (spacemacs//acceptable-leader-p
                               dotspacemacs-emacs-leader-key)
                          (concat dotspacemacs-emacs-leader-key
                                  (unless minor " m"))))
         (leaders (delq nil (list leader1 leader2)))
         (emacs-leaders (delq nil (list emacs-leader1 emacs-leader2))))
    (or (boundp prefix)
        (progn
          (eval
           `(bind-map ,map
              :prefix-cmd ,prefix
              ,(if minor :minor-modes :major-modes) (,mode)
              :keys ,emacs-leaders
              :evil-keys ,leaders
              :evil-states (normal motion visual evilified)))
          (boundp prefix)))))

(defun spacemacs/set-leader-keys-for-major-mode (mode key def &rest bindings)
  "Add KEY and DEF as key bindings under
`dotspacemacs-major-mode-leader-key' and
`dotspacemacs-major-mode-emacs-leader-key' for the major-mode
MODE. MODE should be a quoted symbol corresponding to a valid
major mode. The rest of the arguments are treated exactly like
they are in `spacemacs/set-leader-keys'."
  (let* ((map (intern (format "spacemacs-%s-map" mode))))
    (when (spacemacs//init-leader-mode-map mode map)
      (while key
        (define-key (symbol-value map) (kbd key) def)
        (setq key (pop bindings) def (pop bindings))))))
(put 'spacemacs/set-leader-keys-for-major-mode 'lisp-indent-function 'defun)

(defalias
  'evil-leader/set-key-for-mode
  'spacemacs/set-leader-keys-for-major-mode)

(defun spacemacs/set-leader-keys-for-minor-mode (mode key def &rest bindings)
  "Add KEY and DEF as key bindings under
`dotspacemacs-major-mode-leader-key' and
`dotspacemacs-major-mode-emacs-leader-key' for the minor-mode
MODE. MODE should be a quoted symbol corresponding to a valid
minor mode. The rest of the arguments are treated exactly like
they are in `spacemacs/set-leader-keys'."
  (let* ((map (intern (format "spacemacs-%s-map" mode))))
    (when (spacemacs//init-leader-mode-map mode map t)
      (while key
        (define-key (symbol-value map) (kbd key) def)
        (setq key (pop bindings) def (pop bindings))))))
(put 'spacemacs/set-leader-keys-for-minor-mode 'lisp-indent-function 'defun)

(provide 'core-keybindings)
