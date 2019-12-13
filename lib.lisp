


(defun char-by-char (in)
  "Read char by char but input must be string"
  (with-input-from-string (is in)
        (do ((c (read-char is) (read-char is nil 'the-end)))
            ((not (characterp c)))
        (format t "~S " c)))
)

;; Create adustable string
(defun make-adjustable-string (s)
  "Create adustable string"
               (make-array 0
                           :fill-pointer 0
                           :adjustable t
                           :element-type 'character ))


(defun lexer (filename)
  "Reduce function, accumulator is *current* variable!"
  (let ((*current* (make-adjustable-string "")))
    (with-open-file (stream filename)
        (do ((*char* (read-char stream nil)
                     (read-char stream nil)))
            ((null *char*))

            ;;(print *char*)
            (if (char/= *char* #\Space)
              (progn
                (vector-push-extend *char* *current*)
                ;;(print *current*)
                (when (gethash *current* *tokens*)
                  ;;(print (gethash *current* *tokens*))
                  (setf *current* (make-adjustable-string ""))
                )
                (when (check-value *current*)

                )
              )
          )
  ))
    (print *current*)))

;; First trim space after string to char list
(defun init (str)
  (coerce (string-trim '(#\Space) str) 'list)
)

;; 
(defun is-definition (*lst*)
  (if (and (char= (car *lst*) #\") (char= (car (last *lst*)) #\"))
    t
    nil
  )
)

(defun is-comment (*lst*)
  (if (and (char= (car *lst*) #\;) (char= (car *lst*) #\;))
    t
    nil
  )
)

(defun is-digit (*char*)
  (if (digit-char-p *char*) 
    t 
    nil))

(defun is-numeric (*lst*)
  (if (= (length *lst*) 1)
    (is-digit (car *lst*))
    (and (is-digit (car *lst*)) (is-numeric (cdr *lst*)) )
  )
)

(defun is-value (*lst*)
  (cond
    ((not (digit-char-p (car *lst*))) nil)
    (t 
      (if (= (digit-char-p (car *lst*)) 0) ;; Check first item not zero
        nil
        (is-numeric *lst*)
      ) 
    )
  )

)

(defun is-alphanumeric-string (*lst*)
  (if (= (length *lst*) 1)
    (alphanumericp (car *lst*))
    (and (alphanumericp (car *lst*)) (is-alphanumeric-string (cdr *lst*)) )
  )
)

(defun is-identifier (*lst*)
  (if (digit-char-p (car *lst*)) ;; Check first item not number
    nil
    (is-alphanumeric-string *lst*)
  ) 
)

(defun parse (*lst*)
  (let ((*current* (make-adjustable-string "")) (*tokens* '()))
    (loop for *char* in *lst*
      do (if *char* ;; Continue when not nil.
        (if (char= *char* #\Space) ;; If there is character space, split.
          (progn
            (setf *tokens* (push *current* *tokens*))
            (setf *current* (make-adjustable-string ""))
          )
          (vector-push-extend *char* *current*)
        )
      )
    )
    ;; last part without space because
    ;; there is not space character last end of list
    (setf *tokens* (push *current* *tokens*))
    ;; Reverse
    (reverse *tokens*)
  )
)

(defun parse2 (*lst*)
  ;;(print *lst*)(terpri)
  (let ((*current* (make-adjustable-string "")) (*groups* '()))
    (loop for *char* in *lst*
      do
        ;;(format t "~a -> ~a" *char* *current*)
        ;;(vector-push-extend *char* *current*)
        (cond
          ((char= *char* #\Space)
            (progn
              (if (> (length *current*) 0) (setf *groups* (push *current* *groups*)))
              (setf *current* (make-adjustable-string ""))
            )
          )
          ((gethash *char* *operators*)
            (progn
              (if (> (length *current*) 0) (setf *groups* (push *current* *groups*)))
              (setf *groups* (push (string *char*) *groups*))
              (setf *current* (make-adjustable-string ""))
            )
          )
          
          (t (vector-push-extend *char* *current*))
        )
        ;;(vector-push-extend *char* *current*)
        ;;(terpri)
        

    )
    ;; last part without space because
    ;; there is not space character last end of list
    ;;(setf *groups* (push *current* *groups*))

    ;; Delete
    (remove "" *groups* :test #'equal) ;; Equal have to string compare
    (remove " " *groups* :test #'equal) ;; Equal have to string compare

    ;; Reverse
    (reverse *groups*)
  )
)