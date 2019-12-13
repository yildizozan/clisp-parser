; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Ozan Yıldız                      *
; *********************************************

;; utility functions 
(load "tokens.lisp")
(load "lib.lisp")

;; -----------------------------------------------------
;; Test code...
(defun test_on_test_data ()
	(print "....................................................")
	(print "Testing ....")
	(print "....................................................")
	(terpri)

    (print "....................................................")
	(print "Test func init")
	(print "....................................................")
	(terpri)
    (format t "(list 1 2 123) => ~a~%" (init "(list 1 2 123)") )

    (print "....................................................")
	(print "Test func is-alphanumeric-string")
	(print "....................................................")
	(terpri)
    (format t "sumup8   is-alphanumeric-string ~a~%" (is-alphanumeric-string '(#\s #\u #\m #\u #\p #\8)))
    (format t "(deffun  is-alphanumeric-string ~a~%" (is-alphanumeric-string '(#\( #\d #\e #\f #\f #\u #\n)))
  
    (print "....................................................")
	(print "Test func is-identifier")
	(print "....................................................")
	(terpri)
    (format t "8sumup is-identifier ~a~%" (is-identifier '(#\8 #\u #\m #\u #\p #\8)))
    (format t "sum8up is-identifier ~a~%" (is-identifier '(#\s #\u #\m #\8 #\u #\p)))
    (format t "sumup8 is-identifier ~a~%" (is-identifier '(#\s #\u #\m #\u #\p #\8)))

    (print "....................................................")
	(print "Test func is-numberic")
	(print "....................................................")
	(terpri)
    (format t "123  is-numberic ~a~%" (is-numeric (init "123")) )
    (format t "123a is-numberic ~a~%" (is-numeric (init "123a")) )

    (print "....................................................")
	(print "Test func is-value")
	(print "....................................................")
	(terpri)
    (format t "123  is-value ~a~%" (is-value (init "123")) )
    (format t "0123 is-value ~a~%" (is-value (init "0123")) )
    (format t "1230 is-value ~a~%" (is-value (init "1230")) )
    (format t "(    is-value ~a~%" (is-value (init "(")) )

    (print "....................................................")
	(print "Test func is-definition")
	(print "....................................................")
	(terpri)
    (format t "\"Definition\" is-definition ~a~%" (is-definition (init "\"Definition\"")) )
    (format t "(list 1 2)     is-definition ~a~%" (is-definition (init "(list 1 2)")) )

    (print "....................................................")
	(print "Test func is-comment")
	(print "....................................................")
	(terpri)
    (format t ";; helloworld.g++  is-comment ~a~%" (is-comment (init ";; helloworld.g++")) )
    (format t "(list 1 2)         is-comment ~a~%" (is-comment (init "(list 1 2)")) )

)

;; test code...
(test_on_test_data)