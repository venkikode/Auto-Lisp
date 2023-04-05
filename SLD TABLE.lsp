(defun DTR (a)
(* PI (/ a 180.0))
);defun
(defun c:tab()
(setq ip (getpoint "\n pick the point to generate"))

(setq a (ssget))
   (setq n (sslength a))
      (setq ve2 (+ 1 n))
   (setq index 0 )
      (setvar "osmode" 0)
   (setq p1 ip)
      (repeat n
	  (setq ve2 (- ve2 1))
      (setq b1 (entget (ssname a index)))
      (setq index (1+ index))
	  (setq in index)
      (setq bb (assoc 1 b1 ))
	  (setq cc (cdr bb))
	  (setq k1 (cdr (assoc 13 b1)))
	  (setq k2 (cdr (assoc 14 b1)))
	  (setq dis (distance k1 k2))
	  (setq td (/ dis 2))
	  (setq p2 (polar p1 (DTR 180.0) 3800))
	  (setq p3 (polar p1 (DTR 270.0) dis))

	  (setq tp1 (polar p2 (DTR 270.0) td))
	  (setq tp2 (polar tp1 (DTR 0.0) 600))
	  (command "textsize" "300")
	  (command "line" p1 p2 "")
	  (command "TEXT" tp2 "300" "90" ve2 "")
	  (setq p1 p3)
	  	  )
	  (setq p4 (polar p3 (DTR 180.0) 3800))
	  (setq p5 (polar ip (DTR 180.0) 3800))

	  (setq p6 (polar ip (DTR 180.0) 1000))
	  (setq p7 (polar p6 (DTR 180.0) 1000))
	  (setq p8 (polar p7 (DTR 180.0) 1000))

	  (setq p9 (polar p3 (DTR 180.0) 1000))
	  (setq p10 (polar p9 (DTR 180.0) 1000))
	  (setq p11 (polar p10 (DTR 180.0) 1000))
;text box
	  (setq p12 (polar p3 (DTR 270.0) 4700))
	  (setq p13 (polar p4 (DTR 270.0) 4700))

	  (setq p14 (polar p3 (DTR 180.0) 1000))
	  (setq p15 (polar p12 (DTR 180.0) 1000))

	  (setq p16 (polar p3 (DTR 180.0) 2000))
	  (setq p17 (polar p12 (DTR 180.0) 2000))

	  (setq p18 (polar p3 (DTR 180.0) 3000))
	  (setq p19 (polar p12 (DTR 180.0) 3000))
;text box text

	  (setq p20temp (polar p13 (DTR 90.0) 250))

	  (setq p20 (polar p20temp (DTR 0.0) 600))
	  (setq p21 (polar p20 (DTR 0.0) 850))
	  (setq p22 (polar p21 (DTR 0.0) 1100))
	  (setq p23 (polar p22 (DTR 0.0) 1030))

	   (command "line" p3 p4 "")
	   (command "line" ip p3 "")
	   (command "line" p5 p4 "")
	   (command "line" p6 p9 "")
	   (command "line" p7 p10 "")
	   (command "line" p8 p11 "")
	   (command "line" p3 p12 p13 p4 "")
	   (command "line" p14 p15 "" )
	   (command "line" p16 p17 "" )
	   (command "line" p18 p19 "" )

	   (command "TEXT" p20 "300" "90" "PANEL No.S" "")
	   (command "TEXT" p21 "300" "90" "MAIN LEGS SIZES" "")
	   (command "TEXT" p22 "300" "90" "DIAGONALS SIZES" "")
	   (command "TEXT" p23 "300" "90" "HORIZONTALS SIZES" "")
	      (setvar "osmode" 135)

	  )

	  ;===================================;

	  (defun c:bb()
	  (command "_insert" "C:/detail/BLOCKS/ALBABTAIN BLOCKS/15SCALEBLOCKS" "@" "" "" "" "")
	  (command "insert" "c:/detail/blocks/c2" "@" "" "" "" "")
	  )