; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Ozan Yıldız                      *
; *********************************************

;; utility functions 
(load "tokens.lisp")
(load "lib.lisp")

(defun gppinterpreter (filename)
  (with-open-file (stream filename)
    (do ((line (read-line stream nil) (read-line stream nil)))
      ((null line))
      ;;(print (init line))
      (if (is-definition (init line))
        (format t "~a~%" "COMMENT")
        (if (is-comment (init line) )
          (format t "~a~%" "COMMENT")
          (let ((*current* (init line)))
              ;;(print (parse2 (init line))) ;; <-----
              (mapcan 
                #'(lambda (*item*) 
                  ;(print (gethash *item* *tokens*))
                  (cond
                    ;;((null *current*))
                    ((is-value (init *item*)) (format t "~a~%" "VALUE"))
                    ((gethash *item* *tokens*) (format t "~a~%" (gethash *item* *tokens*)))
                    
                    ((is-identifier (init *item*)) (format t "~a~%" "IDENTIFIER"))
                    ;;(t (print *current*))
                  )
                ) 
                (parse2 (init line)))
              
          )
        )
      ) ;; end of is-definition


    )
  )
)
