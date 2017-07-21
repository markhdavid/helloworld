;;; -*- lisp -*-

(in-package :hello-tests)


;;;; Define Tests

(lisp-unit:define-test greater-than
    (lisp-unit:assert-true (greater-than 0 -5))
  (lisp-unit:assert-true (greater-than -5 -100))
  (lisp-unit:assert-true (greater-than 100 0)))

(lisp-unit:define-test equality
    (lisp-unit:assert-true (equal-to "two" (subseq "one two" 4)))
  (lisp-unit:assert-true (equal-to 'baz (third '(foo bar baz))))
  (lisp-unit:assert-true (equal-to "foo" (concatenate 'string '(#\f #\o #\o)))))





;;;; Testing Setup

;;; Here, we can say to "use the debugger", which during CI runs
;;; causes an error to go into the debugger.  Have this off by default
;;; for now, on the theory that an error is not necessarily a horrible
;;; internal error that means the downstream state is going to be
;;; confusing. For example, a flaky piece of code may have a runtime
;;; type error. (Not uncommon.) Meanwhile, it's safe to push ahead and
;;; run the rest of the unit tests.

(lisp-unit:use-debugger nil)





;;;; Test Listeners

;;; Here, we set up to take notice of unit-test failures.

(defun hello-world-test-listener
    (passed &rest additional-test-listener-args)
  "This is a very bare-bones lisp-unit test-listener function. In case
of success, it has no side effects and simply returns nil. In case of
failure, it prints its args, sets the special variable
cl-user:*hello-world-unit-tests-failure-p* to signal that a failure
has happened, and returns nil."
  (unless passed
    (setq cl-user:*hello-world-unit-tests-failure-p* t)
    (apply #'lisp-unit::default-listener passed additional-test-listener-args)))

;; In the big picture, the main reason for needing this to communicate
;; back to the top-level caller that a failure happened, so that a
;; failure result can returned to the CI system. Downside is that you
;; lose the printer for a failure. The output functions are not
;; exported. Gross. Sigh. For now: use unexported function name, which
;; is not clean! Later, we will fork the source to export the symbol.





;;;; Run Tests

(format t "~%*** Starting Tests ***~%")

;;; We use run-all-tests as an automated way to find and execute all
;;; tests. This avoids the serious problem of people writing tests
;;; that, unknowingly, do not actually get run by the test harness.

(lisp-unit:with-test-listener hello-world-test-listener
  (lisp-unit:run-all-tests :hello-tests))

(format t "~%*** Tests Done. ***~%")
