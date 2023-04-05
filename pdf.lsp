(defun c:pph()
(defun dtr(x) (* (/ pi 180.0) x))
(if (= printnumber nil) (setq printnumber 0))
(setq printnumber (1+ printnumber))
(setq filepath (getvar "dwgprefix"))
(setq tempfile (strcat "" (getvar "dwgname")))
(setq filename (strcat filepath tempfile "-" (itoa printnumber ) ".pdf"))
(setq printpoint (getpoint "\npick left bottam point"))

;(setq filename (getstring "\nEnter the file name"))
(setq hp1 (polar printpoint (dtr 0.0) 8910))
(setq hp2 (polar hp1 (dtr 90.0) 6300))
(command "_plot" "y" "model" "DWG To PDF.pc5" "ISO A4 (297.00 x 210.00 MM)" "m" "l" "n" "w" printpoint hp2 "fit" "c" "y" "rccdwg.ctb" "n" "a" filename "n" "y")
(princ) )

(defun c:ppv()
 (defun dtr(x) (* (/ pi 180.0) x))
(if (= printnumber "0") (setq printnumber 0))
(setq printpoint (getpoint "\npick left bottam point"))
(setq filepath (getvar "dwgprefix"))
;(setq filename (getstring "\nEnter the file name"))
(setq hp1 (polar printpoint (dtr 0.0) 4455))
(setq hp2 (polar hp1 (dtr 90.0) 6300))
(command "_plot" "y" "model" "DWG To PDF.pc5" "ISO A4 (210.00 x 297.00 MM)" "m" "p" "n" "w" printpoint hp2 "fit" "c" "y" "rccdwg.ctb" "n" "a" filename "n" "y")
(princ) )

(defun c:vv()
(command "_plot"))



























(defun c:pprint()
(initget 1 "H V")
(setq newstud_membertype (getkword "\nEnter the new struct member type <Horizantal/Vertical>::"))

(if (= newstud_membertype "V")
(progn
(setq printpoint1 (getpoint "\npick left bottam point"))
(setq printpoint2 (getpoint "\npick right top point"))
(setq filepath (getvar "dwgprefix"))

(command "_plot" "y" "model" "doPDF v7_VER.pc5" "a4" "m" "p" "n" "w" printpoint1 printpoint2 "fit" "c" "y" "rccdwg.ctb" "n" "a" "n" "n" "y" filepath "y" "y")
(princ) ))

(if (= newstud_membertype "H")
(progn
(setq printpoint1 (getpoint "\npick left bottam point"))
(setq printpoint2 (getpoint "\npick right top point"))
(setq filepath (getvar "dwgprefix"))
(command "_plot" "y" "model" "doPDF v7_HOR.pc5" "a4" "m" "l" "n" "w" printpoint1 printpoint2 "fit" "c" "y" "rccdwg.ctb" "n" "a" "n" "n" "y" filepath "y" "y")
(princ) ))
)