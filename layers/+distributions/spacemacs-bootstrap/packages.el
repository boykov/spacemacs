;;; packages.el --- Mandatory Bootstrap Layer packages File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq spacemacs-bootstrap-packages
      '(
        (async :step bootstrap)
        (bind-map :step bootstrap)
        (bind-key :step bootstrap)
        (diminish :step bootstrap)
        (evil :step bootstrap)
        (hydra :step bootstrap)
        (use-package :step bootstrap)
        (which-key :step bootstrap)
        ))

(defun spacemacs-bootstrap/init-async ())
(defun spacemacs-bootstrap/init-bind-key ())
(defun spacemacs-bootstrap/init-diminish ())
(defun spacemacs-bootstrap/init-bind-map ()
  (require 'bind-map))
(defun spacemacs-bootstrap/init-evil ()
  (require 'evil))
(defun spacemacs-bootstrap/init-hydra ()
  (require 'hydra))
(defun spacemacs-bootstrap/init-use-package ()
  (require 'use-package)
  (setq use-package-verbose init-file-debug
        use-package-inject-hooks t))
(defun spacemacs-bootstrap/init-which-key ()
  (require 'which-key))

