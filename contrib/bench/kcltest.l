#+eus
(defmethod cons (:test () ))

#+eus
(defun gbc (x) (gc))

#+kcl
(setq sys:*notify-gbc* t)

(defun bench (m n)
   (let (tm1 tm2 overhead1 overhead2 dummy (m1 0) (m2 0) (n1 0) (n2 0))
     (declare (fixnum n1 n2))
     (setq m1 (/ m 1000) m (* 1000 m1))
     (setq n1 (/ n 1000) n (* 1000 n1))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i m1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j)) ))
     (setq tm2 (get-internal-run-time))
     (setq overhead1 (- tm2 tm1))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j)) ))
     (setq tm2 (get-internal-run-time))
     (setq overhead2 (- tm2 tm1))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i m1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
		 (setq dummy (symbolp 'a))))
     (setq tm2 (get-internal-run-time))
     (format t "symbolp ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i m1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
		 (setq dummy (consp 'a))))
     (setq tm2 (get-internal-run-time))
     (format t "consp ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))
#+eus
     (progn
	     (setq tm1 (get-internal-run-time))
	     (dotimes (i m) (derivedp 'a symbol))
	     (setq tm2 (get-internal-run-time))
	     (format t "derivedp ~a~%"  (* 0.0167 (- tm2 tm1 overhead1))))
#+eus
     (progn
	     (setq tm1 (get-internal-run-time))
	     (dotimes (i m) (send '(a) :test))
	     (setq tm2 (get-internal-run-time))
	     (format t "send ~a~%"  (* 0.0167 (- tm2 tm1 overhead1))))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
		 (setq dummy (cons nil nil))))
     (setq tm2 (get-internal-run-time))
     (format t "cons ~a~%"  (* 0.0167 (- tm2 tm1 overhead2)))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
		 (setq dummy (make-string 10))))
     (setq tm2 (get-internal-run-time))
     (format t "make-string ~a~%"  (* 0.0167 (- tm2 tm1 overhead2)))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
		 (setq dummy (vector 1 2 3))))
     (setq tm2 (get-internal-run-time))
     (format t "3dvector ~a~%"  (* 0.0167 (- tm2 tm1 overhead2)))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	    (vector 1 2 3 4 5 6 7 8 9 10)))
     (setq tm2 (get-internal-run-time))
     (format t "10dvector ~a~%"  (* 0.0167 (- tm2 tm1 overhead2)))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
		 (vector 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 
			 21 22 23 24 25 26 27 28 29 30)))
     (setq tm2 (get-internal-run-time))
     (format t "30dvector ~a~%"  (* 0.0167 (- tm2 tm1 overhead2)))))
     
#+kcl
(progn
  (defstruct a)
  (defstruct (b (:include a)))
  (defstruct (c (:include b)))
  (setq a (make-a) b (make-b) c (make-c))

  (defun bench2 (n)
    (declare (integer n))
    (let (tm1 tm2 dummy overhead1 (n1 0))
     (declare (fixnum n1))
     (setq n1 (/ n 1000) n (* 1000 n1))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j)) ))
     (setq tm2 (get-internal-run-time))
     (setq overhead1 (- tm2 tm1))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	   (setq dummy (b-p b))))
     (setq tm2 (get-internal-run-time))
     (format t "b-p b ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	   (setq dummy (a-p b))))
     (setq tm2 (get-internal-run-time))
     (format t "a-p b ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	   (setq dummy (a-p c))))
     (setq tm2 (get-internal-run-time))
     (format t "typep c 'a ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))))

  (defun bench3 (n)
    (declare (integer n))
    (let (tm1 tm2 dummy overhead1 (n1 0))
     (declare (fixnum n1))
     (setq n1 (/ n 1000) n (* 1000 n1))
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j)) ))
     (setq tm2 (get-internal-run-time))
     (setq overhead1 (- tm2 tm1))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	   (setq dummy (a-p c))))
     (setq tm2 (get-internal-run-time))
     (format t "a-p c ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	   (setq dummy (a-p b))))
     (setq tm2 (get-internal-run-time))
     (format t "b-p c ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))
;
     (gbc t)
     (setq tm1 (get-internal-run-time))
     (dotimes (i n1)
	(declare (fixnum i))
	(dotimes (j 1000) (declare (fixnum j))
	   (setq dummy (c-p c))))
     (setq tm2 (get-internal-run-time))
     (format t "c-p c ~a~%"  (* 0.0167 (- tm2 tm1 overhead1)))))
  ) 
 
     

