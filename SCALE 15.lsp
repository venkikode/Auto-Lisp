(defun c:scc()
(setq aa (ssget))
(setq p1 (getpoint "pickup first point"))
(setq a (ssget))
   (setq index 0 )
      (setq b (entget (ssname a index)))
				(setq c (assoc 40 b))
				(setq d (cdr c))
(command "_scale" aa pause p1 "r" d "30" "" )

)