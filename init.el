;;; init.el --- Spacemacs Initialization File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a
;; lower value in your dotfile (function `dotspacemacs/user-config')
(setq gc-cons-threshold 100000000)

(defconst spacemacs-version          "0.200.4" "Spacemacs version.")
(defconst spacemacs-emacs-min-version   "24.4" "Minimal version of Emacs.")

(defconst eab-spacemacs-path (concat user-emacs-directory "private/eab-spacemacs/"))

(load-file (concat eab-spacemacs-path "fix-esup.el"))

(require 'package)
(defun package--get-activatable-pkg (pkg-name)
  ;; Is "activatable" a word?
  (let ((pkg-descs (sort (cdr (assq pkg-name package-alist))
                         (lambda (p1 p2)
                           (let ((v1 (package-desc-version p1))
                                 (v2 (package-desc-version p2)))
                             (or
                              (version-list-< v2 v1)))))))
    ;; Check if PACKAGE is available in `package-alist'.
    (while
        (when pkg-descs
          (let ((available-version (package-desc-version (car pkg-descs))))
            (package-disabled-p pkg-name available-version)))
      (setq pkg-descs (cdr pkg-descs)))
    (car pkg-descs)))

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (message (concat "Your version of Emacs (%s) is too old. "
                     "Spacemacs requires Emacs version %s or above.")
             emacs-version spacemacs-emacs-min-version)
  (or (fboundp 'insert-string) (defalias 'insert-string 'insert))
  (setq browse-url-mosaic-program nil)
  (load-file (concat eab-spacemacs-path
		     "local/spacemacs/core/core-load-paths.el"))
  (require 'core-spacemacs)
  (setq dotspacemacs-filepath (concat eab-spacemacs-path ".spacemacs"))
  (spacemacs/init)
  (spacemacs/maybe-install-dotfile)
  (configuration-layer/sync)
  (spacemacs-buffer/display-info-box)
  (spacemacs/setup-startup-hook)
  (require 'server)
  (unless (server-running-p) (server-start)))
