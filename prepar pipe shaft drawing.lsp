
(setq plotsty "rccdwg.ctb")
(defun dtr(x) (* (/ pi 180.0) x))
(defun rtd(x) (* (/ 180 pi) x))


(defun c:pipemember()
(setq a (ssget))
   (setq n (sslength a))
   (setq index 0 )
   (repeat n
      (setq b1 (entget (ssname a index)))
      (setq index (1+ index))
      (setq b (assoc 0 b1 ))
      (if (= "LINE" (cdr b))
	 (progn
	    (setq c (assoc 10 b1 ))
		(setq cc (assoc 11 b1 ))
		(setq pp1 (cdr c))
        (setq pp2 (cdr cc))
;(setq pp1 (getpoint "\npick the first piont"))
;(setq pp2 (getpoint "\npick the secound point"))
(setq memshoft (getstring "\nEnter the member size"))

(setq ang (angle pp1 pp2)) ;for 0
(setq shearedge 25)
(setq ang1 (+ ang (dtr 90)))   ; for 90
(setq ang2 (angle pp2 pp1))    ; for 0 to 180
(setq ang3 (+ ang1 (dtr 180))) ;for 270
	
(if (= memshoft "48.3x2.9") (progn (setq DD1 48.3) (setq DD2 68.4) (setq bm 34.2) (setq DD3 (strcat "48.3" "%%c")) (setq L1 60) (setq L2 72) (setq TT1 22) (setq DDTICK 2.9) (setq memname "PIPE48.3x2.9Thk") (setq blockwt 3.23)))
(if (= memshoft "48.3x3.2") (progn (setq DD1 48.3) (setq DD2 68.4) (setq bm 34.2) (setq DD3 (strcat "48.3" "%%c")) (setq L1 60) (setq L2 72) (setq TT1 22) (setq DDTICK 3.2) (setq memname "PIPE48.3x3.2Thk") (setq blockwt 3.56)))
(if (= memshoft "48.3x4.0") (progn (setq DD1 48.3) (setq DD2 68.4) (setq bm 34.2) (setq DD3 (strcat "48.3" "%%c")) (setq L1 60) (setq L2 72) (setq TT1 22) (setq DDTICK 4.0) (setq memname "PIPE48.3x4.0Thk") (setq blockwt 4.37)))
(if (= memshoft "60.3x2.9") (progn (setq DD1 60.3) (setq DD2 80) (setq bm 40) (setq DD3 (strcat "60.3" "%%c")) (setq L1 60) (setq L2 90) (setq TT1 15) (setq DDTICK 2.9) (setq memname "PIPE60.3x2.9Thk") (setq blockwt 4.08)))
(if (= memshoft "60.3x3.6") (progn (setq DD1 60.3) (setq DD2 80) (setq bm 40) (setq DD3 (strcat "60.3" "%%c")) (setq L1 60) (setq L2 90) (setq TT1 15) (setq DDTICK 3.6) (setq memname "PIPE60.3x3.6Thk") (setq blockwt 5.03)))
(if (= memshoft "60.3x4.5") (progn (setq DD1 60.3) (setq DD2 80) (setq bm 40) (setq DD3 (strcat "60.3" "%%c")) (setq L1 60) (setq L2 90) (setq TT1 15) (setq DDTICK 4.5) (setq memname "PIPE60.3x4.5Thk") (setq blockwt 6.19)))
(if (= memshoft "76.1x3.2") (progn (setq DD1 76.1) (setq DD2 107) (setq bm 53.5) (setq DD3 (strcat "76.1" "%%c")) (setq L1 60) (setq L2 114) (setq TT1 20) (setq DDTICK 3.2) (setq memname "PIPE76.1x3.2Thk")(setq blockwt 5.71)))
(if (= memshoft "76.1x3.6") (progn (setq DD1 76.1) (setq DD2 107) (setq bm 53.5) (setq DD3 (strcat "76.1" "%%c")) (setq L1 60) (setq L2 114) (setq TT1 20) (setq DDTICK 3.6) (setq memname "PIPE76.1x3.6Thk")(setq blockwt 6.42)))
(if (= memshoft "76.1x4.5") (progn (setq DD1 76.1) (setq DD2 107) (setq bm 53.5) (setq DD3 (strcat "76.1" "%%c")) (setq L1 60) (setq L2 114) (setq TT1 20) (setq DDTICK 4.5) (setq memname "PIPE76.1x4.5Thk")(setq blockwt 7.93)))
(if (= memshoft "88.9x3.2") (progn (setq DD1 88.9) (setq DD2 127) (setq bm 63.5) (setq DD3 (strcat "88.9" "%%c")) (setq L1 60) (setq L2 133) (setq TT1 39) (setq DDTICK 3.2) (setq memname "PIPE88.9x3.2Thk") (setq blockwt 6.72)))
(if (= memshoft "88.9x4.0") (progn (setq DD1 88.9) (setq DD2 127) (setq bm 63.5) (setq DD3 (strcat "88.9" "%%c")) (setq L1 60) (setq L2 133) (setq TT1 39) (setq DDTICK 4.0) (setq memname "PIPE88.9x4.0Thk") (setq blockwt 8.36)))
(if (= memshoft "88.9x4.8") (progn (setq DD1 88.9) (setq DD2 127) (setq bm 63.5) (setq DD3 (strcat "88.9" "%%c")) (setq L1 60) (setq L2 133) (setq TT1 39) (setq DDTICK 4.8) (setq memname "PIPE88.9x4.8Thk") (setq blockwt 9.90)))
(if (= memshoft "101.6x3.6") (progn (setq DD1 101.6) (setq DD2 147) (setq bm 73.5) (setq DD3 (strcat "101.6" "%%c")) (setq L1 60) (setq L2 152) (setq TT1 45) (setq DDTICK 3.6) (setq memname "PIPE101.6x3.6Thk") (setq blockwt 8.70)))
(if (= memshoft "101.6x4.0") (progn (setq DD1 101.6) (setq DD2 147) (setq bm 73.5) (setq DD3 (strcat "101.6" "%%c")) (setq L1 60) (setq L2 152) (setq TT1 45) (setq DDTICK 4.0) (setq memname "PIPE101.6x4.0Thk") (setq blockwt 9.63)))
(if (= memshoft "101.6x4.8") (progn (setq DD1 101.6) (setq DD2 147) (setq bm 73.5) (setq DD3 (strcat "101.6" "%%c")) (setq L1 60) (setq L2 152) (setq TT1 45) (setq DDTICK 4.8) (setq memname "PIPE101.6x4.8Thk") (setq blockwt 11.5)))
(if (= memshoft "114.3x3.6") (progn (setq DD1 114.3) (setq DD2 167) (setq bm 83.5) (setq DD3 (strcat "114.3" "%%c")) (setq L1 60) (setq L2 172) (setq TT1 50) (setq DDTICK 3.6) (setq memname "PIPE114.3x3.6Thk") (setq blockwt 9.75)))
(if (= memshoft "114.3x4.5") (progn (setq DD1 114.3) (setq DD2 167) (setq bm 83.5) (setq DD3 (strcat "114.3" "%%c")) (setq L1 60) (setq L2 172) (setq TT1 50) (setq DDTICK 4.5) (setq memname "PIPE114.3x4.5Thk") (setq blockwt 12.2)))
(if (= memshoft "114.3x5.4") (progn (setq DD1 114.3) (setq DD2 167) (setq bm 83.5) (setq DD3 (strcat "114.3" "%%c")) (setq L1 60) (setq L2 172) (setq TT1 50) (setq DDTICK 5.4) (setq memname "PIPE114.3x5.4Thk") (setq blockwt 14.5)))
(if (= memshoft "139.7x4.5") (progn (setq DD1 139.7) (setq DD2 207) (setq bm 103.5) (setq DD3 (strcat "139.7" "%%c")) (setq L1 60) (setq L2 210) (setq TT1 60) (setq DDTICK 4.5) (setq memname "PIPE139.7x4.5Thk") (setq blockwt 15.0)))
(if (= memshoft "139.7x4.8") (progn (setq DD1 139.7) (setq DD2 207) (setq bm 103.5) (setq DD3 (strcat "139.7" "%%c")) (setq L1 60) (setq L2 210) (setq TT1 60) (setq DDTICK 4.8) (setq memname "PIPE139.7x4.8Thk") (setq blockwt 15.9)))
(if (= memshoft "139.7x5.4") (progn (setq DD1 139.7) (setq DD2 207) (setq bm 103.5) (setq DD3 (strcat "139.7" "%%c")) (setq L1 60) (setq L2 210) (setq TT1 60) (setq DDTICK 5.4) (setq memname "PIPE139.7x5.4Thk") (setq blockwt 17.9)))
	
    (setq pp3 (polar pp1 ang2 shearedge))
	(setq pp4 (polar pp3 ang1 TT1))
	(setq pp5 (polar pp3 ang1 (/ DD2 2)))
	(setq pp6 (polar pp3 ang3 TT1))
	(setq pp7 (polar pp3 ang3 (/ DD2 2)))
	(setq pp8 (polar pp7 ang L1))
	(setq pp9 (polar pp5 ang L1))
	(setq pp10 (polar pp3 ang (+ L1 L2)))
	(setq pp11 (polar pp10 ang1 (/ DD1 2)))
	(setq pp12 (polar pp10 ang3 (/ DD1 2)))
	(setq pp13 (polar pp2 ang shearedge))
	(setq pp14 (polar pp13 ang1 TT1))
	(setq pp15 (polar pp13 ang1 (/ DD2 2)))
	(setq pp16 (polar pp13 ang3 TT1))
	(setq pp17 (polar pp13 ang3 (/ DD2 2)))
	(setq pp18 (polar pp17 ang2 L1))
	(setq pp19 (polar pp15 ang2 L1))
	(setq pp20 (polar pp13 ang2 (+ L1 L2)))
	(setq pp21 (polar pp20 ang1 (/ DD1 2)))
	(setq pp22 (polar pp20 ang3 (/ DD1 2)))
    (setq pp23 (polar pp1 ang1 TT1))	
    (setq pp24 (polar pp1 ang3 TT1))	
    (setq pp25 (polar pp1 ang TT1))
    (setq pp26 (polar pp2 ang1 TT1))	
    (setq pp27 (polar pp2 ang2 TT1))	
    (setq pp28 (polar pp2 ang3 TT1))
	
    (setq pp29 (polar pp5 ang3 DDTICK))	;for outer line offset
    (setq pp30 (polar pp9 ang3 DDTICK))	 ;for outer line offset
    (setq pp31 (polar pp11 ang3 DDTICK)) ;for outer line offset	
    (setq pp32 (polar pp21 ang3 DDTICK)) ;for outer line offset	
    (setq pp33 (polar pp19 ang3 DDTICK)) ;for outer line offset	
    (setq pp34 (polar pp15 ang3 DDTICK)) ;for outer line offset	
	
    (setq pp35 (polar pp7 ang1 DDTICK))	;for outer line offset
    (setq pp36 (polar pp8 ang1 DDTICK))	;for outer line offset
    (setq pp37 (polar pp12 ang1 DDTICK)) ;for outer line offset	
    (setq pp38 (polar pp22 ang1 DDTICK)) ;for outer line offset
    (setq pp39 (polar pp18 ang1 DDTICK)) ;for outer line offset
    (setq pp40 (polar pp17 ang1 DDTICK)) ;for outer line offset

    (command "layer" "s" "mem" "")
	(command "line" pp7 pp5 pp9 pp11 pp21 pp19 pp15 pp17 pp18 pp22 pp12 pp8 pp7 "")
    (command "layer" "s" "das" "")
	(command "line" pp29 pp30 pp31 pp32 pp33 pp34 "")
	(command "line" pp35 pp36 pp37 pp38 pp39 pp40 "")
    (command "layer" "s" "gus" "")
	(command "line" pp4 pp23 "")
	(command "line" pp6 pp24 "")
	(command "line" pp14 pp26 "")
	(command "line" pp16 pp28 "")
	(command "arc" pp23 pp25 pp24 "")
	(command "arc" pp26 pp27 pp28 "")
	(command "layer" "s" "mem" "")
	
	))))