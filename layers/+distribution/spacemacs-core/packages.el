;;; packages.el --- Spacemacs Layer packages File
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar spacemacs-core-packages
  '(
    async
    bind-key
    dash
    diminish
    evil
    evil-leader
    page-break-lines
    projectile
    use-package
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar spacemacs-core-excluded-packages '()
  "List of packages to exclude.")

(defun spacemacs-core/init-async ()
  (use-package async))

(defun spacemacs-core/init-bind-key ())

(defun spacemacs-core/init-dash ())

(defun spacemacs-core/init-diminish ()
  (require 'diminish))

(defun spacemacs-core/init-evil ()
  (use-package evil))

(defun spacemacs-core/init-evil-leader ()
  (use-package evil-leader))

(defun spacemacs-core/init-page-break-lines ()
  (use-package page-break-lines))

(defun spacemacs-core/init-projectile ()
  (use-package projectile))

(defun spacemacs-core/init-use-package ())
