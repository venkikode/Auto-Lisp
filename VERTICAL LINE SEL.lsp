 (defun c:sv ( / ss1 ss2 ssl minL maxL i ll ename) ;select vertical polylines
 (setq ss1 (ssadd))
 (princ "\nSelect lines to filter: ")
 (setq ss2 (ssget '((0 . "line"))))
 (if ss2 (progn
 (setq i 0  ssl (sslength ss2))
 (repeat ssl
  (setq ename (ssname ss2 i))
  (setq ll1 (car (cdr (assoc 10 (entget ename)))))
  (setq ll2 (car (cdr (assoc 11 (entget ename)))))
  (if (= ll1 ll2 )(ssadd ename ss1))
  (setq i (1+ i))
  )
 (princ (strcat (itoa (sslength ss1)) " line(s) selected."))
 (sssetfirst nil ss1)
 ))
 (princ)
)