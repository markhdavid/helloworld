;;; -*- lisp -*-

(in-package :cl-user)

(load "load-system")

;;;; Exit

(defconstant *exit-success-value* 0)
(defconstant *exit-failure-value* 1)

(excl:exit *exit-success-value*
           :quiet t)
