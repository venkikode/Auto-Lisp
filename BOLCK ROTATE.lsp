(defun RR1 ()
  (prompt "Select Entities to Rotate, <ENTER> for SSX.")
  (setq ss (ssget))
  (if (not ss) (setq ss (ssx)))
  (setq num (sslength ss))
  (setq x 0)
  (if ss
  	(if (setq ang ang3)
	  	(repeat num
		  	(setq ename (ssname ss x))
		    (setq elist (entget ename))
			(setq pnt (cdr(assoc 10 elist)))
			(command "Rotate" ename "" pnt ang)
 		    (setq x (1+ x))
	    	)
	  	)
    )
  )

  (defun RR2 ()
  (setq k1 (entget (car (entsel "\nselect referace object : "))))
  (setq a1list (assoc 10 k1))
  (setq a2list (assoc 11 k1))
  (setq a1 (cdr a1list))
  (setq a2 (cdr a2list))
  (setq angl (angle a1 a2))
  (setq ang2 (* (/ 180 pi) angl))

  (if (= ang2 0) (setq ang3 ang2))
  (if ( and (> ang2 0)(< ang 90)) (setq ang3 (- ang2 360)))
  (if (> ang2 90) (setq ang3 (- ang2 180)))
    )


  (defun c:RR ()
(RR2)
(RR1)
  )