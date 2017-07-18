(in-package "CL-USER")

(mapcar #'(lambda (filename) (load (compile-file filename)))
	'("main"))
