(in-package :cl-user)

(mapcar #'(lambda (filename) (load (compile-file filename)))
	'("main"))
