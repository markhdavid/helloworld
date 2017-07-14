;;; -*- lisp -*-

(in-package :cl-user)

(load "load-system")

;;;; Load Unit Test System

;;; Note: use underscore (_) as the most conservative word separator,
;;; as opposed to, say, space or hyphen.

(let* ((defaults
         (merge-pathnames "third_party/lisp-unit/" *load-pathname*))
       (package-pathname
         (make-pathname :name "package" :type "lisp" :defaults defaults))
       (lisp-unit-pathname
         (make-pathname :name "lisp-unit" :type "lisp" :defaults defaults)))
  (load package-pathname)
  (load (compile-file lisp-unit-pathname)))





;;;; Load TESTS Module

(defparameter *hello-world-unit-tests-failure-p* nil
  "Initalized here to nil, tests.lisp sets true upon test failure.")

(format t "~%*** Loading Tests ***~%")

(dolist (pathname '("package-tests" "hello-tests"))
  (load 
   (make-pathname
    :name pathname :type "lisp" :defaults *load-pathname*)))


;;; Now done with tests. That should have printed "tests done". We now
;;; exit...





;;;; Exit

(defconstant *exit-success-value* 0)
(defconstant *exit-failure-value* 1)

(excl:exit (if *hello-world-unit-tests-failure-p*
               *exit-failure-value*
               *exit-success-value*)
           :quiet t)
