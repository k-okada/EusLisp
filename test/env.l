;;(defun make-c (a) (let ((x 0)) #'(lambda () (list a x))))
;;(defun make-c () (let ((x 0)) #'(lambda () (list x))))
(defun make-c0 () #'(lambda () (list 0)))

(compile 'make-c0)
(setq f (make-c0))
(format t ";; funcall make-c0 ~A~%" (funcall f))

(defun make-c1 () (let () #'(lambda (x) (list x))))

(compile 'make-c1)
(setq f (make-c1))
(format t ";; funcall make-c1 ~A~%" (funcall f 1))


(defun make-c2 () (let ((x 0)) #'(lambda () (list x))))

(compile 'make-c2)
(setq f (make-c2))
(format t ";; funcall make-c2 ~A~%" (funcall f))

(setq *x* 2) (defun make-c3 () #'(lambda () (list *x*)))

(compile 'make-c3)
(setq f (make-c3))
(format t ";; funcall make-c3 ~A~%" (funcall f))


(defun make-c4 () #'(lambda (x) (list x)))

(compile 'make-c4)
(setq f (make-c4))
(format t ";; funcall make-c4 ~A~%" (funcall f 1))

(print (closure-hoge f))
