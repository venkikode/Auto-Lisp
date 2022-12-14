(defun c:chh (/ a ts n index b1 b c d b2)
   (setq a (ssget))
   (setq ts (getreal "Enter new text size: "))
   (setq n (sslength a))
   (setq index 0 )
   (repeat n
      (setq b1 (entget (ssname a index)))
      (setq index (1+ index))
      (setq b (assoc 0 b1 ))
      (if (= "TEXT" (cdr b))
	 (progn
	    (setq c (assoc 40 b1 ))
	    (setq d (cons (car c ) ts ))
	    (setq b2 (subst d c b1))
	    (entmod b2)
	 )
      )
   )
 (princ)
)


(defun c:chw (/ a ts n index b1 b c d b2)
   (setq a (ssget))
   (setq wf (getreal "Enter new width factor: "))
   (setq n (sslength a))
   (setq index 0 )
   (repeat n
      (setq b1 (entget (ssname a index)))
      (setq index (1+ index))
      (setq b (assoc 0 b1 ))
      (if (= "TEXT" (cdr b))
	 (progn
	    (setq c (assoc 41 b1 ))
	    (setq d (cons (car c ) wf ))
	    (setq b2 (subst d c b1))
	    (entmod b2)
	 )
      )
   )
  (princ)
)