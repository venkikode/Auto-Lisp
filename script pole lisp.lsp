(defun c:spole()
(defun DTR(x) (* (/ pi 180.0) x)) 
(defun rtd(x) (* (/ 180 pi) x))	
(initget 1 "SPD UKPD")
(setq designtype (getstring "\nEnter the Type of design:<SPD/UKPD>"))
(if (= designtype "SPD") (setq design_name (getstring "\nEnter the Design Name::")))
(if (= designtype "spd") (setq design_name (getstring "\nEnter the Design Name::")))
(setq polejoints (getint "\nEnter number of flange joints in a pole <0/1/2>:- "))
(setq typeofbolts (getstring "\nEnter the bolts types<M12/M16>::"))
(setq clampstk (getreal "\nEnter the tickness for the clamps::"))
(setq flangjointtk (getreal "\nEnter the new flange joint Tickness::"))
(setvar "cmdecho" 1)
(command "insunits" "0")
(if (= polejoints 0)
(progn
(if (= IP nil) (setq IP '(0.0 0.0 0.0)))
	(setq pedestal_width (getreal "\nEnter Pedestal Width: "))
    (setq pedestal_hight (getreal "\nEnter pedestal Hight: "))
    (setvar "osmode" 0) 
(setq pd1 (polar IP (DTR 0.0) pedestal_width)
      pd2 (polar pd1 (DTR 90.0) pedestal_hight)
	  pd3 (polar pd2 (DTR 180.0) pedestal_width)
	  pd4 (polar pd3 (DTR 270.0) pedestal_hight)
 );setq 
(setq joint_0 (getreal "\nEnter pole hight: "))
(setq diameter_1 (getreal "\nEnter first Pole diameter: "))
(setq diameter_1tick (getreal "\nEnter first Pole tickness: "))
(setq totalhight (+ joint_0 0 ))
		(setq p1 (polar pd4 (DTR 0.0) (/ pedestal_width 2))
			  p2 (polar p1 (DTR 90.0) joint_0)                       ;center line
			  p3 (polar p1 (DTR 90.0) pedestal_hight)
			  p4 (polar p3 (DTR 0.0) (/ diameter_1 2))
			  p5 (polar p4 (DTR 90.0) (- joint_0 pedestal_hight))
			  p6 (polar p5 (DTR 180.0) diameter_1)
			  p7 (polar p6 (DTR 270.0) (- joint_0 pedestal_hight))	  
        );setq
        (setq p8 (polar p2 (DTR 0.0) (/ (* diameter_1 2) 2))
			  p9 (polar p8 (DTR 270.0) 10)
			  p10 (polar p9 (DTR 180.0) (* diameter_1 2))
			  p11 (polar p10 (DTR 90.0) 10)	  
        );setq
;==================================================================================================== 
;+++++++++++++++++++++++++++++++++++++++++++++
(setq expole_pedestalhight pedestal_hight)
(setq expole_pedestalwidth pedestal_width)
(setq expolejoint1 joint_0) 
;+++++++++++++++++++++++++++++++++++++++++++++
(setq existingstud (getint "\n Enter the number of existing studs in face one<0/1/2>:"))
(setq index 0 )
(if ( and (> existingstud 0)(< existingstud 3)) 
(progn
(repeat existingstud
(setq existingstud_x (getreal "\nEnter pole center to existing struct pedestal center distance \"x\"::"))
(setq existingstud_y (getreal "\nEnter slab level to struct connected to pole distance \"y\"::"))
(setq existingstud_pedestalwidth (getreal "\nEnter the Existing struct pedestal width::"))
(setq existingstud_pedestalhight (getreal "\nEnter the Existing strcat pedestal hight::"))
(setq twost_ang (getreal "\nEnter the angle between the two existing structs in two faces in plan::")) ;for plan and hip

(setq p12 (polar p1 (DTR 0.0) existingstud_x)) ; pedestal center point
(setq p13 (polar p12 (DTR 90.0) 75)) ;member hole center point
(setq p14 (polar p1 (DTR 90.0) existingstud_y)) ;member clamped location on pole center
(setq p15 (polar p14 (DTR 0.0) (/ diameter_1 2)))
(setq p16 (polar p15 (DTR 90.0) 50))
(setq p17 (polar p16 (DTR 0.0) 100))
(setq p18 (polar p17 (DTR 270.0) 100))
(setq p19 (polar p18 (DTR 180.0) 100))
(setq p20 (polar p15 (DTR 0.0) 75))   ;hole location

(setq p21 (polar p12 (DTR 0.0) (/ existingstud_pedestalwidth 2)))
(setq p22 (polar p21 (DTR 90.0) existingstud_pedestalhight ))
(setq p23 (polar p22 (DTR 180.0) existingstud_pedestalwidth ))
(setq p24 (polar p23 (DTR 270.0) existingstud_pedestalhight ))

(setq pp1 p20)
(setq pp2 p13)
 
(initget 1 "A P")
(setq existingstud_membertype (getkword "\nEnter the extsting struct member type <Angle/Pipe>::"))
(setq existingstud_membersize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft existingstud_membersize)
(if (= existingstud_membertype "A") (angmember))
(if (= existingstud_membertype "P") (pipemember))
;(command "line" p16 p17 p18 p19 "")
;(command "_insert" "16c" p20 "" "" "")
;(command "line" p20 p13 "")
;(command "line" p21 p22 p23 p24 p21 "") 
(setq index (1+ index))
;+++++++++++++++++++++++++++++++++++++
(if (= index 1) (progn (setq exst1_x existingstud_x) (setq exst1_y existingstud_y) (setq exst1_pw existingstud_pedestalwidth) (setq exst1_ph existingstud_pedestalhight) (setq exst1_ty existingstud_membertype) (setq exst1_name memname)))
(if (= index 2) (progn (setq exst2_x existingstud_x) (setq exst2_y existingstud_y) (setq exst2_pw existingstud_pedestalwidth) (setq exst2_ph existingstud_pedestalhight) (setq exst2_ty existingstud_membertype) (setq exst2_name memname)))
;+++++++++++++++++++++++++++++++++++++
;;;existing members on existing struct 
(setq polestarting p1)
(setq poleending p2)
(setq structstarting p20)
(setq structending p13)
(setq structsize existingstud_membersize)

(existing_newm)
(hip_eqfaces)
)));existing member end
(setq polestarting p1)
(setq poleending p2)
(newstud)
(spd_drawings)
)) ;joint_0 end
(if (= polejoints 1)
(progn
(if (= IP nil) (setq IP '(0.0 0.0 0.0)))
	(setq pedestal_width (getreal "\nEnter Pedestal Width: "))
    (setq pedestal_hight (getreal "\nEnter pedestal Hight: "))
    (setvar "osmode" 0) 
(setq pd1 (polar IP (DTR 0.0) pedestal_width)
      pd2 (polar pd1 (DTR 90.0) pedestal_hight)
	  pd3 (polar pd2 (DTR 180.0) pedestal_width)
	  pd4 (polar pd3 (DTR 270.0) pedestal_hight)
	  
 );setq
 ;(command "LINE" IP pd1 pd2 pd3 pd4 "" )
 (setq joint_0 (getreal "\nEnter pole hight: "))
 (setq joint_1 (getreal "\nEnter joint_1 hight from slab level: "))
 (setq diameter_1 (getreal "\nEnter first Pole diameter: "))
(setq diameter_1tick (getreal "\nEnter first Pole tickness: "))
 (setq diameter_2 (getreal "\nEnter second Pole diameter: "))
(setq diameter_2tick (getreal "\nEnter Secound Pole tickness: "))
 (setq totalhight (+ joint_0 0 ))
 
		(setq p1 (polar pd4 (DTR 0.0) (/ pedestal_width 2))
			  p2 (polar p1 (DTR 90.0) totalhight)                       ;center line
			  p3 (polar p1 (DTR 90.0) pedestal_hight)
			  p4 (polar p3 (DTR 0.0) (/ diameter_1 2))
			  p5 (polar p4 (DTR 90.0) (- joint_1 pedestal_hight))
			  p6 (polar p5 (DTR 180.0) diameter_1)
			  p7 (polar p6 (DTR 270.0) (- joint_1 pedestal_hight))
			  
			  p8 (polar p1 (DTR 90.0) joint_1)  ;joint_1 hight point on pole center line.
			  p9 (polar p8 (DTR 0.0) (/ diameter_2 2))
			  p10 (polar p9 (DTR 90.0) (- totalhight joint_1))
			  p11 (polar p10 (DTR 180.0) diameter_2)
			  p12 (polar p11 (DTR 270.0) (- totalhight joint_1))				
        );setq
        (setq p13 (polar p8 (DTR 0.0) (/ (* diameter_1 2) 2))
			  p14 (polar p13 (DTR 270.0) 10)
			  p15 (polar p14 (DTR 180.0) (* diameter_1 2))
			  p16 (polar p15 (DTR 90.0) 20)	  
			  p17 (polar p16 (DTR 0.0) (* diameter_1 2))
			  p18 (polar p16 (DTR 270.0) 10)     ;for flang center line
				) ;setq 
        (setq p20 (polar p2 (DTR 0.0) (/ (* diameter_1 2) 2))
			  p21 (polar p20 (DTR 270.0) 10)
			  p22 (polar p21 (DTR 180.0) (* diameter_1 2))
			  p23 (polar p22 (DTR 90.0) 10)	  
        );setq
 ;(command "LINE" p2 p3 "" ) ;center line
 ;(command "LINE" p4 p5 p6 p7 "" "line" p9 p10 p11 p12 "" )
 ;(command "LINE" p14 p15 p16 p17 p14 "" "line" p13 p18 "" )
 ;(command "line" p20 p21 p22 p23 p20 "")
 ;(command "_zoom" IP p2)
  ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++
(setq expole_pedestalhight pedestal_hight)
(setq expole_pedestalwidth pedestal_width)
(setq expolejoint1 joint_1) 
(setq expolejoint_end (- totalhight joint_1))
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++
(setq existingstud (getint "\n Enter the number of existing studs in face one<0/1/2>:"))
(setq index 0)
(if ( and (> existingstud 0)(< existingstud 3)) 
(progn
(repeat existingstud
(setq existingstud_x (getreal "\nEnter pole center to existing pedestal center distance \"x\"::"))
(setq existingstud_y (getreal "\nEnter slab level to struct connected to pole distance \"y\"::"))
(setq existingstud_pedestalwidth (getreal "\nEnter the Existing struct pedestal width::"))
(setq existingstud_pedestalhight (getreal "\nEnter the Existing strcat pedestal hight::"))
(setq twost_ang (getreal "\nEnter the angle between the two existing structs in two faces in plan::")) ;for plan and hip

(setq p24 (polar p1 (DTR 0.0) existingstud_x)) ; pedestal center point
(setq p25 (polar p24 (DTR 90.0) 75)) ;member hole center point at pedestal

(if (< existingstud_y joint_1) (setq diameter diameter_1) )
(if (> existingstud_y joint_1) (setq diameter diameter_2) )

(setq p26 (polar p1 (DTR 90.0) existingstud_y)) ;member clamped location on pole center
(setq p27 (polar p26 (DTR 0.0) (/ diameter 2)))
(setq p28 (polar p27 (DTR 90.0) 50))
(setq p29 (polar p28 (DTR 0.0) 100))
(setq p30 (polar p29 (DTR 270.0) 100))
(setq p31 (polar p30 (DTR 180.0) 100))
(setq p32 (polar p27 (DTR 0.0) 75))   ;hole location

(setq p33 (polar p24 (DTR 0.0) (/ existingstud_pedestalwidth 2)))
(setq p34 (polar p33 (DTR 90.0) existingstud_pedestalhight ))
(setq p35 (polar p34 (DTR 180.0) existingstud_pedestalwidth ))
(setq p36 (polar p35 (DTR 270.0) existingstud_pedestalhight ))

;(command "line" p28 p29 p30 p31 p28 "")
;(command "_insert" "16c" p32 "" "" "")
;(command "line" p32 p25 "")

(setq pp1 p32)
(setq pp2 p25)
 
(initget 1 "A P")
(setq existingstud_membertype (getkword "\nEnter the extsting struct member type <Angle/Pipe>::"))
(setq existingstud_membersize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft existingstud_membersize)
(if (= existingstud_membertype "A") (angmember))
(if (= existingstud_membertype "P") (pipemember))
;(command "LINE" p33 p34 p35 p36 p33 "" )
(setq index (1+ index))
;+++++++++++++++++++++++++++++++++++++
(if (= index 1) (progn (setq exst1_x existingstud_x) (setq exst1_y existingstud_y) (setq exst1_pw existingstud_pedestalwidth) (setq exst1_ph existingstud_pedestalhight) (setq exst1_name memname)))
(if (= index 2) (progn (setq exst2_x existingstud_x) (setq exst2_y existingstud_y) (setq exst2_pw existingstud_pedestalwidth) (setq exst2_ph existingstud_pedestalhight) (setq exst2_name memname)))
;+++++++++++++++++++++++++++++++++++++ 
;existing member
(setq polestarting p1)
(setq poleending p2)
(setq structstarting p32)
(setq structending p25)
(setq structsize existingstud_membersize)
(existing_newm)
(hip_eqfaces)
)
));existing member end
(setq polestarting p1)
(setq poleending p2)
(newstud)
(spd_drawings)
)) ;joint_1 end
(if (= polejoints 2)
(progn
(if (= IP nil) (setq IP '(0.0 0.0 0.0)))
	(setq pedestal_width (getreal "\nEnter Pedestal Width: "))
    (setq pedestal_hight (getreal "\nEnter pedestal Hight: "))
    (setvar "osmode" 0) 
(setq pd1 (polar IP (DTR 0.0) pedestal_width)
      pd2 (polar pd1 (DTR 90.0) pedestal_hight)
	  pd3 (polar pd2 (DTR 180.0) pedestal_width)
	  pd4 (polar pd3 (DTR 270.0) pedestal_hight)
 );setq
 ;(command "LINE" IP pd1 pd2 pd3 pd4 "" )
 
 (setq joint_0 (getreal "\nEnter pole hight: "))
 (setq joint_1 (getreal "\nEnter joint_1 hight from slab level: "))
 (setq joint_2 (getreal "\nEnter joint_2 hight from slab level: "))
 
 (setq diameter_1 (getreal "\nEnter first Pole diameter: "))
 (setq diameter_1tick (getreal "\nEnter first Pole tickness: "))
 (setq diameter_2 (getreal "\nEnter second Pole diameter: "))
 (setq diameter_2tick (getreal "\nEnter second Pole tickness: "))
 (setq diameter_3 (getreal "\nEnter thired Pole diameter: "))
 (setq diameter_3tick (getreal "\nEnter thired Pole tickness: "))
 (setq totalhight (+ joint_0 0 ))
 
		(setq p1 (polar pd4 (DTR 0.0) (/ pedestal_width 2))
			  p2 (polar p1 (DTR 90.0) totalhight)                       ;center line
			  p3 (polar p1 (DTR 90.0) pedestal_hight) 
			  p4 (polar p3 (DTR 0.0) (/ diameter_1 2))
			  p5 (polar p4 (DTR 90.0) (- joint_1 pedestal_hight))
			  p6 (polar p5 (DTR 180.0) diameter_1)
			  p7 (polar p6 (DTR 270.0) (- joint_1 pedestal_hight))
			  p8 (polar p1 (DTR 90.0) joint_1)  ;joint_1 hight point on pole center line.
			  p9 (polar p8 (DTR 0.0) (/ diameter_2 2))
			  p10 (polar p9 (DTR 90.0) (- joint_2 joint_1))
			  p11 (polar p10 (DTR 180.0) diameter_2)
			  p12 (polar p11 (DTR 270.0) (- joint_2 joint_1))
			  p13 (polar p1 (DTR 90.0) joint_2)  ;joint_2 hight point on pole center line.
			  p14 (polar p13 (DTR 0.0) (/ diameter_3 2))
			  p15 (polar p14 (DTR 90.0) (- totalhight joint_2))
			  p16 (polar p15 (DTR 180.0) diameter_3)
			  p17 (polar p16 (DTR 270.0) (- totalhight joint_2))			  
        );setq
 ;===joint_1 flang's====;
        (setq p18 (polar p8 (DTR 0.0) (/ (* diameter_1 2) 2))
			  p19 (polar p18 (DTR 270.0) 10)
			  p20 (polar p19 (DTR 180.0) (* diameter_1 2))
			  p21 (polar p20 (DTR 90.0) 20)	  
			  p22 (polar p21 (DTR 0.0) (* diameter_1 2))
			  p23 (polar p21 (DTR 270.0) 10)     ;for flang center line
				) ;setq 
 ;===joint_2 flang's====;
        (setq p24 (polar p13 (DTR 0.0) (/ (* diameter_1 2) 2))
			  p25 (polar p24 (DTR 270.0) 10)
			  p26 (polar p25 (DTR 180.0) (* diameter_1 2))
			  p27 (polar p26 (DTR 90.0) 20)	  
			  p28 (polar p27 (DTR 0.0) (* diameter_1 2))
			  p29 (polar p27 (DTR 270.0) 10)     ;for flang center line
				) ;setq 
 ;===end flang's====;
        (setq p30 (polar p2 (DTR 0.0) (/ (* diameter_1 2) 2))
			  p31 (polar p30 (DTR 270.0) 10)
			  p32 (polar p31 (DTR 180.0) (* diameter_1 2))
			  p33 (polar p32 (DTR 90.0) 10)	  
        );setq
 
 ;(command "LINE" p2 p3 "" ) ;center line
 ;(command "LINE" p4 p5 p6 p7 "" "line" p9 p10 p11 p12 "" "line" p14 p15 p16 p17 "" "LINE" p19 p20 p21 p22 p19 "" "line" p18 p23 "" "LINE" p25 p26 p27 p28 p25 "" "line" p24 p29 "")
 ;(command "line" p30 p31 p32 p33 p30 "" "_zoom" IP p2)
  
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++
(setq expole_pedestalhight pedestal_hight)
(setq expole_pedestalwidth pedestal_width)
(setq expolejoint1 joint_1) 
(setq expolejoint2 (- joint_2 joint_1)) 
(setq expolejoint_end (- totalhight joint_2))
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

(setq existingstud (getint "\n Enter the number of existing studs in face one<0/1/2>:"))
(setq index 0)
(if ( and (> existingstud 0)(< existingstud 3)) 
(progn
(repeat existingstud
(setq existingstud_x (getreal "\nEnter pole center to existing pedestal center distance \"x\"::"))
(setq existingstud_y (getreal "\nEnter slab level to struct connected to pole distance \"y\"::"))
(setq existingstud_pedestalwidth (getreal "\nEnter the Existing struct pedestal width::"))
(setq existingstud_pedestalhight (getreal "\nEnter the Existing strcat pedestal hight::"))
(setq twost_ang (getreal "\nEnter the angle between the two existing structs in two faces in plan::")) ;for plan and hip

(setq p34 (polar p1 (DTR 0.0) existingstud_x)) ; pedestal center point
(setq p35 (polar p34 (DTR 90.0) 75)) ;member hole center point at pedestal

(if (< existingstud_y joint_1) (setq diameter diameter_1) )
(if ( and (> existingstud_y joint_1) (< existingstud_y joint_2)) (setq diameter diameter_2) )
(if (> existingstud_y joint_2) (setq diameter diameter_3) )

(setq p36 (polar p1 (DTR 90.0) existingstud_y)) ;member clamped location on pole center
(setq p37 (polar p36 (DTR 0.0) (/ diameter 2)))
(setq p38 (polar p37 (DTR 90.0) 50))
(setq p39 (polar p38 (DTR 0.0) 100))
(setq p40 (polar p39 (DTR 270.0) 100))
(setq p41 (polar p40 (DTR 180.0) 100))
(setq p42 (polar p37 (DTR 0.0) 75))   ;hole location
(setq p43 (polar p34 (DTR 0.0) (/ existingstud_pedestalwidth 2)))
(setq p44 (polar p43 (DTR 90.0) existingstud_pedestalhight ))
(setq p45 (polar p44 (DTR 180.0) existingstud_pedestalwidth ))
(setq p46 (polar p45 (DTR 270.0) existingstud_pedestalhight ))

(setq pp1 p42)
(setq pp2 p35)
 
(initget 1 "A P")
(setq existingstud_membertype (getkword "\nEnter the extsting struct member type <Angle/Pipe>::"))
(setq existingstud_membersize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft existingstud_membersize)
(if (= existingstud_membertype "A") (angmember))
(if (= existingstud_membertype "P") (pipemember))
;(command "line" p38 p39 p40 p41 p38 "")
;(command "_insert" "16c" p42 "" "" "")
;(command "line" p42 p35 "")
;(command "LTSCALE" 1)
;(command "LINE" p43 p44 p45 p46 p43 "" )
(setq index (1+ index)) 
;+++++++++++++++++++++++++++++++++++++
(if (= index 1) (progn (setq exst1_x existingstud_x) (setq exst1_y existingstud_y) (setq exst1_pw existingstud_pedestalwidth) (setq exst1_ph existingstud_pedestalhight) (setq exst1_name memname)))
(if (= index 2) (progn (setq exst2_x existingstud_x) (setq exst2_y existingstud_y) (setq exst2_pw existingstud_pedestalwidth) (setq exst2_ph existingstud_pedestalhight) (setq exst2_name memname)))
;+++++++++++++++++++++++++++++++++++++
(setq polestarting p1)
(setq poleending p2)
(setq structstarting p42)
(setq structending p35)
(setq structsize existingstud_membersize)
(existing_newm)
(hip_eqfaces)

)));existing member end
(setq polestarting p1)
(setq poleending p2)
(newstud)
(spd_drawings)
;(command "layer" "s" "mem" "")
)) ;joint_2 end 
)   ;main program end
(defun newstud()
(setq newstudnum (getint "\n Enter the number of new struct in face one<0/1/2>:"))
(setq index 0)
(if ( and (> newstudnum 0)(< newstudnum 3)) 
(progn
(repeat newstudnum
(setq newstud_x (getreal "\nEnter pole center to new pedestal center distance \"x\"::"))
(setq newstud_y (getreal "\nEnter slab level to struct connected to pole distance \"y\"::"))
(setq newstud_pedestalwidth (getreal "\nEnter the new struct pedestal width::"))
(setq newstud_pedestalhight (getreal "\nEnter the new strcat pedestal hight::"))
(setq newtwost_ang (getreal "\nEnter the angle between the two existing structs in two faces in plan::")) ;for plan and hip
(setq bptk (getreal "\nEnter the tickness for the baseplate")) ;baseplate tickness

(setq ns1 (polar p1 (DTR 0.0) newstud_x)) ; pedestal center point
(setq ns2 (polar p1 (DTR 90.0) newstud_y)) ;member clamped location on pole center
(setq nsp1 (polar ns1 (DTR 0.0) (/ newstud_pedestalwidth 2)))
(setq nsp2 (polar nsp1 (DTR 90.0) newstud_pedestalhight ))
(setq nsp3 (polar nsp2 (DTR 180.0) newstud_pedestalwidth ))
(setq nsp4 (polar nsp3 (DTR 270.0) newstud_pedestalhight ))
;(command "line" nsp1 nsp2 nsp3 nsp4 nsp1 "")
(if (= polejoints 0)(setq diameter diameter_1))
(if (= polejoints 1)(progn (if (< newstud_y joint_1) (setq diameter diameter_1)) (if (> newstud_y joint_1) (setq diameter diameter_2))))
(if (= polejoints 2)(progn (if (< newstud_y joint_1) (setq diameter diameter_1)) (if ( and (> newstud_y joint_1) (< newstud_y joint_2)) (setq diameter diameter_2)) (if (> newstud_y joint_2) (setq diameter diameter_3))))

(initget 1 "A P")
(setq newstud_membertype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newstud_membersize (getstring "\nEnter the new struct member size::"))
(setq memshoft newstud_membersize)

(if (= newstud_membertype "A")
(progn 
(setq ccin ns2) (setq pipedia diameter) 
(C-Clamp2)
(setq acin ns1)
(GA-01_twobolts)
(setq n_ang1 (angle c11 ac11))
(setq n_ang2 (angle ac11 c11))
(setq c12 (polar c11 n_ang2 40))
;(command "_insert" "16c" c12 "" "" "")
(setq ac12 (polar ac11 n_ang1 40))
;(command "_insert" "16c" ac12 "" "" "")
(setq structending ac12)
(setq structstarting c12)
(setq pp1 c12)
(setq pp2 ac12)
;(command "line" c12 ac12 "")
(angmember)
))
(if (= newstud_membertype "P")
(progn
(setq ccin ns2) (setq pipedia diameter) 
(C-Clamp2)
(setq acin ns1)
(GA-01_twobolts)
(setq n_ang1 (angle c11 ac11))
(setq n_ang2 (angle ac11 c11))
(setq c12 (polar c11 n_ang2 40))
;(command "_insert" "16c" c12 "" "" "")
(setq ac12 (polar ac11 n_ang1 40))
;(command "_insert" "16c" ac12 "" "" "")
(setq pp1 c12)
(setq pp2 ac12)
(setq structending ac12)  
(setq structstarting c12)
;(command "line" ac12 c12 "") newst
(pipemember_twobolts)))

(setq newst_ang (- 180 (rtd n_ang2)))
(setq newst_platex1 (abs (Number_Round (* 40 (sin newst_ang)) 1)))
(setq newst_platey1 (Number_Round (sqrt (- (* 40 40) (* newst_platex1 newst_platex1))) 1))
(setq newst_platex2 (- 150 (+ newst_platex1 25)))
(setq newst_platey2 (- 100 (+ newst_platey1 25)))

;************************************************************
(setq index (1+ index))
(if (= index 1) (progn 
(setq newstud1_x1 newstud_x) (setq newstud1_y1 newstud_y)
(setq newstud1_pdwt newstud_pedestalwidth) (setq newstud1_pdht newstud_pedestalhight)
(setq newstud1_memty newstud_membertype)
(setq newstud1_memlen (distance pp1 pp2))
(setq newstud1_memname memname)
(setq newstud1_blockwt blockwt)
(setq newstud1_backmark bm)
(setq newstud1_platex1 newst_platex1) ;baseplate cleat
(setq newstud1_platey1 newst_platey1) ;baseplate cleat
(setq newstud1_platex2 newst_platex2) ;baseplate cleat
(setq newstud1_platey2 newst_platey2) ;baseplate cleat
(setq newstud1_clampx1 cc2_d1) ;struct clamp plate upprer dim
(setq newstud1_clmapx2 cc2_d2) ;struct clamp pltte lower dim
(if (= newstud_membertype "P") (progn (setq newst1_sizename1 DD3) (setq newst1_sizename2 L2) (setq newst1_size DD1) (setq newst1_thick DDTICK)))
(if (= newstud_membertype "A") (progn  (setq newst1_size flange) (setq newst1_thick th)))
(setq structsize newst1_size) ;for hip
))
  
(if (= index 2) (progn 
(setq newstud2_x1 newstud_x) (setq newstud2_y1 newstud_y)
(setq newstud2_pdwt newstud_pedestalwidth) (setq newstud2_pdht newstud_pedestalhight)
(setq newstud2_memty newstud_membertype)
(setq newstud2_memlen (distance pp1 pp2))
(setq newstud2_memname memname)
(setq newstud2_blockwt blockwt)
(setq newstud2_backmark bm)
(setq newstud2_platex1 newst_platex1) ;baseplate cleat
(setq newstud2_platey1 newst_platey1) ;baseplate cleat
(setq newstud2_platex2 newst_platex2) ;baseplate cleat
(setq newstud2_platey2 newst_platey2) ;baseplate cleat
(setq newstud2_clampx1 cc2_d1) ;struct clamp plate upprer dim
(setq newstud2_clmapx2 cc2_d2) ;struct clamp pltte lower dim
(if (= newstud_membertype "P") (progn (setq newst2_sizename1 DD3) (setq newst2_sizename2 L2) (setq newst2_size DD1) (setq newst2_thick DDTICK)))
(if (= newstud_membertype "A") (progn  (setq newst2_size flange) (setq newst2_thick th)))
(setq structsize newst2_size) ;for hip
))
;************************************************************
(setq twost_ang newtwost_ang)
(setq exst1_x newstud_x)
(setq exst1_ty newstud_membertype)
(hip_eqfaces)
;************HIP TRIGGERS*************
(if (= hip_mem 1) (progn
(if (= index 1) (progn (setq newstud1_hipmem1_len hip_memlen1) (setq newstud1_hipmem1_type hip_mem1_type) 
(setq newstud1_hipmem1_ang1 hip_plan_ang1) (setq newstud1_hipmem1_ang2 hip_plan_ang2)
(setq newstud1_hipmem1_memname memname)
(setq newstud1_hipmem1_blockwt blockwt)
(setq newstud1_hipmem1_backmark bm)
(if (= hip_mem1_type "P") (progn (setq newstud1_hipmem1_sizename1 DD3) (setq newstud1_hipmem1_sizename2 L2) (setq newstud1_hipmem1_size DD1) (setq newstud1_hipmem1_thick DDTICK) ))
(if (= hip_mem1_type "A") (progn (setq newstud1_hipmem1_size flange) (setq newstud1_hipmem1_thick th) ))
))
(if (= index 2) (progn (setq newstud2_hipmem1_len hip_memlen1) (setq newstud2_hipmem1_type hip_mem1_type) 
(setq newstud2_hipmem1_ang1 hip_plan_ang1) (setq newstud2_hipmem1_ang2 hip_plan_ang2)
(setq newstud2_hipmem1_memname memname)
(setq newstud2_hipmem1_blockwt blockwt)
(setq newstud2_hipmem1_backmark bm)
(if (= hip_mem1_type "P") (progn (setq newstud2_hipmem1_sizename1 DD3) (setq newstud2_hipmem1_sizename2 L2) (setq newstud2_hipmem1_size DD1) (setq newstud2_hipmem1_thick DDTICK) ))
(if (= hip_mem1_type "A") (progn (setq newstud2_hipmem1_size flange) (setq newstud2_hipmem1_thick th)))
))
))

(if (= hip_mem 2) (progn
(if (= index 1) (progn (setq newstud1_hipmem1_len hip_memlen1) (setq newstud1_hipmem1_type hip_mem1_type) (setq newstud1_hipmem1_ang1 hip_plan_ang1) (setq newstud1_hipmem1_ang2 hip_plan_ang2)
					   (setq newstud1_hipmem2_len hip_memlen2) (setq newstud1_hipmem2_type hip_mem1_type) (setq newstud1_hipmem2_ang1 hip_plan_ang1) (setq newstud1_hipmem2_ang2 hip_plan_ang2)
(setq newstud1_hipmem1_memname memname)
(setq newstud1_hipmem1_blockwt blockwt)
(setq newstud1_hipmem1_backmark bm)
(if (= hip_mem1_type "P") (progn (setq newstud1_hipmem1_sizename1 DD3) (setq newstud1_hipmem1_sizename2 L2) (setq newstud1_hipmem1_size DD1) (setq newstud1_hipmem1_thick DDTICK) ))
(if (= hip_mem1_type "A") (progn (setq newstud1_hipmem1_size flange) (setq newstud1_hipmem1_thick th) ))
					   ))
(if (= index 2) (progn (setq newstud2_hipmem1_len hip_memlen1) (setq newstud2_hipmem1_type hip_mem1_type) (setq newstud2_hipmem1_ang1 hip_plan_ang1) (setq newstud2_hipmem1_ang2 hip_plan_ang2)
					   (setq newstud2_hipmem2_len hip_memlen2) (setq newstud2_hipmem2_type hip_mem1_type) (setq newstud2_hipmem2_ang1 hip_plan_ang1) (setq newstud2_hipmem2_ang2 hip_plan_ang2)
(setq newstud2_hipmem1_memname memname)
(setq newstud2_hipmem1_blockwt blockwt)
(setq newstud2_hipmem1_backmark bm)
(if (= hip_mem1_type "P") (progn (setq newstud2_hipmem1_sizename1 DD3) (setq newstud2_hipmem1_sizename2 L2) (setq newstud2_hipmem2_size DD1) (setq newstud2_hipmem1_thick DDTICK) ))
(if (= hip_mem1_type "A") (progn (setq newstud2_hipmem2_size flange) (setq newstud2_hipmem1_thick th)))
					   ))
					   ))
;*************************************
(setq newst_mem_onpole (getint "\nEnter the number of new members on pole<0/1/2>:"))
(setq newst_mem_onstruct (getint "\nEnter the number of new members on struct<0/1/2>:"))
(if (and (= newst_mem_onpole 1) (= newst_mem_onstruct 1))
(progn
(setq new_mem_y1 (getint "\nEnter the vertical distance from slab to new member on pole:"))
(setq new_mem_y2 (getint "\nEnter the vertical distance from slab to new member on struct:"))

(setq newm1 (polar polestarting (DTR 90.0) new_mem_y1)) ;point for new member on pole
(setq newm2 (polar polestarting (DTR 90.0) new_mem_y2)) ;referance point for new member on struct
(setq newm3 (polar newm2 (DTR 0.0) 10000))
(setq newm4 (inters structending structstarting newm2 newm3)) ;point for new member on struct

(if (= polejoints 0) (setq diameter diameter_1))
(if (= polejoints 1) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if (> new_mem_y1 joint_1) (setq diameter diameter_2))))
(if (= polejoints 2) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if ( and (> new_mem_y1 joint_1) (< new_mem_y1 joint_2)) (setq diameter diameter_2)) (if (> new_mem_y1 joint_2) (setq diameter diameter_3))))

(setq ccin newm1) 
(setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location

(setq newm_ang1 (angle structstarting structending))
(setq newm_ang2 (rtd newm_ang1))
(setq newm_ang3 (- 180 newm_ang2))
(setq newm_ang4 (DTR newm_ang3))

(if (= newstud_membertype "A") 
(progn 
;(command "_insert" "16c" newm4 "" "" "") 
(setq pp2 newm4) 
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))))

(if (= newstud_membertype "P") 
(progn (setq newm11 (/ structsize 2)) (setq newm12 (/ newm11 (sin newm_ang4)))
(setq tempcal (sqrt (- (* (/ 80 (sin newm_ang4)) (/ 80 (sin newm_ang4))) (* 80 80) )))
(setq newm13 (polar newm4 (DTR 0.0) newm12))
(setq newm14 (polar newm13 newm_ang1 (/ 40 (sin newm_ang4))))
(setq newm15 (polar newm14 (DTR 180.0) 75))
(setq newm16 (polar newm15 (DTR 270.0) 80))
(setq newm17 (polar newm16 (DTR 0.0) (+ tempcal 75)))
(setq newm18ttt (polar newm14 (DTR 180.0) 50))
(setq newm18 (polar newm18ttt (DTR 270.0) 40)) ;hole location on struct
;(command "line" newm14 newm15 newm16 newm17 "")
;(command "_insert" "16c" newm18 "" "" "")
(setq pp2 newm18)
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))))
;********************************************************
(setq newst1_newmem1_y1 new_mem_y1) (setq newst1_newmem1_y2 new_mem_y2) 
(setq newst1_newmem1_type newm_memtype)  
(setq newst1_newmem1_len (Number_Round (distance pp1 pp2) 1))
(setq newst1_newmem1_memname memname)
(setq newst1_newmem1_blockwt blockwt)
(setq newst1_newmem1_backmark bm)
(if (= newm_memtype "P") (progn (setq newst1_newmem1_sizename1 DD3) (setq newst1_newmem1_sizename2 L2) (setq newst1_newmem1_size DD1) (setq newst1_newmem1_thick DDTICK) 
							(setq newst1_newmem1_stx1 (Number_Round (+ tempcal 100) 1)) ;struct plate for connect new member
							(setq newst1_newmem1_stx2 (Number_Round tempcal 1)) ;struct plate for connect new member
						))
(if (= newm_memtype "A") (progn  (setq newst1_newmem1_size flange) (setq newst1_newmem1_thick th)))
(setq newst1_newmem1_pclampx1 cc1_d1) 
(setq newst1_newmem1_pclampx2 cc1_d2) 
(setq newst1_newmem1_pclampR R_cc1)

(if (= newstud_membertype "P") (progn 
	(if (> (distance structstarting structending) 6000) (progn
		(setq newst1_joint1 (Number_Round (+ (distance structstarting newm4) 100) 1)) ;100(plate clear)
		(setq newst1_joint2 (Number_Round (- (distance newm4 structending) 100) 1))
	))
	(if (< (distance structstarting structending) 6000) (progn
		(setq newst1_joint1 (Number_Round (distance structstarting newm4) 1)) ;no need of 100(plate clear)+25(shearedge)
		(setq newst1_joint2 (Number_Round (distance newm4 structending) 1))
	))
))
(if (= newstud_membertype "A") (progn 
	(if (> (distance structstarting structending) 6000) (progn
		(setq newst1_joint1 (Number_Round (+ (distance structstarting newm4) 200) 1)) ;100(plate clear)
		(setq newst1_joint2 (Number_Round (- (distance newm4 structending) 200) 1))
	))
	(if (< (distance structstarting structending) 6000) (progn
		(setq newst1_joint1 (Number_Round (distance structstarting newm4) 1)) ;no need of joint 100(plate clear)+25(shearedge)
		(setq newst1_joint2 (Number_Round (distance newm4 structending) 1))
	))
))

;********************************************************
));opt1,opt1 newst1_joint2
(if (and (= newst_mem_onpole 1) (= newst_mem_onstruct 2))
(progn
(setq new_mem_y1 (getint "\nEnter the vertical distance from slab to new member on pole:"))
(setq new_mem_y2 (getint "\nEnter the vertical distance from slab to bollom (or first ) new member on struct:"))
(setq new_mem_y3 (getint "\nEnter the vertical distance from slab to top (or secound) new member on struct:"))

(setq newm1 (polar polestarting (DTR 90.0) new_mem_y1)) ;point for new member on pole
(setq newm2 (polar polestarting (DTR 90.0) new_mem_y2)) 
(setq newm3 (polar newm2 (DTR 0.0) 10000))
(setq newm4 (inters structending structstarting newm2 newm3)) ;first point for new member on struct
(setq newm5 (polar polestarting (DTR 90.0) new_mem_y3))
(setq newm6 (polar newm5 (DTR 0.0) 10000))
(setq newm7 (inters structending structstarting newm5 newm6)) ;second point for new member on struct

(if (= polejoints 0) (setq diameter diameter_1)) 
(if (= polejoints 1) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if (> new_mem_y1 joint_1) (setq diameter diameter_2))))
(if (= polejoints 2) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if ( and (> new_mem_y1 joint_1) (< new_mem_y1 joint_2)) (setq diameter diameter_2)) (if (> new_mem_y1 joint_2) (setq diameter diameter_3))))

(setq ccin newm1) 
(setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq newm_ang1 (angle structstarting structending))
(setq newm_ang2 (rtd newm_ang1))
(setq newm_ang3 (- 180 newm_ang2))
(setq newm_ang4 (DTR newm_ang3))

(if (= newstud_membertype "A") 
(progn 
;(command "_insert" "16c" newm4 "" "" "")
(setq pp2 newm4) 
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new struct member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))
;(command "_insert" "16c" newm7 "" "" "")
(setq pp2 newm7) 
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new struct member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))
))

(if (= newstud_membertype "P") 
(progn 
(setq newm11 (/ newstud_membersize 2)) (setq newm12 (/ newm11 (sin newm_ang4)))
(setq tempcal (sqrt (- (* (/ 80 (sin newm_ang4)) (/ 80 (sin newm_ang4))) (* 80 80) )))

(setq newm13 (polar newm4 (DTR 0.0) newm12))
(setq newm14 (polar newm13 newm_ang1 (/ 40 (sin newm_ang4))))
(setq newm15 (polar newm14 (DTR 180.0) 75))
(setq newm16 (polar newm15 (DTR 270.0) 80))
(setq newm17 (polar newm16 (DTR 0.0) (+ tempcal 75)))
(setq newm18ttt (polar newm14 (DTR 180.0) 50))
(setq newm18 (polar newm18ttt (DTR 270.0) 40)) ;hole location on struct

;(command "line" newm14 newm15 newm16 newm17 "")
;(command "_insert" "16c" newm18 "" "" "")
(setq pp2 newm18)
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new struct member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))
;;
(setq newm19 (polar newm7 (DTR 0.0) newm12))
(setq newm20 (polar newm19 newm_ang1 (/ 40 (sin newm_ang4))))
(setq newm21 (polar newm20 (DTR 180.0) 100))
(setq newm22 (polar newm21 (DTR 270.0) 80))
(setq newm23 (polar newm22 (DTR 0.0) (+ tempcal 100)))
(setq newm24 (polar newm19 (DTR 180.0) 75)) ;hole location on struct
;(command "line" newm20 newm21 newm22 newm23 "")
;(command "_insert" "16c" newm24 "" "" "")
(setq pp2 newm24)
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new struct member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))
))
;********************************************************
(setq newst_mem1y1 new_mem_y1) (setq newst_mem1y2 new_mem_y2) (setq newst_mem1type1 newm_memtype) (setq newst_mem1size1 newm_memsize) 
(setq cc1_d1_x1 cc1_d1) (setq cc1_d1_x2 cc1_d2) (setq cc1_d1_r R) (setq newstplt_len_x1 (Number_Round(+ tempcal 75) 1)) (setq newstplt_len_x2 (Number_Round tempcal 1))
;********************************************************
));opt1,opt2
(if (and (= newst_mem_onpole 2) (= newst_mem_onstruct 2))
(progn
(setq index 0)
(repeat 2
(setq new_mem_y1 (getint "\nEnter the vertical distance from slab to new member on pole:"))
(setq new_mem_y2 (getint "\nEnter the vertical distance from slab to new member on struct:"))

(setq newm1 (polar polestarting (DTR 90.0) new_mem_y1)) ;point for new member on pole
(setq newm2 (polar polestarting (DTR 90.0) new_mem_y2)) ;referance point for new member on struct
(setq newm3 (polar newm2 (DTR 0.0) 10000))
(setq newm4 (inters structending structstarting newm2 newm3)) ;point for new member on struct

(if (= polejoints 0) (setq diameter diameter_1))
(if (= polejoints 1) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if (> new_mem_y1 joint_1) (setq diameter diameter_2))))
(if (= polejoints 2) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if ( and (> new_mem_y1 joint_1) (< new_mem_y1 joint_2)) (setq diameter diameter_2)) (if (> new_mem_y1 joint_2) (setq diameter diameter_3))))

(setq ccin newm1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location

(setq newm_ang1 (angle structstarting structending))
(setq newm_ang2 (rtd newm_ang1))
(setq newm_ang3 (- 180 newm_ang2))
(setq newm_ang4 (DTR newm_ang3))

(if (= newstud_membertype "A") 
(progn 
;(command "_insert" "16c" newm4 "" "" "")
(setq pp2 newm4) 
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new struct member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))))

(if (= newstud_membertype "P") 
(progn (setq newm11 (/ structsize 2)) (setq newm12 (/ newm11 (sin newm_ang4)))
(setq tempcal (sqrt (- (* (/ 80 (sin newm_ang4)) (/ 80 (sin newm_ang4))) (* 80 80) )))
(setq newm13 (polar newm4 (DTR 0.0) newm12))
(setq newm14 (polar newm13 newm_ang1 (/ 40 (sin newm_ang4))))
(setq newm15 (polar newm14 (DTR 180.0) 75))
(setq newm16 (polar newm15 (DTR 270.0) 80))
(setq newm17 (polar newm16 (DTR 0.0) (+ tempcal 75)))
(setq newm18ttt (polar newm14 (DTR 180.0) 50))
(setq newm18 (polar newm18ttt (DTR 270.0) 40)) ;hole location on struct
;(command "line" newm14 newm15 newm16 newm17 "")
;(command "_insert" "16c" newm18 "" "" "")
(setq pp2 newm18)
(initget 1 "A P")
(setq newm_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq newm_memsize (getstring "\nEnter the new struct member size::"))
(setq memshoft newm_memsize)
(if (= newm_memtype "A") (angmember))
(if (= newm_memtype "P") (pipemember))))
;********************************************************
(setq index (1+ index))
(if (= index 1) (progn 
(setq newst1_newmem1_y1 new_mem_y1) (setq newst1_newmem1_y2 new_mem_y2) 
(setq newst1_newmem1_type newm_memtype)  
(setq newst1_newmem1_len (Number_Round (distance pp1 pp2) 1))
(setq newst1_newmem1_memname memname)
(setq newst1_newmem1_blockwt blockwt)
(setq newst1_newmem1_backmark bm)
(if (= newm_memtype "P") (progn (setq newst1_newmem1_sizename1 DD3) (setq newst1_newmem1_sizename2 L2) (setq newst1_newmem1_size DD1) (setq newst1_newmem1_thick DDTICK)
(setq newst1_newmem1_stx1 (Number_Round (+ tempcal 100) 1)) ;struct plate for connect new member
(setq newst1_newmem1_stx2 (Number_Round tempcal 1)) ;struct plate for connect new member
))
(if (= newm_memtype "A") (progn  (setq newst1_newmem1_size flange) (setq newst1_newmem1_thick th)))
(setq newst1_newmem1_pclampx1 cc1_d1) 
(setq newst1_newmem1_pclampx2 cc1_d2) 
(setq newst1_newmem1_pclampR R_cc1 )
(setq newst1_joint1_temp1 (Number_Round (distance structstarting newm4) 1))
(setq newst1_joint2_temp1 (Number_Round (distance newm4 structending) 1))
;(setq newmempoint1_onstruct newm4)
))

(if (= index 2) (progn 
(setq newst1_newmem2_y1 new_mem_y1) (setq newst1_newmem2_y2 new_mem_y2) 
(setq newst1_newmem2_type newm_memtype)  
(setq newst1_newmem2_len (distance pp1 pp2))
(setq newst1_newmem2_memname memname)
(setq newst1_newmem2_blockwt blockwt)
(setq newst1_newmem2_backmark bm)
(if (= newm_memtype "P") (progn (setq newst1_newmem2_sizename1 DD3) (setq newst1_newmem2_sizename2 L2) (setq newst1_newmem2_size DD1) (setq newst1_newmem2_thick DDTICK)
(setq newst1_newmem2_stx1 (Number_Round (+ tempcal 100) 1)) ;struct plate for connect new member
(setq newst1_newmem2_stx2 (Number_Round tempcal 1)) ;struct plate for connect new member
))
(if (= newm_memtype "A") (progn  (setq newst1_newmem2_size flange) (setq newst1_newmem2_thick th)))
(setq newst1_newmem2_pclampx1 cc1_d1) 
(setq newst1_newmem2_pclampx2 cc1_d2) 
(setq newst1_newmem2_pclampR R_cc1 )

(setq newst1_joint1_temp2 (Number_Round (distance structstarting newm4) 1))
(setq newst1_joint2_temp2 (Number_Round (distance newm4 structending) 1))

(if (< (distance structstarting structending) 6000) (progn
		(if (> newst1_joint1_temp2 newst1_joint1_temp1) (progn (setq newst1_joint1 newst1_joint1_temp1) (setq newst1_joint2 (- newst1_joint1_temp2 newst1_joint2_temp2)) (setq newst1_joint3 newst1_joint2_temp2)))
		(if (> newst1_joint1_temp1 newst1_joint1_temp2) (progn (setq newst1_joint1 newst1_joint1_temp2) (setq newst1_joint2 (- newst1_joint2_temp2 newst1_joint2_temp1)) (setq newst1_joint3 newst1_joint2_temp1)))
	))
	;(if (< (distance structstarting structending) 6000) (progn
	;	(if (> newst1_joint1_temp2 newst1_joint1_temp1) (progn (setq newst1_joint1 newst1_joint1_temp1) (setq newst1_joint2_1 (/ (- newst1_joint1_temp2 newst1_joint2_temp2) 2)) (setq newst1_joint2_2 (/ (- newst1_joint1_temp2 newst1_joint2_temp2) 2)) (setq newst1_joint3 newst1_joint2_temp2)))
	;	(if (> newst1_joint1_temp1 newst1_joint1_temp2) (progn (setq newst1_joint1 newst1_joint1_temp2) (setq newst1_joint2_1 (/ (- newst1_joint2_temp2 newst1_joint2_temp1) 2)) (setq newst1_joint2_2 (/ (- newst1_joint2_temp2 newst1_joint2_temp1) 2)) (setq newst1_joint3 newst1_joint2_temp1)))
	;))
;(setq newmempoint2_onstruct newm4)
;(if (> newst1_newmem1_y1 newst1_newmem2_y1) (progn (setq newst1_joint1 (Number_Round (distance structstarting newmempoint1_onstruct) 1)) (setq newst1_joint2 (Number_Round (- (distance structstarting newmempoint2_onstruct) (distance structstarting newmempoint1_onstruct)) 1)) (setq newst1_joint3 (Number_Round (distance structending newmempoint2_onstruct) 1))))
;(if (> newst1_newmem2_y1 newst1_newmem1_y1) (progn (setq newst1_joint1 (Number_Round (distance structstarting newmempoint2_onstruct) 1)) (setq newst1_joint2 (Number_Round (- (distance structstarting newmempoint1_onstruct) (distance structstarting newmempoint2_onstruct)) 1)) (setq newst1_joint3 (Number_Round (distance structending newmempoint1_onstruct) 1))))
))
;********************************************************
)));opt2,opt2
))))
(defun angmember() 
  (setq ang (angle pp1 pp2))
  (setq shearedge 25)
(setq ang1 (+ ang (dtr 90)))
	;(setq memshoft (itoa memshoft))
(if (= memshoft "405") (progn (setq flange 40) (setq bm 22) (setq th 5) (setq memname "L40x40x5") (setq blockwt 3.0) ))
(if (= memshoft "453") (progn (setq flange 45) (setq bm 23) (setq th 3) (setq memname "L45x45x3") (setq blockwt 3.5) ))
(if (= memshoft "454") (progn (setq flange 45) (setq bm 23) (setq th 4) (setq memname "L45x45x4") (setq blockwt 2.7) ))
(if (= memshoft "455") (progn (setq flange 45) (setq bm 23) (setq th 5) (setq memname "L45x45x5") (setq blockwt 3.4) ))
(if (= memshoft "503") (progn (setq flange 50) (setq bm 28) (setq th 3) (setq memname "L50x50x3") (setq blockwt 2.3) ))
(if (= memshoft "504") (progn (setq flange 50) (setq bm 28) (setq th 4) (setq memname "L50x50x4") (setq blockwt 3.0) ))
(if (= memshoft "505") (progn (setq flange 50) (setq bm 28) (setq th 5) (setq memname "L50x50x5") (setq blockwt 3.8) ))
(if (= memshoft "554") (progn (setq flange 55) (setq bm 33) (setq th 4) (setq memname "L55x55x4") (setq blockwt 3.3) ))
(if (= memshoft "555") (progn (setq flange 55) (setq bm 33) (setq th 5) (setq memname "L55x55x5") (setq blockwt 4.1) ))
(if (= memshoft "556") (progn (setq flange 55) (setq bm 33) (setq th 6) (setq memname "L55x55x6") (setq blockwt 4.9) ))
(if (= memshoft "604") (progn (setq flange 60) (setq bm 35) (setq th 4) (setq memname "L60x60x4") (setq blockwt 3.7) ))
(if (= memshoft "605") (progn (setq flange 60) (setq bm 35) (setq th 5) (setq memname "L60x60x5") (setq blockwt 4.5) ))
(if (= memshoft "606") (progn (setq flange 60) (setq bm 35) (setq th 6) (setq memname "L60x60x6") (setq blockwt 5.4) ))
(if (= memshoft "654") (progn (setq flange 65) (setq bm 38) (setq th 4) (setq memname "L65x65x4") (setq blockwt 4.0) ))
(if (= memshoft "655") (progn (setq flange 65) (setq bm 38) (setq th 5) (setq memname "L65x65x5") (setq blockwt 4.9) ))
(if (= memshoft "656") (progn (setq flange 65) (setq bm 38) (setq th 6) (setq memname "L65x65x6") (setq blockwt 5.8) ))
(if (= memshoft "705") (progn (setq flange 70) (setq bm 40) (setq th 5) (setq memname "L70x70x5") (setq blockwt 5.3) ))
(if (= memshoft "706") (progn (setq flange 70) (setq bm 40) (setq th 6) (setq memname "L70x70x6") (setq blockwt 6.3) ))
(if (= memshoft "755") (progn (setq flange 75) (setq bm 40) (setq th 5) (setq memname "L75x75x5") (setq blockwt 5.7) ))
(if (= memshoft "756") (progn (setq flange 75) (setq bm 40) (setq th 6) (setq memname "L75x75x6") (setq blockwt 6.8) ))
(if (= memshoft "806") (progn (setq flange 80) (setq bm 45) (setq th 6) (setq memname "L80x80x6") (setq blockwt 7.3) ))
(if (= memshoft "808") (progn (setq flange 80) (setq bm 45) (setq th 8) (setq memname "L80x80x8") (setq blockwt 9.6) ))
(if (= memshoft "906") (progn (setq flange 90) (setq bm 50) (setq th 6) (setq memname "L90x90x6") (setq blockwt 8.2) ))
(if (= memshoft "908") (progn (setq flange 90) (setq bm 50) (setq th 8) (setq memname "L90x90x8") (setq blockwt 10.8) ))
(if (= memshoft "1006") (progn (setq flange 100) (setq bm 60) (setq th 6) (setq memname "100x100x6") (setq blockwt 9.2) ))
(if (= memshoft "1008") (progn (setq flange 100) (setq bm 60) (setq th 8) (setq memname "100x100x8") (setq blockwt 12.1) ))
(if (= memshoft "10010") (progn (setq flange 100) (setq bm 60) (setq th 10) (setq memname "100x100x10") (setq blockwt 14.9) ))
(if (= memshoft "1108") (progn (setq flange 110) (setq bm 65) (setq th 8) (setq memname "110x110x8") (setq blockwt 13.4) ))
(if (= memshoft "11010") (progn (setq flange 110) (setq bm 65) (setq th 10) (setq memname "110x110x10") (setq blockwt 16.6) ))
(if (= memshoft "1308") (progn (setq flange 130) (setq bm 80) (setq th 8) (setq memname "130x130x10") (setq blockwt 15.9) ))
(if (= memshoft "13010") (progn (setq flange 130) (setq bm 80) (setq th 10) (setq memname "130x130x10") (setq blockwt 19.7) ))
(if (= memshoft "13012") (progn (setq flange 130) (setq bm 80) (setq th 12) (setq memname "130x130x12") (setq blockwt 23.5) ))
(if (= memshoft "15010") (progn (setq flange 150) (setq bm 90) (setq th 10) (setq memname "150x150x12") (setq blockwt 22.9) ))
(if (= memshoft "15012") (progn (setq flange 150) (setq bm 90) (setq th 12) (setq memname "150x150x12") (setq blockwt 27.3) ))
	
    (setq pp3ref (polar pp1 ang1 (- bm th))
             pp3 (polar pp3ref (angle pp2 pp1) shearedge)
          pp4ref (polar pp2 ang1 (- bm th))
             pp4 (polar pp4ref (angle pp1 pp2) shearedge)
          pp5ref (polar pp1 ang1 bm)
             pp5 (polar pp5ref (angle pp2 pp1) shearedge)
          pp6ref (polar pp2 ang1 bm)
             pp6 (polar pp6ref (angle pp1 pp2) shearedge)
          pp7ref (polar pp1 (+ ang1 (dtr 180)) (- flange bm))
             pp7 (polar pp7ref (angle pp2 pp1) shearedge)
          pp8ref (polar pp2 (+ ang1 (dtr 180)) (- flange bm))
             pp8 (polar pp8ref (angle pp1 pp2) shearedge)
    ) 
    ;(command "layer" "s" "mem" "")
    ;(command "line" pp3 pp4 "")
    ;(command "chprop" "l" "" "la" "das" "")
    ;(command "line" pp5 pp6 "")
    ;(command "line" pp7 pp8 "")
    ;(command "line" pp7 pp5 "")
    ;(command "line" pp6 pp8 "")

)

(defun pipemember() 

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

    ;(command "layer" "s" "mem" "")
	;(command "line" pp7 pp5 pp9 pp11 pp21 pp19 pp15 pp17 pp18 pp22 pp12 pp8 pp7 "")
    ;(command "layer" "s" "das" "")
	;(command "line" pp29 pp30 pp31 pp32 pp33 pp34 "")
	;(command "line" pp35 pp36 pp37 pp38 pp39 pp40 "")
    ;(command "layer" "s" "gus" "")
	;(command "line" pp4 pp23 "")
	;(command "line" pp6 pp24 "")
	;(command "line" pp14 pp26 "")
	;(command "line" pp16 pp28 "")
	;(command "arc" pp23 pp25 pp24 "")
	;(command "arc" pp26 pp27 pp28 "")
	;(command "layer" "s" "mem" "")
	
	)
	
(defun pipemember_twobolts() 

(setq ang (angle pp1 pp2)) ;for 0
(setq shearedge 25)
(setq ang1 (+ ang (dtr 90)))   ; for 90
(setq ang2 (angle pp2 pp1))    ; for 0 to 180
(setq ang3 (+ ang1 (dtr 180))) ;for 270
	
(if (= memshoft "48.3x2.9") (progn (setq DD1 48.3) (setq DD2 68.4) (setq bm 34.2) (setq DD3 (strcat "48.3" "%%c")) (setq L1 100) (setq L2 72) (setq TT1 22) (setq DDTICK 2.9) (setq memname "PIPE48.3x2.9Thk") (setq blockwt 3.23)))
(if (= memshoft "48.3x3.2") (progn (setq DD1 48.3) (setq DD2 68.4) (setq bm 34.2) (setq DD3 (strcat "48.3" "%%c")) (setq L1 100) (setq L2 72) (setq TT1 22) (setq DDTICK 3.2) (setq memname "PIPE48.3x3.2Thk") (setq blockwt 3.56)))
(if (= memshoft "48.3x4.0") (progn (setq DD1 48.3) (setq DD2 68.4) (setq bm 34.2) (setq DD3 (strcat "48.3" "%%c")) (setq L1 100) (setq L2 72) (setq TT1 22) (setq DDTICK 4.0) (setq memname "PIPE48.3x4.0Thk") (setq blockwt 4.37)))
(if (= memshoft "60.3x2.9") (progn (setq DD1 60.3) (setq DD2 80) (setq bm 40) (setq DD3 (strcat "60.3" "%%c")) (setq L1 100) (setq L2 90) (setq TT1 15) (setq DDTICK 2.9) (setq memname "PIPE60.3x2.9Thk") (setq blockwt 4.08)))
(if (= memshoft "60.3x3.6") (progn (setq DD1 60.3) (setq DD2 80) (setq bm 40) (setq DD3 (strcat "60.3" "%%c")) (setq L1 100) (setq L2 90) (setq TT1 15) (setq DDTICK 3.6) (setq memname "PIPE60.3x3.6Thk") (setq blockwt 5.03)))
(if (= memshoft "60.3x4.5") (progn (setq DD1 60.3) (setq DD2 80) (setq bm 40) (setq DD3 (strcat "60.3" "%%c")) (setq L1 100) (setq L2 90) (setq TT1 15) (setq DDTICK 4.5) (setq memname "PIPE60.3x4.5Thk") (setq blockwt 6.19)))
(if (= memshoft "76.1x3.2") (progn (setq DD1 76.1) (setq DD2 107) (setq bm 53.5) (setq DD3 (strcat "76.1" "%%c")) (setq L1 100) (setq L2 114) (setq TT1 20) (setq DDTICK 3.2) (setq memname "PIPE76.1x3.2Thk")(setq blockwt 5.71)))
(if (= memshoft "76.1x3.6") (progn (setq DD1 76.1) (setq DD2 107) (setq bm 53.5) (setq DD3 (strcat "76.1" "%%c")) (setq L1 100) (setq L2 114) (setq TT1 20) (setq DDTICK 3.6) (setq memname "PIPE76.1x3.6Thk")(setq blockwt 6.42)))
(if (= memshoft "76.1x4.5") (progn (setq DD1 76.1) (setq DD2 107) (setq bm 53.5) (setq DD3 (strcat "76.1" "%%c")) (setq L1 100) (setq L2 114) (setq TT1 20) (setq DDTICK 4.5) (setq memname "PIPE76.1x4.5Thk")(setq blockwt 7.93)))
(if (= memshoft "88.9x3.2") (progn (setq DD1 88.9) (setq DD2 127) (setq bm 63.5) (setq DD3 (strcat "88.9" "%%c")) (setq L1 100) (setq L2 133) (setq TT1 39) (setq DDTICK 3.2) (setq memname "PIPE88.9x3.2Thk") (setq blockwt 6.72)))
(if (= memshoft "88.9x4.0") (progn (setq DD1 88.9) (setq DD2 127) (setq bm 63.5) (setq DD3 (strcat "88.9" "%%c")) (setq L1 100) (setq L2 133) (setq TT1 39) (setq DDTICK 4.0) (setq memname "PIPE88.9x4.0Thk") (setq blockwt 8.36)))
(if (= memshoft "88.9x4.8") (progn (setq DD1 88.9) (setq DD2 127) (setq bm 63.5) (setq DD3 (strcat "88.9" "%%c")) (setq L1 100) (setq L2 133) (setq TT1 39) (setq DDTICK 4.8) (setq memname "PIPE88.9x4.8Thk") (setq blockwt 9.90)))
(if (= memshoft "101.6x3.6") (progn (setq DD1 101.6) (setq DD2 147) (setq bm 73.5) (setq DD3 (strcat "101.6" "%%c")) (setq L1 100) (setq L2 152) (setq TT1 45) (setq DDTICK 3.6) (setq memname "PIPE101.6x3.6Thk") (setq blockwt 8.70)))
(if (= memshoft "101.6x4.0") (progn (setq DD1 101.6) (setq DD2 147) (setq bm 73.5) (setq DD3 (strcat "101.6" "%%c")) (setq L1 100) (setq L2 152) (setq TT1 45) (setq DDTICK 4.0) (setq memname "PIPE101.6x4.0Thk") (setq blockwt 9.63)))
(if (= memshoft "101.6x4.8") (progn (setq DD1 101.6) (setq DD2 147) (setq bm 73.5) (setq DD3 (strcat "101.6" "%%c")) (setq L1 100) (setq L2 152) (setq TT1 45) (setq DDTICK 4.8) (setq memname "PIPE101.6x4.8Thk") (setq blockwt 11.5)))
(if (= memshoft "114.3x3.6") (progn (setq DD1 114.3) (setq DD2 167) (setq bm 83.5) (setq DD3 (strcat "114.3" "%%c")) (setq L1 100) (setq L2 172) (setq TT1 50) (setq DDTICK 3.6) (setq memname "PIPE114.3x3.6Thk") (setq blockwt 9.75)))
(if (= memshoft "114.3x4.5") (progn (setq DD1 114.3) (setq DD2 167) (setq bm 83.5) (setq DD3 (strcat "114.3" "%%c")) (setq L1 100) (setq L2 172) (setq TT1 50) (setq DDTICK 4.5) (setq memname "PIPE114.3x4.5Thk") (setq blockwt 12.2)))
(if (= memshoft "114.3x5.4") (progn (setq DD1 114.3) (setq DD2 167) (setq bm 83.5) (setq DD3 (strcat "114.3" "%%c")) (setq L1 100) (setq L2 172) (setq TT1 50) (setq DDTICK 5.4) (setq memname "PIPE114.3x5.4Thk") (setq blockwt 14.5)))
(if (= memshoft "139.7x4.5") (progn (setq DD1 139.7) (setq DD2 207) (setq bm 103.5) (setq DD3 (strcat "139.7" "%%c")) (setq L1 100) (setq L2 210) (setq TT1 60) (setq DDTICK 4.5) (setq memname "PIPE139.7x4.5Thk") (setq blockwt 15.0)))
(if (= memshoft "139.7x4.8") (progn (setq DD1 139.7) (setq DD2 207) (setq bm 103.5) (setq DD3 (strcat "139.7" "%%c")) (setq L1 100) (setq L2 210) (setq TT1 60) (setq DDTICK 4.8) (setq memname "PIPE139.7x4.8Thk") (setq blockwt 15.9)))
(if (= memshoft "139.7x5.4") (progn (setq DD1 139.7) (setq DD2 207) (setq bm 103.5) (setq DD3 (strcat "139.7" "%%c")) (setq L1 100) (setq L2 210) (setq TT1 60) (setq DDTICK 5.4) (setq memname "PIPE139.7x5.4Thk") (setq blockwt 17.9)))
	
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
	
    (setq pp29 (polar pp5 ang3 DDTICK))	
    (setq pp30 (polar pp9 ang3 DDTICK))	
    (setq pp31 (polar pp11 ang3 DDTICK))	
    (setq pp32 (polar pp21 ang3 DDTICK))	
    (setq pp33 (polar pp19 ang3 DDTICK))	
    (setq pp34 (polar pp15 ang3 DDTICK))	
	
    (setq pp35 (polar pp7 ang1 DDTICK))	
    (setq pp36 (polar pp8 ang1 DDTICK))	
    (setq pp37 (polar pp12 ang1 DDTICK))	
    (setq pp38 (polar pp22 ang1 DDTICK))	
    (setq pp39 (polar pp18 ang1 DDTICK))	
    (setq pp40 (polar pp17 ang1 DDTICK))

    ;(command "layer" "s" "mem" "")
	;(command "line" pp7 pp5 pp9 pp11 pp21 pp19 pp15 pp17 pp18 pp22 pp12 pp8 pp7 "")
    ;(command "layer" "s" "das" "")
	;(command "line" pp29 pp30 pp31 pp32 pp33 pp34 "")
	;(command "line" pp35 pp36 pp37 pp38 pp39 pp40 "")
    ;(command "layer" "s" "gus" "")
	;(command "line" pp4 pp23 "")
	;(command "line" pp6 pp24 "")
	;(command "line" pp14 pp26 "")
	;(command "line" pp16 pp28 "")
	;(command "arc" pp23 pp25 pp24 "")
	;(command "arc" pp26 pp27 pp28 "")
	;(command "layer" "s" "mem" "")
	
	)
(defun amem()
(if (= memshoft "405") (progn (setq flange 40) (setq bm 22) (setq th 5)))
(if (= memshoft "453") (progn (setq flange 45) (setq bm 23) (setq th 3)))
(if (= memshoft "454") (progn (setq flange 45) (setq bm 23) (setq th 4)))
(if (= memshoft "455") (progn (setq flange 45) (setq bm 23) (setq th 5)))
(if (= memshoft "503") (progn (setq flange 50) (setq bm 27) (setq th 3)))
(if (= memshoft "504") (progn (setq flange 50) (setq bm 27) (setq th 4)))
(if (= memshoft "505") (progn (setq flange 50) (setq bm 28) (setq th 5)))
(if (= memshoft "554") (progn (setq flange 55) (setq bm 31) (setq th 4)))
(if (= memshoft "555") (progn (setq flange 55) (setq bm 31) (setq th 5)))
(if (= memshoft "556") (progn (setq flange 55) (setq bm 31) (setq th 6)))
(if (= memshoft "604") (progn (setq flange 60) (setq bm 33) (setq th 4)))
(if (= memshoft "605") (progn (setq flange 60) (setq bm 33) (setq th 5)))
(if (= memshoft "606") (progn (setq flange 60) (setq bm 35) (setq th 6)))
(if (= memshoft "654") (progn (setq flange 65) (setq bm 36) (setq th 4)))
(if (= memshoft "655") (progn (setq flange 65) (setq bm 36) (setq th 5)))
(if (= memshoft "656") (progn (setq flange 65) (setq bm 36) (setq th 6)))
(if (= memshoft "705") (progn (setq flange 70) (setq bm 41) (setq th 5)))
(if (= memshoft "706") (progn (setq flange 70) (setq bm 41) (setq th 6)))
(if (= memshoft "755") (progn (setq flange 75) (setq bm 44) (setq th 5)))
(if (= memshoft "756") (progn (setq flange 75) (setq bm 44) (setq th 6)))
(if (= memshoft "806") (progn (setq flange 80) (setq bm 46) (setq th 6)))
(if (= memshoft "808") (progn (setq flange 80) (setq bm 46) (setq th 8)))
(if (= memshoft "906") (progn (setq flange 90) (setq bm 51) (setq th 6)))
(if (= memshoft "908") (progn (setq flange 90) (setq bm 51) (setq th 8)))
(if (= memshoft "1006") (progn (setq flange 100) (setq bm 56) (setq th 6)))
(if (= memshoft "1008") (progn (setq flange 100) (setq bm 56) (setq th 8)))
(if (= memshoft "10010") (progn (setq flange 100) (setq bm 58) (setq th 10)))
(if (= memshoft "1108") (progn (setq flange 110) (setq bm 61) (setq th 8)))
(if (= memshoft "11010") (progn (setq flange 110) (setq bm 61) (setq th 10)))
(if (= memshoft "1308") (progn (setq flange 130) (setq bm 78) (setq th 8)))
(if (= memshoft "13010") (progn (setq flange 130) (setq bm 78) (setq th 10)))
(if (= memshoft "13012") (progn (setq flange 130) (setq bm 78) (setq th 12)))
(if (= memshoft "15010") (progn (setq flange 150) (setq bm 88) (setq th 10)))
(if (= memshoft "15012") (progn (setq flange 150) (setq bm 88) (setq th 12)))
)
(defun p_dia()
(if (= dia "48.3x2.9") (setq dia 48.3))
(if (= dia "48.3x3.2") (setq dia 48.3))
(if (= dia "48.3x4.0") (setq dia 48.3))
(if (= dia "60.3x2.9") (setq dia 60.3))
(if (= dia "60.3x3.6") (setq dia 60.3))
(if (= dia "60.3x4.5") (setq dia 60.3))
(if (= dia "76.1x3.2") (setq dia 76.1))
(if (= dia "76.1x3.6") (setq dia 76.1))
(if (= dia "76.1x4.5") (setq dia 76.1))
(if (= dia "88.9x3.2") (setq dia 88.9))
(if (= dia "88.9x4.0") (setq dia 88.9))
(if (= dia "88.9x4.8") (setq dia 88.9))
(if (= dia "101.6x3.6") (setq dia 101.6))
(if (= dia "101.6x4.0") (setq dia 101.6))
(if (= dia "101.6x4.8") (setq dia 101.6))
(if (= dia "114.3x3.6") (setq dia 114.3))
(if (= dia "114.3x4.5") (setq dia 114.3))
(if (= dia "114.3x5.4") (setq dia 114.3))
(if (= dia "139.7x4.5") (setq dia 139.7))
(if (= dia "139.7x4.8") (setq dia 139.7))
(if (= dia "139.7x5.4") (setq dia 139.7))
)
(defun existing_newm()
(setq existst_new_onpole (getint "\nEnter the number of new members on pole<0/1/2>:"))
(setq existst_new_onstruct (getint "\nEnter the number of new members on existing struct<0/1/2>:"))

(if (and (= existst_new_onpole 1) (= existst_new_onstruct 1))
(progn
(setq new_mem_y1 (getint "\nEnter the vertical distance from slab to new member on pole:"))
(setq new_mem_y2 (getint "\nEnter the vertical distance from slab to new member on struct:"))

(setq nem1 (polar polestarting (DTR 90.0) new_mem_y1)) ;point for new member on pole
(setq nem2 (polar polestarting (DTR 90.0) new_mem_y2)) ;referance point for new member on struct
(setq nem3 (polar nem2 (DTR 0.0) 10000))
(setq nem4 (inters structending structstarting nem2 nem3)) ;point for new member on struct

(if (= polejoints 0) (setq diameter diameter_1))
(if (= polejoints 1) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if (> new_mem_y1 joint_1) (setq diameter diameter_2))))
(if (= polejoints 2) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if ( and (> new_mem_y1 joint_1) (< new_mem_y1 joint_2)) (setq diameter diameter_2)) (if (> new_mem_y1 joint_2) (setq diameter diameter_3))))

(if (= existingstud_membertype "A") 
(progn 
(setq ccin nem1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq aclampin nem4) 
(A_Clamp)
(setq pp2 angle_clamp_hole)
))

(if (= existingstud_membertype "P") 
(progn 
(setq ccin nem1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq ccin nem4) 
(setq pipedia structsize) 
(C-Clamp3)
(setq pp2 angle_clamp_hole)
))
(initget 1 "A P")
(setq nem_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq nem_memsize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft nem_memsize)
(if (= nem_memtype "A") (angmember))
(if (= nem_memtype "P") (pipemember))
;*****************************************
(setq exst_newmem1_type nem_memtype)
(setq exst_newmem1_size nem_memsize)
(setq exst_newmem1_len (distance pp1 pp2))
(setq exst_newmem1_onpoley1 new_mem_y1)
(if (= exst_newmem1_type "P") (progn ))
(if (= exst_newmem1_type "A") (progn ))
(if (= existingstud_membertype "P") (progn (setq exst_poleclamp_x1 cc1_d1) (setq exst_clamp_x2 cc1_d2) (setq exst_stclamp_x1 cc3_d1) (setq exst_stclamp_x2 cc3_d2) ))	
(if (= existingstud_membertype "A") (progn (setq exst_poleclamp_x1 cc1_d1) (setq exst_clamp_x2 cc1_d2) (setq exst_stclamp_x1 cc3_d1) (setq exst_stclamp_x2 cc3_d2) ))
;*****************************************
));opt1,opt1
(if (and (= existst_new_onpole 1) (= existst_new_onstruct 2))
(progn
(setq new_mem_y1 (getint "\nEnter the vertical distance from slab to new member on pole:"))
(setq new_mem_y2 (getint "\nEnter the vertical distance from slab to bollom new member on struct:"))
(setq new_mem_y3 (getint "\nEnter the vertical distance from slab to top new member on struct:"))

(setq nem1 (polar polestarting (DTR 90.0) new_mem_y1)) ;point for new member on pole
(setq nem2 (polar polestarting (DTR 90.0) new_mem_y2))
(setq nem3 (polar nem2 (DTR 0.0) 10000))
(setq nem4 (inters structending structstarting nem2 nem3)) ;point for new member on struct

(setq nem5 (polar polestarting (DTR 90.0) new_mem_y3))
(setq nem6 (polar nem5 (DTR 0.0) 10000))
(setq nem7 (inters structending structstarting nem5 nem6)) ;point for new member on struct

(if (= polejoints 0) (setq diameter diameter_1))
(if (= polejoints 1) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if (> new_mem_y1 joint_1) (setq diameter diameter_2))))
(if (= polejoints 2) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) 
(if ( and (> new_mem_y1 joint_1) (< new_mem_y1 joint_2)) (setq diameter diameter_2)) (if (> new_mem_y1 joint_2) (setq diameter diameter_3)))) 

(if (= existingstud_membertype "A") 
(progn 
(setq ccin nem1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq aclampin nem4) 
(A_Clamp)
(setq pp2 angle_clamp_hole)
(initget 1 "A P")
(setq nem_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq nem_memsize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft nem_memsize)
(if (= nem_memtype "A") (angmember))
(if (= nem_memtype "P") (pipemember))
(setq aclampin nem7) 
(A_Clamp)
(setq pp2 angle_clamp_hole)
(initget 1 "A P")
(setq nem_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq nem_memsize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft nem_memsize)
(if (= nem_memtype "A") (angmember))
(if (= nem_memtype "P") (pipemember))
))
(if (= existingstud_membertype "P") 
(progn 
(setq ccin nem1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq ccin nem4) (setq pipedia structsize) 
(C-Clamp3)
(setq pp2 angle_clamp_hole)
(initget 1 "A P")
(setq nem_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq nem_memsize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft nem_memsize)
(if (= nem_memtype "A") (angmember))
(if (= nem_memtype "P") (pipemember))
(setq ccin nem7) (setq pipedia structsize) 
(C-Clamp3)
(setq pp2 angle_clamp_hole)
(initget 1 "A P")
(setq nem_memtype (getkword "\nEnter the new struct member type <Angle/Pipe>::"))
(setq nem_memsize (getstring "\nEnter the extsting struct member size::"))
(setq memshoft nem_memsize)
(if (= nem_memtype "A") (angmember))
(if (= nem_memtype "P") (pipemember))
))));opt1,opt2	
(if (and (= existst_new_onpole 2) (= existst_new_onstruct 2))
(progn
(setq index 0)
(repeat 2
(setq new_mem_y1 (getint "\nEnter the vertical distance from slab to new member on pole:"))
(setq new_mem_y2 (getint "\nEnter the vertical distance from slab to new member on struct:"))
(setq nem1 (polar polestarting (DTR 90.0) new_mem_y1)) ;point for new member on pole
(setq nem2 (polar polestarting (DTR 90.0) new_mem_y2)) ;referance point for new member on struct
(setq nem3 (polar nem2 (DTR 0.0) 10000))
(setq nem4 (inters structending structstarting nem2 nem3)) ;point for new member on struct
(if (= polejoints 0)(setq diameter diameter_1))
(if (= polejoints 1) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if (> new_mem_y1 joint_1) (setq diameter diameter_2))))
(if (= polejoints 2) (progn (if (< new_mem_y1 joint_1) (setq diameter diameter_1)) (if ( and (> new_mem_y1 joint_1) (< new_mem_y1 joint_2)) (setq diameter diameter_2)) (if (> new_mem_y1 joint_2) (setq diameter diameter_3))))

(if (= existingstud_membertype "A") 
(progn 
(setq ccin nem1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq aclampin nem4) 
(A_Clamp)
(setq pp2 angle_clamp_hole)
))
(if (= existingstud_membertype "P") 
(progn 
(setq ccin nem1) (setq pipedia diameter) 
(C-Clamp1)
(setq pp1 pole_clamp_hole) ;pipe clamp hole location
(setq ccin nem4) (setq pipedia structsize) 
(C-Clamp3)
(setq pp2 angle_clamp_hole)
))

(initget 1 "A P")
(setq nem_memtype (getkword "\nEnter the new member type <Angle/Pipe>::"))
(setq nem_memsize (getstring "\nEnter the new member size::"))
(setq memshoft nem_memsize)
(if (= nem_memtype "A") (angmember))
(if (= nem_memtype "P") (pipemember))
(setq index 0 )
)));opt2,opt2
);;end
(defun C-Clamp1() 
;place ccin and pipedia value pipckers in main program
(setq pipethk 3)

		(setq c1 (polar ccin (DTR 0.0) (+ (/ pipedia 2)7))			  
              c2 (polar c1 (DTR 90.0) 65)
			  c3 (polar c2 (DTR 180.0) (+ pipedia 14))
			  c4 (polar c3 (DTR 270.0) 130)
			  c5 (polar c4 (DTR 0.0) (+ pipedia 14))
			  
			  c6 (polar c1 (DTR 90.0) 50)
			  c7 (polar c6 (DTR 0.0) 100)
			  c8 (polar c7 (DTR 270.0) 100)
			  c9 (polar c8 (DTR 180.0) 100)
			  
			  c10 (polar c8 (DTR 90.0) 50)
			  c11 (polar c10 (DTR 180.0) 30) ;c11 for hole out point
		);setq
;(laygus)
;(command "line" c2 c3 c4 c5 c2  "" "line" c6 c7 c8 c9 c6 "")
;(command "_insert" "16c" c11 "" "" "")
(setq c12 (polar c2 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 )))
(setq c13 (polar c12 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c14 (polar c13 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c15 (polar c14 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))

(setq c16 (polar c5 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 )))
(setq c17 (polar c16 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c18 (polar c17 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c19 (polar c18 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
;(command "line" c12 c16 "" "line" c13 c17 "" "line" c14 c18 "" "line" c15 c19 "")
(setq c20 (polar c2 (DTR 270.0) 25)) 
(setq c21 (polar c20 (DTR 180.0) (+ pipethk 7))) ;line staet
(setq c22 (polar c21 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 ))) ;line end
(setq c23 (polar c5 (DTR 90.0) 25)) 
(setq c24 (polar c23 (DTR 180.0) (+ pipethk 7))) ;line start
(setq c25 (polar c24 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 ))) ;line end
;(command "line" c21 c22 "" "line" c24 c25 "")

(setq pole_clamp_hole c11)
;(if (= pipedia 48.3 ) (progn (setq cc1_d1 ) (setq cc1_d2 )))
(if (= pipedia 48.3 ) (progn (setq cc1_d1 75 ) (setq cc1_d2 189 ) (setq cc1_d3 "60.3 %%c") (setq R_cc1 "R24.2")))
(if (= pipedia 60.3 ) (progn (setq cc1_d1 92 ) (setq cc1_d2 206 ) (setq cc1_d3 "60.3 %%c") (setq R_cc1 "R30.2")))
(if (= pipedia 76.1 ) (progn (setq cc1_d1 116) (setq cc1_d2 230 ) (setq cc1_d3 "76.1 %%c") (setq R_cc1 "R38.1")))
(if (= pipedia 88.9 ) (progn (setq cc1_d1 136) (setq cc1_d2 250 ) (setq cc1_d3 "88.9 %%c") (setq R_cc1 "R44.45")))
(if (= pipedia 114.3 ) (progn (setq cc1_d1 176) (setq cc1_d2 290) (setq cc1_d3 "114.3 %%c") (setq R_cc1 "R57.15")))
(if (= pipedia 139.7 ) (progn (setq cc1_d1 216) (setq cc1_d2 330) (setq cc1_d3 "139.7 %%c") (setq R_cc1 "R70" )))
(if (= pipedia 168.1 ) (progn (setq cc1_d1 261) (setq cc1_d2 375) (setq cc1_d3 "168.1 %%c") (setq R_cc1 "R84.2")))
)
(defun C-Clamp3() 
;place ccin and pipedia value pipckers in main program
(setq ang (angle structstarting structending)) ;for 0
(setq shearedge 25)
(setq ang1 (+ ang (dtr 90.0)))   ; for 90
(setq ang2 (angle structending structstarting))    ; for 0 to 180
(setq ang3 (+ ang1 (dtr 180.0))) ;for 270

(setq ang4 (- (DTR 180.0) ang)) ;for point shifting length

(setq tempcal1 (+ (/ pipedia 2) 57))
(setq tempcal2 (abs (/ tempcal1 (sin ang4))))
(setq tempcal3 (sqrt (- (* tempcal2 tempcal2) (* tempcal1 tempcal1)))) ;shifting length
(setq pipethk 3)

		(setq c1t (polar ccin ang2 tempcal3)
			  c1 (polar c1t ang1 (+ (/ pipedia 2)7))			  
              c2 (polar c1 ang2 65)
			  c3 (polar c2 ang3 (+ pipedia 14))
			  c4 (polar c3 ang 130)
			  c5 (polar c4 ang1 (+ pipedia 14))
			  
			  c6t (polar c3 ang 65)
			  c6 (polar c6t ang2 50)
			  c7 (polar c6 ang3 100)
			  c8 (polar c7 ang 100)
			  c9 (polar c8 ang1 100)
			  
			  c10 (polar c8 ang2 50)
			  c11 (polar c10 ang1 50) ;c11 for hole out point
		);setq
;(laygus)
;(command "line" c2 c3 c4 c5 c2  "" "line" c6 c7 c8 c9 c6 "")
;(command "_insert" "16c" c11 "" "" "")

(setq c12 (polar c3 ang1 (+ (* (/ pipedia 7) 2) pipethk 7 )))
(setq c13 (polar c12 ang3 (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c14 (polar c13 ang3 (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c15 (polar c14 ang3 (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))

(setq c16 (polar c4 ang1 (+ (* (/ pipedia 7) 2) pipethk 7 )))
(setq c17 (polar c16 ang3 (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c18 (polar c17 ang3 (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c19 (polar c18 ang3 (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
;(command "line" c12 c16 "" "line" c13 c17 "" "line" c14 c18 "" "line" c15 c19 "")

(setq c20 (polar c3 ang 25)) 
(setq c21 (polar c20 ang1 (+ pipethk 7))) ;line staet
(setq c22 (polar c21 ang1 (+ (* (/ pipedia 7) 2) pipethk 7 ))) ;line end
(setq c23 (polar c4 ang2 25)) 
(setq c24 (polar c23 ang1 (+ pipethk 7))) ;line start
(setq c25 (polar c24 ang1 (+ (* (/ pipedia 7) 2) pipethk 7 ))) ;line end
;(command "line" c21 c22 "" "line" c24 c25 "")
(setq angle_clamp_hole c11)
;+++++++++++++++++++++++++++
;(if (= pipedia 48.3 ) (progn (setq cc1_d1 ) (setq cc1_d2 )))
(if (= pipedia 48.3 ) (progn (setq cc3_d1 75 ) (setq cc3_d2 189 ) (setq cc3_d3 "48.3 %%c") (setq R_cc3 "R24.2")))
(if (= pipedia 60.3 ) (progn (setq cc3_d1 92 ) (setq cc3_d2 206 ) (setq cc3_d3 "60.3 %%c") (setq R_cc3 "R30.2")))
(if (= pipedia 76.1 ) (progn (setq cc3_d1 116) (setq cc3_d2 230 ) (setq cc3_d3 "76.1 %%c") (setq R_cc3 "R38.1")))
(if (= pipedia 88.9 ) (progn (setq cc3_d1 136) (setq cc3_d2 250 ) (setq cc3_d3 "88.9 %%c") (setq R_cc3 "R44.45")))
(if (= pipedia 114.3 ) (progn (setq cc3_d1 176) (setq cc3_d2 290) (setq cc3_d3 "114.3 %%c") (setq R_cc3 "R57.15")))
(if (= pipedia 139.7 ) (progn (setq cc3_d1 216) (setq cc3_d2 330) (setq cc3_d3 "139.7 %%c") (setq R_cc3 "R70" )))
(if (= pipedia 168.1 ) (progn (setq cc3_d1 261) (setq cc3_d2 375) (setq cc3_d3 "168.1 %%c") (setq R_cc3 "R84.2")))
)
(defun C-Clamp2()
		(setq c1 (polar ccin (DTR 0.0) (+ (/ pipedia 2)7))			  
              c2 (polar c1 (DTR 90.0) 65)
			  c3 (polar c2 (DTR 180.0) (+ pipedia 14))
			  c4 (polar c3 (DTR 270.0) 130)
			  c5 (polar c4 (DTR 0.0) (+ pipedia 14))
			  
			  c6 (polar c1 (DTR 90.0) 50)
			  c7 (polar c6 (DTR 0.0) 150)
			  c8 (polar c7 (DTR 270.0) 100)
			  c9 (polar c8 (DTR 180.0) 150)
			  
			  c10 (polar c8 (DTR 90.0) 25)
			  c11 (polar c10 (DTR 180.0) 25) ;c11 for hole out point
		);setq
(setq pipethk 3)
;(command "line" c2 c3 c4 c5 c2  "" "line" c6 c7 c8 c9 c6 "")
;(command "_insert" "16c" c11 "" "" "")
(setq c12 (polar c2 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 )))
(setq c13 (polar c12 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c14 (polar c13 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c15 (polar c14 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))

(setq c16 (polar c5 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 )))
(setq c17 (polar c16 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c18 (polar c17 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
(setq c19 (polar c18 (DTR 0.0) (/ (+ (* (/ pipedia 7) 2) pipethk 7 ) 4)))
;(command "line" c12 c16 "" "line" c13 c17 "" "line" c14 c18 "" "line" c15 c19 "")
(setq c20 (polar c2 (DTR 270.0) 25)) 
(setq c21 (polar c20 (DTR 180.0) (+ pipethk 7))) ;line staet
(setq c22 (polar c21 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 ))) ;line end
(setq c23 (polar c5 (DTR 90.0) 25)) 
(setq c24 (polar c23 (DTR 180.0) (+ pipethk 7))) ;line start
(setq c25 (polar c24 (DTR 180.0) (+ (* (/ pipedia 7) 2) pipethk 7 ))) ;line end
;(command "line" c21 c22 "" "line" c24 c25 "")
;(if (= pipedia 48.3 ) (progn (setq cc3_d1 ) (setq cc1_d2 )))
(if (= pipedia 48.3 ) (progn (setq cc2_d1 75 ) (setq cc2_d2 189 ) (setq cc2_d3 "48.3 %%c") (setq R_cc3 "R24.2")))
(if (= pipedia 60.3 ) (progn (setq cc2_d1 92 ) (setq cc2_d2 206 ) (setq cc2_d3 "60.3 %%C" ) (setq R_cc2 "R30.2")))
(if (= pipedia 76.1 ) (progn (setq cc2_d1 116) (setq cc2_d2 230 ) (setq cc2_d3 "76.1 %%C") (setq R_cc2 "38.1")))
(if (= pipedia 88.9 ) (progn (setq cc2_d1 136) (setq cc2_d2 250 ) (setq cc2_d3 "88.9 %%C") (setq R_cc2 "R44.45" )))
(if (= pipedia 114.3 ) (progn (setq cc2_d1 176) (setq cc2_d2 290) (setq cc2_d3 "114.3 %%C") (setq R_cc2 "R57.15")))
(if (= pipedia 139.7 ) (progn (setq cc2_d1 216) (setq cc2_d2 330) (setq cc2_d3 "139.7 %%C") (setq R_cc2 "R70" )))
(if (= pipedia 168.1 ) (progn (setq cc2_d1 261) (setq cc2_d2 375) (setq cc2_d3 "168.1 %%C") (setq R_cc2 "R84.2")))
)
(defun GA-01_twobolts()
(setq GA-01_bplate_wth 230)
(setq GA-01_bplate_ht 230)
(setq GA-01_bplate_tk 10)

(setq GA-01_cleat_wth 150)
(setq GA-01_cleat_ht 150)
(setq GA-01_cleat_tk 10)

(setq ac1 (polar acin (DTR 180.0) (/ GA-01_bplate_wth 2)))
(setq ac2 (polar ac1 (DTR 90.0) GA-01_bplate_tk))
(setq ac3 (polar ac2 (DTR 0.0) GA-01_bplate_wth))
(setq ac4 (polar ac3 (DTR 270.0) GA-01_bplate_tk))

(setq ac5 (polar acin (DTR 90.0) GA-01_bplate_tk)) ;cleat face bottam mid point
(setq ac6 (polar ac5 (DTR 0.0) (/ GA-01_cleat_wth 2)))
(setq ac7 (polar ac6 (DTR 90.0) GA-01_cleat_ht))
(setq ac8 (polar ac7 (DTR 180.0) GA-01_cleat_wth))
(setq ac9 (polar ac8 (DTR 270.0) GA-01_cleat_ht))

(setq ac10 (polar ac8 (DTR 0.0) 25))
(setq ac11 (polar ac10 (DTR 270.0) 25)) ;bolt location
;(command "line" ac1 ac2 ac3 ac4 ac1 "" "line" ac6 ac7 ac8 ac9 ac6 "")
;(command "_insert" "16c" ac11 "" "" "")

(setq ac17 (polar ac7 (DTR 180.0) GA-01_cleat_tk)) ;cleat thick
(setq ac18 (polar ac6 (DTR 180.0) GA-01_cleat_tk)) ;cleat thick
;(command "line" ac17 ac18 "")
;=======================plate dimensions=========;
;(setq ac13 (polar ac11 (DTR 270.0) 100)) ;to find inters
;(setq ac14 (polar ac12 (DTR 180.0) 100)) ;to find inters
;(setq ac15 (inters ac11 ac13 ac14 ac12))
;(setq GA-01_cleat_x (distance ac12 ac15)) ;cleat x diasance for second hole location
;(setq GA-01_cleat_y (distance ac11 ac15)) ;cleat y diasance for second hole location
;(setq GA-01_cleat_x1 25)	
;(setq GA-01_cleat_y1 25)	
;(setq GA-01_cleat_x2 GA-01_cleat_x)	
;(setq GA-01_cleat_y2 GA-01_cleat_y)	
;(setq GA-01_cleat_x3 (- GA-01_cleat_wth (+ GA-01_cleat_x1 GA-01_cleat_x2)))	
;(setq GA-01_cleat_y3 (- GA-01_cleat_ht (+ GA-01_cleat_y1 GA-01_cleat_y2)))
;(setq anchoring_bolt ac12)	
)
(defun A_Clamp()
(setq ang (angle structstarting structending)) ;for 0
(setq shearedge 25)
(setq ang1 (+ ang (dtr 90)))   ; for 90
(setq ang2 (angle structending structstarting))    ; for 0 to 180
(setq ang3 (+ ang1 (dtr 180))) ;for 270
(setq ang4 (- (DTR 180.0) ang)) ;for point shifting length
(setq welding_length 55)
(setq memshoft (fix structsize))   
(if (= memshoft "405") (progn (setq flange 40) (setq bm 22) (setq th 5)))
(if (= memshoft "453") (progn (setq flange 45) (setq bm 23) (setq th 3)))
(if (= memshoft "454") (progn (setq flange 45) (setq bm 23) (setq th 4)))
(if (= memshoft "455") (progn (setq flange 45) (setq bm 23) (setq th 5)))
(if (= memshoft "503") (progn (setq flange 50) (setq bm 27) (setq th 3)))
(if (= memshoft "504") (progn (setq flange 50) (setq bm 27) (setq th 4)))
(if (= memshoft "505") (progn (setq flange 50) (setq bm 28) (setq th 5)))
(if (= memshoft "554") (progn (setq flange 55) (setq bm 31) (setq th 4)))
(if (= memshoft "555") (progn (setq flange 55) (setq bm 31) (setq th 5)))
(if (= memshoft "556") (progn (setq flange 55) (setq bm 31) (setq th 6)))
(if (= memshoft "604") (progn (setq flange 60) (setq bm 33) (setq th 4)))
(if (= memshoft "605") (progn (setq flange 60) (setq bm 33) (setq th 5)))
(if (= memshoft "606") (progn (setq flange 60) (setq bm 35) (setq th 6)))
(if (= memshoft "654") (progn (setq flange 65) (setq bm 36) (setq th 4)))
(if (= memshoft "655") (progn (setq flange 65) (setq bm 36) (setq th 5)))
(if (= memshoft "656") (progn (setq flange 65) (setq bm 36) (setq th 6)))
(if (= memshoft "705") (progn (setq flange 70) (setq bm 41) (setq th 5)))
(if (= memshoft "706") (progn (setq flange 70) (setq bm 41) (setq th 6)))
(if (= memshoft "755") (progn (setq flange 75) (setq bm 44) (setq th 5)))
(if (= memshoft "756") (progn (setq flange 75) (setq bm 44) (setq th 6)))
(if (= memshoft "806") (progn (setq flange 80) (setq bm 46) (setq th 6)))
(if (= memshoft "808") (progn (setq flange 80) (setq bm 46) (setq th 8)))
(if (= memshoft "906") (progn (setq flange 90) (setq bm 51) (setq th 6)))
(if (= memshoft "907") (progn (setq flange 90) (setq bm 51) (setq th 7)))
(if (= memshoft "908") (progn (setq flange 90) (setq bm 51) (setq th 8)))
(if (= memshoft "1006") (progn (setq flange 100) (setq bm 56) (setq th 6)))
(if (= memshoft "1007") (progn (setq flange 100) (setq bm 56) (setq th 7)))
(if (= memshoft "1008") (progn (setq flange 100) (setq bm 56) (setq th 8)))
(if (= memshoft "10010") (progn (setq flange 100) (setq bm 58) (setq th 10)))
(if (= memshoft "1108") (progn (setq flange 110) (setq bm 61) (setq th 8)))
(if (= memshoft "11010") (progn (setq flange 110) (setq bm 61) (setq th 10)))
(if (= memshoft "1208") (progn (setq flange 120) (setq bm 70) (setq th 8)))
(if (= memshoft "12010") (progn (setq flange 120) (setq bm 70) (setq th 10)))
(if (= memshoft "13010") (progn (setq flange 130) (setq bm 78) (setq th 10)))
(if (= memshoft "13012") (progn (setq flange 130) (setq bm 78) (setq th 12)))
(if (= memshoft "15012") (progn (setq flange 150) (setq bm 88) (setq th 12)))	
(if ( and (> memshoft "450") (< memshoft "509")) 
(progn 
(setq aclamp_cleat_width 75) (setq aclamp_cleat_length 60) (setq aclamp_cleat_bk 54) (setq aclamp_cleat_thk 5)
(setq aclamp_plate1_width 146) (setq aclamp_plate1_length 60) (setq aclamp_plate1_thk 6) 
(setq aclamp_plate2_width 85) (setq aclamp_plate2_length 60) (setq aclamp_plate2_thk 6)))
(if ( and (> memshoft "550") (< memshoft "609")) 
(progn (setq aclamp_cleat_width 90) (setq aclamp_cleat_length 60) (setq aclamp_cleat_bk 64) (setq aclamp_cleat_thk 5)
(setq aclamp_plate1_width 156) (setq aclamp_plate1_length 60) (setq aclamp_plate1_thk 6) 
(setq aclamp_plate2_width 95) (setq aclamp_plate2_length 60) (setq aclamp_plate2_thk 6)))
(if ( and (> memshoft "650") (< memshoft "759")) 
(progn (setq aclamp_cleat_width 100) (setq aclamp_cleat_length 60) (setq aclamp_cleat_bk 79) (setq aclamp_cleat_thk 6)
(setq aclamp_plate1_width 171) (setq aclamp_plate1_length 60) (setq aclamp_plate1_thk 6) 
(setq aclamp_plate2_width 110) (setq aclamp_plate2_length 60) (setq aclamp_plate2_thk 6)))
(if ( and (> memshoft "800") (< memshoft "910")) 
(progn (setq aclamp_cleat_width 130) (setq aclamp_cleat_length 60) (setq aclamp_cleat_bk 93) (setq aclamp_cleat_thk 10)
(setq aclamp_plate1_width 186) (setq aclamp_plate1_length 60) (setq aclamp_plate1_thk 6) 
(setq aclamp_plate2_width 125) (setq aclamp_plate2_length 60) (setq aclamp_plate2_thk 6)))
(if ( and (> memshoft "1004") (< memshoft "10010")) 
(progn (setq aclamp_cleat_width 130) (setq aclamp_cleat_length 60) (setq aclamp_cleat_bk 99) (setq aclamp_cleat_thk 10)
(setq aclamp_plate1_width 196) (setq aclamp_plate1_length 60) (setq aclamp_plate1_thk 6) 
(setq aclamp_plate2_width 135) (setq aclamp_plate2_length 60) (setq aclamp_plate2_thk 6)))
(setq temp1 (- aclamp_plate1_width shearedge (+ aclamp_plate2_thk welding_length)))
(setq tempcal1 (- temp1 bm))
(setq tempcal2 (abs (/ tempcal1 (sin ang4))))
(setq tempcal3 (sqrt (- (* tempcal2 tempcal2) (* tempcal1 tempcal1)))) ;shifting length
(setq pp50t (polar aclampin ang2 tempcal3))
(setq pp50 (polar pp50t ang1 bm))
(setq pp51 (polar pp50 ang3 (- aclamp_plate1_width (+ aclamp_plate2_thk welding_length))))
(setq pp52 (polar pp51 ang2 (/ aclamp_plate1_length 2)))
(setq pp53 (polar pp52 ang1 1)) 
(setq pp54 (polar pp52 ang1 aclamp_plate1_width))
(setq pp55 (polar pp54 ang aclamp_plate1_length))
(setq pp56 (polar pp55 ang3 aclamp_plate1_width))
(setq pp57 (polar pp56 ang3 1))
(setq pp58 (polar pp54 ang3 (+ aclamp_plate2_thk welding_length th 1)))
(setq pp59 (polar pp55 ang3 (+ aclamp_plate2_thk welding_length th 1)))
(setq pp60 (polar pp59 ang3 aclamp_cleat_thk))
(setq pp61 (polar pp58 ang3 aclamp_cleat_thk))
(setq pp62 (polar pp50 ang2 (/ aclamp_cleat_length 2)))
(setq pp63 (polar pp62 ang1 aclamp_plate2_thk))
(setq pp64 (polar pp63 ang aclamp_plate2_length))
(setq pp65 (polar pp64 ang3 aclamp_plate2_thk))
(setq pp66 (polar pp51 ang1 (+ aclamp_plate1_width 1))) ;center line
(setq pp67 (polar pp52 ang1 shearedge)) ;bottam center line left
(setq pp68 (polar pp57 ang1 shearedge)) ;bottam center line right
(setq pp69 (polar pp54 ang3 shearedge)) ;top center line left
(setq pp70 (polar pp55 ang3 shearedge)) ;top center line right
(setq pp71 (inters pp51 pp66 pp69 pp70)) ;heel side hole location
(setq pp72 (inters pp51 pp66 pp67 pp68)) ;other side hole location
;(command "line" pp52 pp54 pp55 pp57 pp52 "" "line" pp53 pp56 "" "line" pp58 pp59 "" "line" pp60 pp61 "")
;(command "PLINE" pp62 "W" "0" "" pp62 pp63 pp64 pp65 pp62 "" )
;(command "line" pp51 pp66 "" "line" pp67 pp68 "" "line" pp69 pp70 "")
;(command "_insert" "16c" pp71 "" "" "") 
;(command "_insert" "16c" pp72 "" "" "") 
(setq angle_clamp_hole pp72)
)
(defun Number_Round (ImpVal To_Val) ;to round off the value
  (setq To_Val (abs To_Val))
  (*
    To_Val
    (fix
      (/
        (
          (if (minusp ImpVal)
            -
            +
          )
          ImpVal
          (* To_Val 0.5)
        )
        To_Val
      )
    )
  )
)
(defun hip_eqfaces()
(defun rtd(x) (* (/ 180 pi) x))
(defun dtr(x) (* (/ pi 180.0) x))
(defun asin (z /) (atan z (sqrt (- 1.0 (* z z)))))
(setq hip_mem (getreal "Enter the number of hip/plan members <0/1/2>:: "))

(if (= hip_mem 1) (progn
(setq hip_mem1_hight (getreal "Enter the hip member vertical hight::"))
(initget 1 "A P")
(setq hip_mem1_type (getreal "Enter the type of new hip member<A/P>:"))
(setq hip_mem1_size (getstring "Enter the new hip member size:"))
(setq st1_angle1 (- 180 (rtd (angle structending structstarting ))))
(setq st1_angle2 (- 180 (+ st1_angle1 90)))
(setq a1 (/ hip_mem1_hight (sin (dtr st1_angle1))))
(setq b1 (/ (* hip_mem1_hight (sin (dtr st1_angle2))) (sin (dtr st1_angle1))))
(setq x1 (- (+ exst1_x (- (* (/ (sin (dtr st1_angle2)) (sin (dtr st1_angle1)) ) 135) 50)) (- b1 (/ bm (sin (dtr st1_angle1))))))
(setq z (sqrt (- (+ (* x1 x1) (* x1 x1)) (* 2 x1 x1 (cos (dtr twost_ang))))))
(setq hip_plan_ang1 (rtd (asin (/ (* x1 (sin (dtr twost_ang))) z))))
(setq hip_plan_ang2 (- 180 (+ hip_plan_ang1 (dtr twost_ang))))
(setq memshoft hip_mem1_size)
(if (= exst1_ty "A") (progn (setq hip_memlen1 (Number_Round (- z (* (+ (* (+ structsize 10) 0.707) 40) 2) ) 1)) (angmember) ))
(if (= exst1_ty "P") (progn (setq hip_memlen1 (Number_Round (- z (* (+ (/ structsize 2) 75) 2)) 1)) (pipemember) ))
))

(if (= hip_mem 2) (progn
(setq hip_mem1_hight (getreal "Enter the first hip member vertical hight::"))
(initget 1 "A P")
(setq hip_mem1_type (getreal "Enter the first hip member type<A/P>::"))
(setq hip_mem1_size (getstring "Enter the first hip member size::"))

(setq st1_angle1 (- 180 (rtd (angle structending structstarting ))))
(setq st1_angle2 (- 180 (+ st1_angle1 90)))
(setq a1 (/ hip_mem1_hight (sin (dtr st1_angle1))))
(setq b1 (/ (* hip_mem1_hight (sin (dtr st1_angle2))) (sin (dtr st1_angle1))))
(setq x1 (- (+ exst1_x (- (* (/ (sin (dtr st1_angle2)) (sin (dtr st1_angle1)) ) 135) 50)) (- b1 (/ bm (sin (dtr st1_angle1))))))
(setq z (sqrt (- (+ (* x1 x1) (* x1 x1)) (* 2 x1 x1 (cos (dtr twost_ang))))))
(setq hip_plan_ang1 (rtd (asin (/ (* x1 (sin (dtr twost_ang))) z))))
(setq hip_plan_ang2 (- 180 (+ hip_plan_ang1 (dtr twost_ang))))
(setq memshoft hip_mem1_size)
(if (= exst1_ty "A") (progn (setq hip_memlen1 (Number_Round (- z (* (+ (* (+ structsize 10) 0.707) 40) 2) ) 1))))
(if (= exst1_ty "P") (progn (setq hip_memlen1 (Number_Round (- z (* (+ (/ structsize 2) 75) 2)) 1))))

(setq hip_mem2_hight (getreal "Enter the secound hip member vertical hight::"))
(initget 1 "A P")
(setq hip_mem2_type (getreal "Enter the secound hip member type</A/P>::"))
(setq hip_mem2_size (getstring "Enter the secound hip member size::"))

(setq st1_angle1 (- 180 (rtd (angle structending  structstarting))))
(setq st1_angle2 (- 180 (+ st1_angle1 90)))
(setq a1 (/ hip_mem2_hight (sin (dtr st1_angle1))))
(setq b1 (/ (* hip_mem2_hight (sin (dtr st1_angle2))) (sin (dtr st1_angle1))))
(setq x1 (- (+ exst1_x (- (* (/ (sin (dtr st1_angle2)) (sin (dtr st1_angle1)) ) 135) 50)) (- b1 (/ bm (sin (dtr st1_angle1))))))
(setq z (sqrt (- (+ (* x1 x1) (* x1 x1)) (* 2 x1 x1 (cos (dtr twost_ang))))))
(setq hip_plan_ang1 (rtd (asin (/ (* x1 (sin (dtr twost_ang))) z))))
(setq hip_plan_ang2 (- 180 (+ hip_plan_ang1 (dtr twost_ang))))
(setq memshoft hip_mem2_size)
(if (= exst1_ty "A") (progn (setq hip_memlen2 (Number_Round (- z (* (+ (* (+ structsize 10) 0.707) 40) 2) ) 1)) (angmember) ))
(if (= exst1_ty "P") (progn (setq hip_memlen2 (Number_Round (- z (* (+ (/ structsize 2) 75) 2)) 1)) (pipemember) ))
))
)
(defun hip_twoDfaces()
(defun rtd(x) (* (/ 180 pi) x))
(defun dtr(x) (* (/ pi 180.0) x))
(defun asin (z /) (atan z (sqrt (- 1.0 (* z z)))))

(setq face1_hip f1)
(setq face2_hip f2)
(setq hip_mem1_hight h)
(setq angle_b_structs angle)
(setq st1_angle1 (abs (- 180 (rtd (angle structstarting1 structending1 )))))
(setq st1_angle2 (abs (- 180 (+ st1_angle1 90))))
(setq st2_angle1 (abs (- 180 (rtd (angle structstarting2 structending2 )))))
(setq st2_angle2 (abs (- 180 (+ st2_angle1 90))))
(setq a1 (/ h (sin (dtr st1_angle1))))
(setq b1 (/ (* h (sin (dtr st1_angle2))) (sin (dtr st1_angle1))))
(setq x1 (- face1_hip b1))
(setq a2 (/ h (sin (dtr st2_angle1))))
(setq b2 (/ (* h (sin (dtr st2_angle2))) (sin (dtr st2_angle1))))
(setq x2 (- face2_hip b2))
(setq z (sqrt (- (+ (* x1 x1) (* x2 x2)) (* 2 x1 x2 (cos (dtr angle_b_structs))))))
(setq hip_plan_ang1 (asin (/ (* x1 (sin (dtr angle_b_structs))) z)))
(setq hip_plan_ang2 (- 180 (+ hip_plan_ang1 (dtr angle_b_structs))))
(if (= structty "A") (progn (setq memlen1 (+ (* (+ structsize1 10) 0.707) 40)) (setq memlen2 (+ (* (+ structsize2 10) 0.707) 40)) (setq memlen (+ memlen1 memlen2) ) ))
(if (= structty "P") (progn (setq memlen (- z (* (+ (/ structsize 2) 45) 2)))))

)
(if (= venkii nil) (progn
(command "layer" "m" "mem" "c" "4" "" "")
(command "layer" "m" "des" "c" "1" "" "")
(command "layer" "m" "gus" "c" "3" "" "")
(command "layer" "m" "con" "c" "1" "" "")
(command "layer" "m" "dim" "c" "5" "" "")
(command "layer" "m" "len" "c" "2" "" "")
(command "layer" "m" "int" "c" "7" "" "")
(command "layer" "m" "bolt" "c" "6" "" "")
(command "layer" "m" "bdes" "c" "6" "" "")
(command "layer" "m" "das" "c" "1" "" "lt" "dashed" "" "")
(command "layer" "m" "hid" "c" "1" "" "lt" "hidden" "" "")
(command "layer" "m" "cen" "c" "2" "" "lt" "center" "" "")
(command "layer" "s" "0" "")
(defun c:mem  () (command "change" pause "" "p" "la" "mem" "lt" "bylayer" "c" "bylayer" ""))
(defun c:das  () (command "change" pause "" "p" "la" "das" "lt" "bylayer" "c" "bylayer" ""))
(defun c:cen  () (command "change" pause "" "p" "la" "cen" "lt" "bylayer" "c" "bylayer" ""))
(defun c:des  () (command "change" pause "" "p" "la" "des" "lt" "bylayer" "c" "bylayer" ""))
(defun c:gus  () (command "change" pause "" "p" "la" "gus" "lt" "bylayer" "c" "bylayer" ""))
(defun c:con  () (command "change" pause "" "p" "la" "con" "lt" "bylayer" "c" "bylayer" ""))
(defun c:de   () (command "change" pause "" "p" "la" "dim" "lt" "bylayer" "c" "bylayer" ""))
(defun c:bot  () (command "change" pause "" "p" "la" "bolt" "lt" "bylayer" "c" "bylayer" ""))
(defun c:FAB  () (command "change" pause "" "p" "la" "FAB" "lt" "bylayer" "c" "bylayer" "")) ;yellow continus
(defun c:hid  () (command "change" pause "" "p" "la" "das" "lt" "hidden" "" )) ;hidden
(defun c:bl   () (command "change" pause "" "p" "la" "das" "lt" "dashdot" "" ))
(defun c:bdes () (command "change" pause "" "p" "la" "bdes" "lt" "bylayer" "" )) ;majentha continus

(defun mem() (command "change" pause "" "p" "la" "mem" "lt" "bylayer" "c" "bylayer" ""))
(defun das() (command "change" pause "" "p" "la" "das" "lt" "bylayer" "c" "bylayer" ""))
(defun cen() (command "change" pause "" "p" "la" "cen" "lt" "bylayer" "c" "bylayer" ""))
(defun des() (command "change" pause "" "p" "la" "des" "lt" "bylayer" "c" "bylayer" ""))
(defun gus() (command "change" pause "" "p" "la" "gus" "lt" "bylayer" "c" "bylayer" ""))
(defun con() (command "change" pause "" "p" "la" "con" "lt" "bylayer" "c" "bylayer" ""))
(defun de() (command "change" pause "" "p" "la" "dim" "lt" "bylayer" "c" "bylayer" ""))
(defun bot() (command "change" pause "" "p" "la" "bolt" "lt" "bylayer" "c" "bylayer" ""))
(defun FAB() (command "change" pause "" "p" "la" "FAB" "lt" "bylayer" "c" "bylayer" "")) ;yellow continus
(defun hid() (command "change" pause "" "p" "la" "das" "lt" "hidden" "" )) ;hidden
(defun bl() (command "change" pause "" "p" "la" "das" "lt" "dashdot" "" ))
(defun bdes() (command "change" pause "" "p" "la" "bdes" "lt" "bylayer" "" )) ;majentha continus
(setq sf 15)
(command "dimscale" sf)
(command "style" "arial" "arial" (* 4.0 sf) "" "" "" "")
(command "style" "standard" "simplex" (* 2.0 sf) "0.8" "" "" "" "")
(command "style" "SHX_style" "simplex" (* 2.5 sf) "0.8" "" "" "" "")

(command "ltscale" (* 5.0 sf))
(command "dimasz" 2.5)
(command "dimtsz" 0.5)
(command "dimtxt" 2.5)
(command "dimexe" 1)
(command "dimexo" 1)
(command "dimlwd" 9)
(command "dimlwe" 9)
(command "dimgap" 1)
(command "dimtad" 1)
(command "dimtofl" 1)
(command "dimtih" 0)
(command "dimtoh" 0)
(command "dimlwd" 9) 
(command "dimlwe" 9)

(command "_insert" "c:/detail/blocks/ALBABTAIN BLOCKS/15SCALEBLOCKS" "@" "" "" "")
;(command "_insert" "c:/detail/blocks/poleblocks" "@" "" "" "" )
(command "_insert" "c:/detail/POLEDATA" "@" "" "" "" )
;(defun c:newp() (setq IP nil) (setq ibp nil))
(setq venkii "1")
))
(defun spd_drawings()
(setq bha 123)
(if (= designtype "SPD") (progn
	(if (or (= design_name "IN-6.0M-RIT-120-CNTR-MP") (= design_name "IN-6.0m-RIT-120-CNTR-MP") (= design_name "In-6.0m-rit-120-cntr-mp")) 
	(progn
		(if (and (= newstudnum 1) (= newstud1_memty "P") (= newst_mem_onpole 0) (= newst_mem_onstruct 0) (= hip_mem 0) ) (progn 			
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL1" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 1178.66))  (setq dm1 (polar dm1t (DTR 90.0) 2079.96))  ;b1
				(setq dm2t (polar ibp (DTR 0.0) 1103.43))  (setq dm2 (polar dm2t (DTR 90.0) 4891.84))  ;b2
				(setq dm3t (polar ibp (DTR 0.0) 1178.66))  (setq dm3 (polar dm3t (DTR 90.0) 5829.96))  ;b3
				(setq dm4t (polar ibp (DTR 0.0) 1859.45))  (setq dm4 (polar dm4t (DTR 90.0) 1877.72))  ;b4
				(setq dm5t (polar ibp (DTR 0.0) 2978.2))  (setq dm5 (polar dm5t (DTR 90.0) 1877.72))  ;b5
				(setq dm6t (polar ibp (DTR 0.0) 3342.48))  (setq dm6 (polar dm6t (DTR 90.0) 2000.29))  ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2148.84))  (setq dm7 (polar dm7t (DTR 90.0) 1508.42))  ;b7
				(setq dm8t (polar ibp (DTR 0.0) 3903.34))  (setq dm8 (polar dm8t (DTR 90.0) 989.86))  ;b8
				(setq dm9t (polar ibp (DTR 0.0) 4653.34))  (setq dm9 (polar dm9t (DTR 90.0) 988.36))  ;b9
				(setq dm10t (polar ibp (DTR 0.0) 6510.54))  (setq dm10 (polar dm10t (DTR 90.0) 6140))  ;b10
				(setq dm11t (polar ibp (DTR 0.0) 5289.27))  (setq dm11 (polar dm11t (DTR 90.0) 6023.39))  ;b11
				(setq dm12t (polar ibp (DTR 0.0) 5372.67))  (setq dm12 (polar dm12t (DTR 90.0) 6023.39))  ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5461.06))  (setq dm13 (polar dm13t (DTR 90.0) 6023.39))  ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5289.72))  (setq dm14 (polar dm14t (DTR 90.0) 5948.39))  ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5289.27))  (setq dm15 (polar dm15t (DTR 90.0) 5880.29))  ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5425.92))  (setq dm16 (polar dm16t (DTR 90.0) 4223.29))  ;b16
				(setq dm17t (polar ibp (DTR 0.0) 4941.95))  (setq dm17 (polar dm17t (DTR 90.0) 4126.69))  ;b17
				(setq dm18t (polar ibp (DTR 0.0) 5909.89))  (setq dm18 (polar dm18t (DTR 90.0) 4126.69))  ;b18
				(setq dm19t (polar ibp (DTR 0.0) 5026.74))  (setq dm19 (polar dm19t (DTR 90.0) 3814.82))  ;b19
				(setq dm20t (polar ibp (DTR 0.0) 5128.21))  (setq dm20 (polar dm20t (DTR 90.0) 2702.22))  ;b20
				(setq dm21t (polar ibp (DTR 0.0) 7901.03))  (setq dm21 (polar dm21t (DTR 90.0) 2717.21))  ;b21
				(setq dm22t (polar ibp (DTR 0.0) 8013.51))  (setq dm22 (polar dm22t (DTR 90.0) 2717.21))  ;b22
				(setq dm23t (polar ibp (DTR 0.0) 8148.23))  (setq dm23 (polar dm23t (DTR 90.0) 2717.49))  ;b23
				(setq dm24t (polar ibp (DTR 0.0) 7818.23))  (setq dm24 (polar dm24t (DTR 90.0) 2634.69))  ;b24
				(setq dm25t (polar ibp (DTR 0.0) 7818.23))  (setq dm25 (polar dm25t (DTR 90.0) 2522.21))  ;b25
				(setq dm26t (polar ibp (DTR 0.0) 7818.23))  (setq dm26 (polar dm26t (DTR 90.0) 2372.21))  ;b26
				(setq dm27t (polar ibp (DTR 0.0) 8750))  (setq dm27 (polar dm27t (DTR 90.0) 6140))  ;b27

				(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 190) (fix newstud1_y1))
				(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 190) (fix (- joint_0 newstud1_y1)))
				(command "dim1" "hor" dm4 dm5 (polar dm4 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm8 dm9 (polar dm8 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm6 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm7 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm10 "" "" "" )				

				(command "dim1" "hor" dm11 dm12 (polar dm12 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm12 dm13 (polar dm12 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm11 dm14 (polar dm14 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm14 dm15 (polar dm14 (DTR 180.0) 47) newstud1_platey1)
								
				(if (= newst1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_2BOLTS" dm20 "" "" "" )))
				(if (= newst1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_60.3_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_2BOLTS" dm20 "" "" "" )))
				(if (= newst1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_76.1_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_2BOLTS" dm20 "" "" "" )))
				(if (= newst1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_88.9_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_2BOLTS" dm20 "" "" "" )))
				(if (= newst1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_101.6_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_2BOLTS" dm20 "" "" "" )))
				(if (= newst1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_114.3_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_2BOLTS" dm20 "" "" "" )))
				(if (= newst1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_139.7_1" dm16 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_2BOLTS" dm20 "" "" "" )))
	
				(command "dim1" "hor" dm17 dm18 (polar dm17 (DTR 270.0) 181) (Number_Round (- newstud1_memlen (+ newst1_sizename2 35) (+ newst1_sizename2 35) 80) 1))
				(command "_insert" "f3x" dm19 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm21 dm22 (polar dm22 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm22 dm23 (polar dm22 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm24 dm25 (polar dm25 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm25 dm26 (polar dm25 (DTR 180.0) 79) (+ newstud1_platey2 50))
				;BOM
				(setq ibom dm27)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 21.55))
				(setq total_weight (+ total_mem_weight 3.2))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL1_bom" ibom "" "" "" )
				(setq bom1t (polar ibom (DTR 180.0) 1609.7))  (setq bom1 (polar bom1t (DTR 270.0) 469.67))  ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1249.11))  (setq bom2 (polar bom2t (DTR 270.0) 469.67))  ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 858.41))  (setq bom3 (polar bom3t (DTR 270.0) 472.1))  ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 511.74))  (setq bom4 (polar bom4t (DTR 270.0) 472.1))  ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 888.35))  (setq bom5 (polar bom5t (DTR 270.0) 530.96))  ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 541.68))  (setq bom6 (polar bom6t (DTR 270.0) 530.96))  ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 899.71))  (setq bom7 (polar bom7t (DTR 270.0) 1117.95))  ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 553.04))  (setq bom8 (polar bom8t (DTR 270.0) 1117.95))  ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 899.71))  (setq bom9 (polar bom9t (DTR 270.0) 1245.41))  ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 553.04))  (setq bom10 (polar bom10t (DTR 270.0) 1245.41))  ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 674.44))  (setq bom11 (polar bom11t (DTR 270.0) 1303.22))  ;aa11
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				(command "TEXT" bom11 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom5 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom6 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom7 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom8 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom9 "0" (rtos total_weight 2 2))
				(command "TEXT" bom10 "0" (rtos (* total_weight 1.035) 2 2))
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)
		))		
		
		(if (and (= newstudnum 1) (= newstud1_memty "P") (= newst_mem_onpole 1) (= newst_mem_onstruct 1) (= newst1_newmem1_type "P") (= (fix hip_mem) 0)) (progn
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/bolckss/IN-6.0M-RIT-120-CNTR-MP_P_SOL2" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 772.69))  (setq dm1 (polar dm1t (DTR 90.0) 2079.96))  ;b1
				(setq dm2t (polar ibp (DTR 0.0) 772.69))  (setq dm2 (polar dm2t (DTR 90.0) 3476.47))  ;b2
				(setq dm3t (polar ibp (DTR 0.0) 750.06))  (setq dm3 (polar dm3t (DTR 90.0) 4891.84))  ;b3
				(setq dm4t (polar ibp (DTR 0.0) 825.3))  (setq dm4 (polar dm4t (DTR 90.0) 5829.96))  ;b4
				(setq dm5t (polar ibp (DTR 0.0) 1506.08))  (setq dm5 (polar dm5t (DTR 90.0) 1877.72))  ;b5
				(setq dm6t (polar ibp (DTR 0.0) 2631.08))  (setq dm6 (polar dm6t (DTR 90.0) 1877.72))  ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2989.11))  (setq dm7 (polar dm7t (DTR 90.0) 1991.85))  ;b7
				(setq dm8t (polar ibp (DTR 0.0) 3088.76))  (setq dm8 (polar dm8t (DTR 90.0) 923.03))  ;b8
				(setq dm9t (polar ibp (DTR 0.0) 3839.4))  (setq dm9 (polar dm9t (DTR 90.0) 921.81))  ;b9
				(setq dm10t (polar ibp (DTR 0.0) 6525.48))  (setq dm10 (polar dm10t (DTR 90.0) 6150))  ;b10
				(setq dm11t (polar ibp (DTR 0.0) 6525.48))  (setq dm11 (polar dm11t (DTR 90.0) 4565.77))  ;b11
				(setq dm12t (polar ibp (DTR 0.0) 5304.21))  (setq dm12 (polar dm12t (DTR 90.0) 6033.39))  ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5387.61))  (setq dm13 (polar dm13t (DTR 90.0) 6026.48))  ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5476))  (setq dm14 (polar dm14t (DTR 90.0) 6033.39))  ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5304.66))  (setq dm15 (polar dm15t (DTR 90.0) 5958.39))  ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5304.21))  (setq dm16 (polar dm16t (DTR 90.0) 5890.29))  ;b16
				(setq dm17t (polar ibp (DTR 0.0) 5467.83))  (setq dm17 (polar dm17t (DTR 90.0) 2720.12))  ;b17
				(setq dm18t (polar ibp (DTR 0.0) 4983.86))  (setq dm18 (polar dm18t (DTR 90.0) 2623.52))  ;b18
				(setq dm19t (polar ibp (DTR 0.0) 5564.59))  (setq dm19 (polar dm19t (DTR 90.0) 2623.51))  ;b19
				(setq dm20t (polar ibp (DTR 0.0) 5951.8))  (setq dm20 (polar dm20t (DTR 90.0) 2623.52))  ;b20
				(setq dm21t (polar ibp (DTR 0.0) 5068.65))  (setq dm21 (polar dm21t (DTR 90.0) 2304.19))  ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5167.15))  (setq dm22 (polar dm22t (DTR 90.0) 2055.09))  ;b22
				(setq dm23t (polar ibp (DTR 0.0) 4821.81))  (setq dm23 (polar dm23t (DTR 90.0) 1958.49))  ;b23
				(setq dm24t (polar ibp (DTR 0.0) 5512.49))  (setq dm24 (polar dm24t (DTR 90.0) 1958.49))  ;b24
				(setq dm25t (polar ibp (DTR 0.0) 4777.97))  (setq dm25 (polar dm25t (DTR 90.0) 1646.62))  ;b25
				(setq dm26t (polar ibp (DTR 0.0) 6261.01))  (setq dm26 (polar dm26t (DTR 90.0) 2073.33))  ;b26
				(setq dm27t (polar ibp (DTR 0.0) 6337.53))  (setq dm27 (polar dm27t (DTR 90.0) 2073.33))  ;b27
				(setq dm28t (polar ibp (DTR 0.0) 6000.95))  (setq dm28 (polar dm28t (DTR 90.0) 1873.33))  ;b28
				(setq dm29t (polar ibp (DTR 0.0) 6337.53))  (setq dm29 (polar dm29t (DTR 90.0) 1873.33))  ;b29
				(setq dm30t (polar ibp (DTR 0.0) 5895.65))  (setq dm30 (polar dm30t (DTR 90.0) 1651.39))  ;b30
				(setq dm31t (polar ibp (DTR 0.0) 4575.84))  (setq dm31 (polar dm31t (DTR 90.0) 471.79))  ;b31
				(setq dm32t (polar ibp (DTR 0.0) 5585.57))  (setq dm32 (polar dm32t (DTR 90.0) 459.35))  ;b32
				(setq dm33t (polar ibp (DTR 0.0) 7911.03))  (setq dm33 (polar dm33t (DTR 90.0) 2527.33))  ;b33
				(setq dm34t (polar ibp (DTR 0.0) 8023.51))  (setq dm34 (polar dm34t (DTR 90.0) 2527.33))  ;b34
				(setq dm35t (polar ibp (DTR 0.0) 8158.23))  (setq dm35 (polar dm35t (DTR 90.0) 2527.62))  ;b35
				(setq dm36t (polar ibp (DTR 0.0) 7828.23))  (setq dm36 (polar dm36t (DTR 90.0) 2444.82))  ;b36
				(setq dm37t (polar ibp (DTR 0.0) 7828.23))  (setq dm37 (polar dm37t (DTR 90.0) 2332.33))  ;b37
				(setq dm38t (polar ibp (DTR 0.0) 7828.23))  (setq dm38 (polar dm38t (DTR 90.0) 2182.33))  ;b38
				(setq dm39t (polar ibp (DTR 0.0) 8756.64))  (setq dm39 (polar dm39t (DTR 90.0) 6150))  ;b39
				(setq dm40t (polar ibp (DTR 0.0) 2018))  (setq dm40 (polar dm40t (DTR 90.0) 1508.42))  ;b40
								
				(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 190) (fix newst1_newmem1_y1))
				(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 190) (fix (- newstud1_y1 newst1_newmem1_y1)))
				(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 190) (fix (- joint_0 newstud1_y1)))
				(command "dim1" "hor" dm5 dm6 (polar dm5 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm8 dm9 (polar dm8 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm7 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm40 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm10 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm11 "" "" "" )				

				(command "dim1" "hor" dm12 dm13 (polar dm13 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm13 dm14 (polar dm13 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm12 dm15 (polar dm15 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm15 dm16 (polar dm15 (DTR 180.0) 47) newstud1_platey1)
								
				(if (= newst1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_2BOLTS" dm31 "" "" "" )))
				(if (= newst1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_60.3_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_2BOLTS" dm31 "" "" "" )))
				(if (= newst1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_76.1_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_2BOLTS" dm31 "" "" "" )))
				(if (= newst1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_88.9_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_2BOLTS" dm31 "" "" "" )))
				(if (= newst1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_101.6_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_2BOLTS" dm31 "" "" "" )))
				(if (= newst1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_114.3_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_2BOLTS" dm31 "" "" "" )))
				(if (= newst1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_139.7_2" dm17 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_2BOLTS" dm31 "" "" "" )))
	
				(if (= newst1_newmem1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm32 "" "" "" )))
				(if (= newst1_newmem1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm32 "" "" "" )))
				(if (= newst1_newmem1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm32 "" "" "" )))
				(if (= newst1_newmem1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm32 "" "" "" )))
				(if (= newst1_newmem1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm32 "" "" "" )))
				(if (= newst1_newmem1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm32 "" "" "" )))
				(if (= newst1_newmem1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm22 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm32 "" "" "" )))
				
				(command "dim1" "hor" dm18 dm19 (polar dm19 (DTR 270.0) 181) (- newst1_joint2 (+ newst1_sizename2 35) 40))
				(command "dim1" "hor" dm19 dm20 (polar dm19 (DTR 270.0) 181) (- newst1_joint1 (+ newst1_sizename2 35) 40))
				(command "_insert" "f3x" dm21 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm23 dm24 (polar dm23 (DTR 270.0) 181) (Number_Round (- newst1_newmem1_len (+ newst1_newmem1_sizename2 35) (+ newst1_newmem1_sizename2 35)) 1))
				(command "_insert" "f3x" dm25 "0.0394" "0.0394" "" "N4" (strcat newstud1_memname ".." (itoa (Number_Round (+ newst1_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm26 dm27 (polar dm27 (DTR 90.0) 71) newst1_newmem1_stx2)
				(command "dim1" "hor" dm28 dm29 (polar dm28 (DTR 270.0) 90) (Number_Round newst1_newmem1_stx1 1))
				(command "_insert" "f3x" dm30 "0.0394" "0.0394" "" "N5" (strcat "PLT" (itoa (fix clampstk)) "x50.." (itoa (Number_Round newst1_newmem1_stx1 1)) " Lg"))
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm33 dm34 (polar dm34 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm34 dm35 (polar dm34 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm36 dm37 (polar dm37 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm37 dm38 (polar dm37 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm39)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N5 (* (/ clampstk 1000.0 )(/ 50 1000.0) (/ (Number_Round newst1_newmem1_stx1 1) 1000.0) 7850.0 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 27.43))
				(setq total_weight (+ total_mem_weight 5.32))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL2_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1678.94)) (setq bom1 (polar bom1t (DTR 270.0) 673.09)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1255.97)) (setq bom2 (polar bom2t (DTR 270.0) 673.09)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 929.66)) (setq bom3 (polar bom3t (DTR 270.0) 674.35)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 570.97)) (setq bom4 (polar bom4t (DTR 270.0) 674.35)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1678.94)) (setq bom5 (polar bom5t (DTR 270.0) 733.15)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1255.97)) (setq bom6 (polar bom6t (DTR 270.0) 733.15)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 909.5)) (setq bom7 (polar bom7t (DTR 270.0) 736.51)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 550.81)) (setq bom8 (polar bom8t (DTR 270.0) 736.51)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1678.94)) (setq bom9 (polar bom9t (DTR 270.0) 797.41)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1255.97)) (setq bom10 (polar bom10t (DTR 270.0) 797.41)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 909.5)) (setq bom11 (polar bom11t (DTR 270.0) 797.41)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 550.81)) (setq bom12 (polar bom12t (DTR 270.0) 798.67)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 941.84)) (setq bom13 (polar bom13t (DTR 270.0) 860.83)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 583.15)) (setq bom14 (polar bom14t (DTR 270.0) 860.83)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 953.6)) (setq bom15 (polar bom15t (DTR 270.0) 1403.89)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 594.91)) (setq bom16 (polar bom16t (DTR 270.0) 1403.89)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 953.6)) (setq bom17 (polar bom17t (DTR 270.0) 1535.78)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 594.91)) (setq bom18 (polar bom18t (DTR 270.0) 1535.78)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 670.68)) (setq bom19 (polar bom19t (DTR 270.0) 1591.64)) ;aa19
				
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
				
				(command "TEXT" bom9 "0" (strcat "PL" (rtos clampstk 2 0) "x50"))
				(command "TEXT" bom10 "0" (rtos (Number_Round newst1_newmem1_stx1 1) 2 0))
				(command "TEXT" bom11 "0" (rtos N5 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N5 ) 2 2))
				
				(command "TEXT" bom19 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom13 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom14 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom15 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom16 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom17 "0" (rtos total_weight 2 2))
				(command "TEXT" bom18 "0" (rtos (* total_weight 1.035) 2 2))
				
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)
		))	
		
		(if (and (= newstudnum 1) (= newstud1_memty "P") (= newst_mem_onpole 1) (= newst_mem_onstruct 1) (= newst1_newmem1_type "P") (= hip_mem 1) (= hip_mem1_type "P") ) (progn
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "IN-6.0M-RIT-120-CNTR-MP_P_SOL3" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 825.29)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 772.69)) (setq dm2 (polar dm2t (DTR 90.0) 3476.47)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 750.06)) (setq dm3 (polar dm3t (DTR 90.0) 4891.83)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 825.29)) (setq dm4 (polar dm4t (DTR 90.0) 5829.96)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 2989.11)) (setq dm5 (polar dm5t (DTR 90.0) 2000.29)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1795.48)) (setq dm6 (polar dm6t (DTR 90.0) 1508.41)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 1506.08)) (setq dm7 (polar dm7t (DTR 90.0) 1877.72)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 2631.08)) (setq dm8 (polar dm8t (DTR 90.0) 1877.72)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 3169.68)) (setq dm9 (polar dm9t (DTR 90.0) 943.26)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 3929.66)) (setq dm10 (polar dm10t (DTR 90.0) 942.04)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 6511.42)) (setq dm11 (polar dm11t (DTR 90.0) 6140)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 5290.15)) (setq dm12 (polar dm12t (DTR 90.0) 6023.38)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5373.55)) (setq dm13 (polar dm13t (DTR 90.0) 6023.38)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5461.94)) (setq dm14 (polar dm14t (DTR 90.0) 6023.38)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5290.6)) (setq dm15 (polar dm15t (DTR 90.0) 5948.38)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5290.15)) (setq dm16 (polar dm16t (DTR 90.0) 5880.29)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 6511.42)) (setq dm17 (polar dm17t (DTR 90.0) 4555.77)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 5126.10)) (setq dm18 (polar dm18t (DTR 90.0) 2750.36)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 4812.18)) (setq dm19 (polar dm19t (DTR 90.0) 2362.58)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 5201.45)) (setq dm20 (polar dm20t (DTR 90.0) 2203.66)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 4959.04)) (setq dm21 (polar dm21t (DTR 90.0) 2636.93)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5539.77)) (setq dm22 (polar dm22t (DTR 90.0) 2636.93)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 5969.08)) (setq dm23 (polar dm23t (DTR 90.0) 2636.92)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 4856.11)) (setq dm24 (polar dm24t (DTR 90.0) 2107.06)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 5546.79)) (setq dm25 (polar dm25t (DTR 90.0) 2107.06)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 4812.27)) (setq dm26 (polar dm26t (DTR 90.0) 1795.19)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 6315.31)) (setq dm27 (polar dm27t (DTR 90.0) 2221.9)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 6371.83)) (setq dm28 (polar dm28t (DTR 90.0) 2221.9)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 6035.25)) (setq dm29 (polar dm29t (DTR 90.0) 2021.9)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 6371.83)) (setq dm30 (polar dm30t (DTR 90.0) 2021.9)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 5929.95)) (setq dm31 (polar dm31t (DTR 90.0) 1799.97)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 5201.45)) (setq dm32 (polar dm32t (DTR 90.0) 1573.65)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 4856.11)) (setq dm33 (polar dm33t (DTR 90.0) 1477.05)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 5546.79)) (setq dm34 (polar dm34t (DTR 90.0) 1477.05)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 4812.27)) (setq dm35 (polar dm35t (DTR 90.0) 1165.18)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 8750)) (setq dm36 (polar dm36t (DTR 90.0) 6140)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 3378.14)) (setq dm37 (polar dm37t (DTR 90.0) 5055.22)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 3349.81)) (setq dm38 (polar dm38t (DTR 90.0) 3968)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 7911.03)) (setq dm39 (polar dm39t (DTR 90.0) 2457.33)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 8023.51)) (setq dm40 (polar dm40t (DTR 90.0) 2457.33)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 8158.23)) (setq dm41 (polar dm41t (DTR 90.0) 2457.33)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 7828.23)) (setq dm42 (polar dm42t (DTR 90.0) 2374.81)) ;b42
				(setq dm43t (polar ibp (DTR 0.0) 7828.23)) (setq dm43 (polar dm43t (DTR 90.0) 2262.33)) ;b43
				(setq dm44t (polar ibp (DTR 0.0) 7828.23)) (setq dm44 (polar dm44t (DTR 90.0) 2112.33)) ;b44
				(setq dm45t (polar ibp (DTR 0.0) 3349.81)) (setq dm45 (polar dm45t (DTR 90.0) 2773)) ;b45

				(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 190) (fix newst1_newmem1_y1))
				(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 190) (fix (- newstud1_y1 newst1_newmem1_y1)))
				(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 190) (fix (- joint_0 newstud1_y1)))
				(command "dim1" "hor" dm7 dm8 (polar dm7 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm9 dm10 (polar dm9 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm5 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm6 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm11 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm17 "" "" "" )				

				(command "dim1" "hor" dm12 dm13 (polar dm13 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm13 dm14 (polar dm13 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm12 dm15 (polar dm15 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm15 dm16 (polar dm15 (DTR 180.0) 47) newstud1_platey1)
				
				(if (= newst1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_2BOLTS" dm37 "" "" "" )))
				(if (= newst1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_60.3_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_2BOLTS" dm37 "" "" "" )))
				(if (= newst1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_76.1_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_2BOLTS" dm37 "" "" "" )))
				(if (= newst1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_88.9_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_2BOLTS" dm37 "" "" "" )))
				(if (= newst1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_101.6_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_2BOLTS" dm37 "" "" "" )))
				(if (= newst1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_114.3_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_2BOLTS" dm37 "" "" "" )))
				(if (= newst1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_139.7_120" dm18 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_2BOLTS" dm37 "" "" "" )))
	
				(if (= newst1_newmem1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm38 "" "" "" )))
				(if (= newst1_newmem1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm38 "" "" "" )))
				(if (= newst1_newmem1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm38 "" "" "" )))
				(if (= newst1_newmem1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm38 "" "" "" )))
				(if (= newst1_newmem1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm38 "" "" "" )))
				(if (= newst1_newmem1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm38 "" "" "" )))
				(if (= newst1_newmem1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm20 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm38 "" "" "" )))
				
				(if (= newstud1_hipmem1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm45 "" "" "" ))))
				(if (= newstud1_hipmem1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm45 "" "" "" ))))
				(if (= newstud1_hipmem1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm45 "" "" "" ))))
				(if (= newstud1_hipmem1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm45 "" "" "" ))))
				(if (= newstud1_hipmem1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm45 "" "" "" ))))
				(if (= newstud1_hipmem1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm45 "" "" "" ))))
				(if (= newstud1_hipmem1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm32 "" "" "" ) (if (/= newstud1_hipmem1_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm45 "" "" "" ))))
				
				(command "dim1" "hor" dm21 dm22 (polar dm22 (DTR 270.0) 181) (- newst1_joint2 (+ newst1_sizename2 35) 40))
				(command "dim1" "hor" dm22 dm23 (polar dm22 (DTR 270.0) 181) (- newst1_joint1 (+ newst1_sizename2 35) 40))
				(command "_insert" "f3x" dm19 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm24 dm25 (polar dm24 (DTR 270.0) 181) (Number_Round (- newst1_newmem1_len (+ newst1_newmem1_sizename2 35) (+ newst1_newmem1_sizename2 35)) 1))
				(command "_insert" "f3x" dm26 "0.0394" "0.0394" "" "N4" (strcat newstud1_memname ".." (itoa (Number_Round (+ newst1_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm27 dm28 (polar dm27 (DTR 90.0) 71) newst1_newmem1_stx2)
				(command "dim1" "hor" dm29 dm30 (polar dm29 (DTR 270.0) 90) (Number_Round newst1_newmem1_stx1 1))
				(command "_insert" "f3x" dm31 "0.0394" "0.0394" "" "N5" (strcat "PLT" (itoa (fix clampstk)) "x50.." (itoa (Number_Round newst1_newmem1_stx1 1)) " Lg"))
				
				(command "dim1" "hor" dm33 dm34 (polar dm34 (DTR 270.0) 181) (- (Number_Round newstud1_hipmem1_len 1) (+ newstud1_hipmem1_sizename2 35) (+ newstud1_hipmem1_sizename2 35)))
				(command "_insert" "f3x" dm35 "0.0394" "0.0394" "" "N6" (strcat newstud1_hipmem1_memname ".." (itoa (Number_Round (+ newstud1_hipmem1_len 50) 1)) " Lg"))
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm39 dm40 (polar dm40 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm40 dm41 (polar dm40 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm42 dm43 (polar dm43 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm43 dm44 (polar dm43 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm36)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N5 (* (/ clampstk 1000.0 )(/ 50 1000.0) (/ (Number_Round newst1_newmem1_stx1 1) 1000.0) 7850.0 3))
				(setq N6 (* (/ (Number_Round (+ newstud1_hipmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 N6 28.84))
				(setq total_weight (+ total_mem_weight 6.36))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL3_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1625.48)) (setq bom1 (polar bom1t (DTR 270.0) 650.49)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1286.32)) (setq bom2 (polar bom2t (DTR 270.0) 650.49)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 919.86)) (setq bom3 (polar bom3t (DTR 270.0) 651.7)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 573.53)) (setq bom4 (polar bom4t (DTR 270.0) 651.7)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1625.48)) (setq bom5 (polar bom5t (DTR 270.0) 708.48)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1286.32)) (setq bom6 (polar bom6t (DTR 270.0) 708.48)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 900.39)) (setq bom7 (polar bom7t (DTR 270.0) 711.72)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 554.06)) (setq bom8 (polar bom8t (DTR 270.0) 711.72)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1625.48)) (setq bom9 (polar bom9t (DTR 270.0) 770.53)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1286.32)) (setq bom10 (polar bom10t (DTR 270.0) 770.53)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 900.39)) (setq bom11 (polar bom11t (DTR 270.0) 771.74)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 554.06)) (setq bom12 (polar bom12t (DTR 270.0) 771.74)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 1625.48)) (setq bom13 (polar bom13t (DTR 270.0) 828.52)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 1286.32)) (setq bom14 (polar bom14t (DTR 270.0) 828.52)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 910.12)) (setq bom15 (polar bom15t (DTR 270.0) 831.76)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 563.79)) (setq bom16 (polar bom16t (DTR 270.0) 831.76)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 923.62)) (setq bom17 (polar bom17t (DTR 270.0) 951.8)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 577.29)) (setq bom18 (polar bom18t (DTR 270.0) 951.8)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 934.97)) (setq bom19 (polar bom19t (DTR 270.0) 1476.16)) ;aa19
				(setq bom20t (polar ibom (DTR 180.0) 588.64)) (setq bom20 (polar bom20t (DTR 270.0) 1476.16)) ;aa20
				(setq bom21t (polar ibom (DTR 180.0) 934.97)) (setq bom21 (polar bom21t (DTR 270.0) 1603.5)) ;aa21
				(setq bom22t (polar ibom (DTR 180.0) 588.64)) (setq bom22 (polar bom22t (DTR 270.0) 1603.5)) ;aa22
				(setq bom23t (polar ibom (DTR 180.0) 672.63)) (setq bom23 (polar bom23t (DTR 270.0) 1663.45)) ;aa23
				
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
				
				(command "TEXT" bom9 "0" (strcat "PL" (rtos clampstk 2 0) "x50"))
				(command "TEXT" bom10 "0" (rtos (Number_Round newst1_newmem1_stx1 1) 2 0))
				(command "TEXT" bom11 "0" (rtos N5 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N5 ) 2 2))
				
				(command "TEXT" bom13 "0" newstud1_hipmem1_memname)
				(command "TEXT" bom14 "0" (itoa (Number_Round (+ newstud1_hipmem1_len 50) 1)))
				(command "TEXT" bom15 "0" (rtos N6 2 2))
				(command "TEXT" bom16 "0" (rtos (* 1.035 N6 ) 2 2))
				
				(command "TEXT" bom23 "0" (rtos concrete_vol 2 3))	
				
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom17 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom18 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom19 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom20 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom21 "0" (rtos total_weight 2 2))
				(command "TEXT" bom22 "0" (rtos (* total_weight 1.035) 2 2))
				
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)
				
		))
		
		(if (and (= newstudnum 1) (= newstud1_memty "P") (= newst_mem_onpole 2) (= newst_mem_onstruct 2) (= newst1_newmem1_type "P") (= hip_mem 0) ) (progn
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/bolckss/IN-6.0M-RIT-120-CNTR-MP_P_SOL4" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 772.69)) (setq dm1 (polar dm1t (DTR 90.0) 2079.97)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 772.69)) (setq dm2 (polar dm2t (DTR 90.0) 2936.52)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 772.69)) (setq dm3 (polar dm3t (DTR 90.0) 3903.65)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 750.06)) (setq dm4 (polar dm4t (DTR 90.0) 4891.84)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 825.3)) (setq dm5 (polar dm5t (DTR 90.0) 5829.97)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1506.09)) (setq dm6 (polar dm6t (DTR 90.0) 1877.72)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2631.09)) (setq dm7 (polar dm7t (DTR 90.0) 1877.72)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 2989.12)) (setq dm8 (polar dm8t (DTR 90.0) 2000.29)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 1795.48)) (setq dm9 (polar dm9t (DTR 90.0) 1508.42)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 3160.91)) (setq dm10 (polar dm10t (DTR 90.0) 943.27)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 3917.51)) (setq dm11 (polar dm11t (DTR 90.0) 945.42)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 6514.67)) (setq dm12 (polar dm12t (DTR 90.0) 6140)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 6514.67)) (setq dm13 (polar dm13t (DTR 90.0) 4555.78)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5293.4)) (setq dm14 (polar dm14t (DTR 90.0) 6023.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5376.8)) (setq dm15 (polar dm15t (DTR 90.0) 6023.39)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5465.19)) (setq dm16 (polar dm16t (DTR 90.0) 6023.39)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 5293.85)) (setq dm17 (polar dm17t (DTR 90.0) 5948.39)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 5293.4)) (setq dm18 (polar dm18t (DTR 90.0) 5880.3)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 5447.03)) (setq dm19 (polar dm19t (DTR 90.0) 2654.45)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 4979.8)) (setq dm20 (polar dm20t (DTR 90.0) 2541.03)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 5284.62)) (setq dm21 (polar dm21t (DTR 90.0) 2541.02)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5739.62)) (setq dm22 (polar dm22t (DTR 90.0) 2541.02)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 5989.84)) (setq dm23 (polar dm23t (DTR 90.0) 2541.02)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 5034.73)) (setq dm24 (polar dm24t (DTR 90.0) 2220.49)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 5080.99)) (setq dm25 (polar dm25t (DTR 90.0) 2020.1)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 4735.65)) (setq dm26 (polar dm26t (DTR 90.0) 1929.9)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 5426.33)) (setq dm27 (polar dm27t (DTR 90.0) 1929.9)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 4757.66)) (setq dm28 (polar dm28t (DTR 90.0) 1604.63)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 5521.31)) (setq dm29 (polar dm29t (DTR 90.0) 1351.67)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 5175.97)) (setq dm30 (polar dm30t (DTR 90.0) 1261.47)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 5866.65)) (setq dm31 (polar dm31t (DTR 90.0) 1261.47)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 5125.89)) (setq dm32 (polar dm32t (DTR 90.0) 918.64)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 6283.59)) (setq dm33 (polar dm33t (DTR 90.0) 2034.88)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 6340.1)) (setq dm34 (polar dm34t (DTR 90.0) 2034.88)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 6003.53)) (setq dm35 (polar dm35t (DTR 90.0) 1834.88)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 6340.1)) (setq dm36 (polar dm36t (DTR 90.0) 1834.88)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 5875.34)) (setq dm37 (polar dm37t (DTR 90.0) 1609.4)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 3381.39)) (setq dm38 (polar dm38t (DTR 90.0) 5055.23)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 3353.06)) (setq dm39 (polar dm39t (DTR 90.0) 3968.01)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 8750)) (setq dm40 (polar dm40t (DTR 90.0) 6140)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 7901.03)) (setq dm41 (polar dm41t (DTR 90.0) 2504.74)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 8013.51)) (setq dm42 (polar dm42t (DTR 90.0) 2504.46)) ;b42
				(setq dm43t (polar ibp (DTR 0.0) 8148.23)) (setq dm43 (polar dm43t (DTR 90.0) 2504.74)) ;b43
				(setq dm44t (polar ibp (DTR 0.0) 7818.23)) (setq dm44 (polar dm44t (DTR 90.0) 2421.94)) ;b44
				(setq dm45t (polar ibp (DTR 0.0) 7818.23)) (setq dm45 (polar dm45t (DTR 90.0) 2309.46)) ;b45
				(setq dm46t (polar ibp (DTR 0.0) 7818.23)) (setq dm46 (polar dm46t (DTR 90.0) 2159.46)) ;b46
				(setq dm47t (polar ibp (DTR 0.0) 3349.81)) (setq dm47 (polar dm47t (DTR 90.0) 2773)) ;b47
				
				(if(< newst1_newmem1_y1 newst1_newmem2_y1) 
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem1_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem2_y1 newst1_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem2_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				(if(< newst1_newmem2_y1 newst1_newmem1_y1) 
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem2_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem1_y1 newst2_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem1_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				
				(command "dim1" "hor" dm6 dm7 (polar dm6 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm10 dm11 (polar dm10 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm8 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm9 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm12 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm13 "" "" "" )				

				(command "dim1" "hor" dm14 dm15 (polar dm15 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm15 dm16 (polar dm15 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm14 dm17 (polar dm17 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm17 dm18 (polar dm17 (DTR 180.0) 47) newstud1_platey1)
								
				(if (= newst1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_2BOLTS" dm38 "" "" "" )))
				(if (= newst1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_60.3_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_2BOLTS" dm38 "" "" "" )))
				(if (= newst1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_76.1_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_2BOLTS" dm38 "" "" "" )))
				(if (= newst1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_88.9_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_2BOLTS" dm38 "" "" "" )))
				(if (= newst1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_101.6_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_2BOLTS" dm38 "" "" "" )))
				(if (= newst1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_114.3_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_2BOLTS" dm38 "" "" "" )))
				(if (= newst1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_139.7_3" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_2BOLTS" dm38 "" "" "" )))
	
				(if (= newst1_newmem1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm39 "" "" "" )))
				(if (= newst1_newmem1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm39 "" "" "" )))
				(if (= newst1_newmem1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm39 "" "" "" )))
				(if (= newst1_newmem1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm39 "" "" "" )))
				(if (= newst1_newmem1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm39 "" "" "" )))
				(if (= newst1_newmem1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm39 "" "" "" )))
				(if (= newst1_newmem1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm39 "" "" "" )))
				
				(if (= newst1_newmem2_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm47 "" "" "" ))))
				(if (= newst1_newmem2_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm47 "" "" "" ))))
				(if (= newst1_newmem2_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm47 "" "" "" ))))
				(if (= newst1_newmem2_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm47 "" "" "" ))))
				(if (= newst1_newmem2_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm47 "" "" "" ))))
				(if (= newst1_newmem2_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm47 "" "" "" ))))
				(if (= newst1_newmem2_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm29 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm47 "" "" "" ))))
				
				(command "dim1" "hor" dm20 dm21 (polar dm21 (DTR 270.0) 157) (- newst1_joint1 (+ newst1_sizename2 35) 40))
				(command "dim1" "hor" dm21 dm22 (polar dm21 (DTR 270.0) 157) newst1_joint2)
				(command "dim1" "hor" dm22 dm23 (polar dm22 (DTR 270.0) 157) (- newst1_joint3 (+ newst1_sizename2 35) 40))
				(command "_insert" "f3x" dm24 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm26 dm27 (polar dm26 (DTR 270.0) 181) (Number_Round (- newst1_newmem1_len (+ newst1_newmem1_sizename2 35) (+ newst1_newmem1_sizename2 35)) 1))
				(command "_insert" "f3x" dm28 "0.0394" "0.0394" "" "N4" (strcat newstud1_memname ".." (itoa (Number_Round (+ newst1_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm30 dm31 (polar dm30 (DTR 270.0) 181) (Number_Round (- newst1_newmem2_len (+ newst1_newmem2_sizename2 35) (+ newst1_newmem2_sizename2 35)) 1))
				(command "_insert" "f3x" dm32 "0.0394" "0.0394" "" "N6" (strcat newstud1_memname ".." (itoa (Number_Round (+ newst2_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm33 dm34 (polar dm34 (DTR 90.0) 71) newst1_newmem1_stx2)
				(command "dim1" "hor" dm35 dm36 (polar dm36 (DTR 270.0) 90) (Number_Round newst1_newmem1_stx1 1))
				(command "_insert" "f3x" dm37 "0.0394" "0.0394" "" "N5" (strcat "PLT" (itoa (fix clampstk)) "x50.." (itoa (Number_Round newst1_newmem1_stx1 1)) " Lg"))
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm41 dm42 (polar dm42 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm42 dm43 (polar dm42 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm44 dm45 (polar dm45 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm45 dm46 (polar dm45 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm40)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N5 (* (/ clampstk 1000.0 )(/ 50 1000.0) (/ (Number_Round newst1_newmem1_stx1 1) 1000.0) 7850.0 3))
				(setq N6 (* (/ (Number_Round (+ newst1_newmem2_len 50) 1) 1000.0) newst1_newmem2_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 N6 31.91))
				(setq total_weight (+ total_mem_weight 7.76))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL4_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1687.95)) (setq bom1 (polar bom1t (DTR 270.0) 673.09)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1242.1)) (setq bom2 (polar bom2t (DTR 270.0) 673.09)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 929.66)) (setq bom3 (polar bom3t (DTR 270.0) 674.35)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 570.97)) (setq bom4 (polar bom4t (DTR 270.0) 674.35)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1682.91)) (setq bom5 (polar bom5t (DTR 270.0) 733.15)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1242.1)) (setq bom6 (polar bom6t (DTR 270.0) 733.15)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 909.5)) (setq bom7 (polar bom7t (DTR 270.0) 736.51)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 550.81)) (setq bom8 (polar bom8t (DTR 270.0) 736.51)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1678.95)) (setq bom9 (polar bom9t (DTR 270.0) 797.41)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1242.1)) (setq bom10 (polar bom10t (DTR 270.0) 797.41)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 909.5)) (setq bom11 (polar bom11t (DTR 270.0) 798.67)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 550.81)) (setq bom12 (polar bom12t (DTR 270.0) 798.67)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 1678.95)) (setq bom13 (polar bom13t (DTR 270.0) 858.31)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 1242.1)) (setq bom14 (polar bom14t (DTR 270.0) 858.31)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 909.5)) (setq bom15 (polar bom15t (DTR 270.0) 859.57)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 550.81)) (setq bom16 (polar bom16t (DTR 270.0) 859.57)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 941.84)) (setq bom17 (polar bom17t (DTR 270.0) 921.73)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 583.15)) (setq bom18 (polar bom18t (DTR 270.0) 921.73)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 953.6)) (setq bom19 (polar bom19t (DTR 270.0) 1403.89)) ;aa19
				(setq bom20t (polar ibom (DTR 180.0) 594.91)) (setq bom20 (polar bom20t (DTR 270.0) 1403.89)) ;aa20
				(setq bom21t (polar ibom (DTR 180.0) 953.6)) (setq bom21 (polar bom21t (DTR 270.0) 1535.78)) ;aa21
				(setq bom22t (polar ibom (DTR 180.0) 594.91)) (setq bom22 (polar bom22t (DTR 270.0) 1535.78)) ;aa22
				(setq bom23t (polar ibom (DTR 180.0) 671.8)) (setq bom23 (polar bom23t (DTR 270.0) 1594.33)) ;aa23
								
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
				
				(command "TEXT" bom9 "0" (strcat "PL" (rtos clampstk 2 0) "x50"))
				(command "TEXT" bom10 "0" (rtos (Number_Round newst1_newmem1_stx1 1) 2 0))
				(command "TEXT" bom11 "0" (rtos N5 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N5 ) 2 2))
				
				(command "TEXT" bom13 "0" newst1_newmem2_memname)
				(command "TEXT" bom14 "0" (itoa (Number_Round (+ newst1_newmem2_len 50) 1)))
				(command "TEXT" bom15 "0" (rtos N6 2 2))
				(command "TEXT" bom16 "0" (rtos (* 1.035 N6 ) 2 2))
				
				(command "TEXT" bom23 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom17 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom18 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom19 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom20 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom21 "0" (rtos total_weight 2 2))
				(command "TEXT" bom22 "0" (rtos (* total_weight 1.035) 2 2))
				
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)

		))
		
		(if (and (= newstudnum 1) (= newstud1_memty "P") (= newst_mem_onpole 2) (= newst_mem_onstruct 2) (= newst1_newmem1_type "P") (= hip_mem 2) (= hip_mem1_type "P") ) (progn
				
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/bolckss/IN-6.0M-RIT-120-CNTR-MP_P_SOL5" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 772.69)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 772.69)) (setq dm2 (polar dm2t (DTR 90.0) 2936.51)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 772.69)) (setq dm3 (polar dm3t (DTR 90.0) 3903.65)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 750.06)) (setq dm4 (polar dm4t (DTR 90.0) 4891.84)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 825.3)) (setq dm5 (polar dm5t (DTR 90.0) 5829.96)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1795.48)) (setq dm6 (polar dm6t (DTR 90.0) 1508.42)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2989.12)) (setq dm7 (polar dm7t (DTR 90.0) 2000.29)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 1506.09)) (setq dm8 (polar dm8t (DTR 90.0) 1877.72)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 2631.09)) (setq dm9 (polar dm9t (DTR 90.0) 1877.72)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 2672.03)) (setq dm10 (polar dm10t (DTR 90.0) 917.84)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 3428.63)) (setq dm11 (polar dm11t (DTR 90.0) 920)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 6511.42)) (setq dm12 (polar dm12t (DTR 90.0) 6140)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5290.16)) (setq dm13 (polar dm13t (DTR 90.0) 6023.39)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5373.56)) (setq dm14 (polar dm14t (DTR 90.0) 6023.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5461.94)) (setq dm15 (polar dm15t (DTR 90.0) 6023.39)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5290.61)) (setq dm16 (polar dm16t (DTR 90.0) 5948.39)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 5290.16)) (setq dm17 (polar dm17t (DTR 90.0) 5880.29)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 4331.14)) (setq dm18 (polar dm18t (DTR 90.0) 6140)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 5082.17)) (setq dm19 (polar dm19t (DTR 90.0) 1924.45)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 4560.71)) (setq dm20 (polar dm20t (DTR 90.0) 1803.8)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 4866.32)) (setq dm21 (polar dm21t (DTR 90.0) 1803.84)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5321.32)) (setq dm22 (polar dm22t (DTR 90.0) 1803.84)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 5571.53)) (setq dm23 (polar dm23t (DTR 90.0) 1803.84)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 4651.2)) (setq dm24 (polar dm24t (DTR 90.0) 1483.01)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 5141.28)) (setq dm25 (polar dm25t (DTR 90.0) 1247.87)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 4795.94)) (setq dm26 (polar dm26t (DTR 90.0) 1151.27)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 5486.62)) (setq dm27 (polar dm27t (DTR 90.0) 1151.27)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 4779.95)) (setq dm28 (polar dm28t (DTR 90.0) 821.84)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 6326.24)) (setq dm29 (polar dm29t (DTR 90.0) 1248.55)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 6382.75)) (setq dm30 (polar dm30t (DTR 90.0) 1248.55)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 6046.18)) (setq dm31 (polar dm31t (DTR 90.0) 1048.55)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 6382.75)) (setq dm32 (polar dm32t (DTR 90.0) 1048.55)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 5940.88)) (setq dm33 (polar dm33t (DTR 90.0) 826.61)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 5141.28)) (setq dm34 (polar dm34t (DTR 90.0) 612.55)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 4795.94)) (setq dm35 (polar dm35t (DTR 90.0) 515.95)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 5486.62)) (setq dm36 (polar dm36t (DTR 90.0) 515.95)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 4779.95)) (setq dm37 (polar dm37t (DTR 90.0) 204.56)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 3283.01)) (setq dm38 (polar dm38t (DTR 90.0) 4258.62)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 3973.69)) (setq dm39 (polar dm39t (DTR 90.0) 4258.62)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 3239.17)) (setq dm40 (polar dm40t (DTR 90.0) 3942.11)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 3316.93)) (setq dm41 (polar dm41t (DTR 90.0) 3614.4)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 4007.61)) (setq dm42 (polar dm42t (DTR 90.0) 3614.4)) ;b42
				(setq dm43t (polar ibp (DTR 0.0) 3273.1)) (setq dm43 (polar dm43t (DTR 90.0) 3302.53)) ;b43
				(setq dm44t (polar ibp (DTR 0.0) 5509.97)) (setq dm44 (polar dm44t (DTR 90.0) 3493.71)) ;b44
				(setq dm45t (polar ibp (DTR 0.0) 5504.81)) (setq dm45 (polar dm45t (DTR 90.0) 2309.33)) ;b45
				(setq dm46t (polar ibp (DTR 0.0) 8750)) (setq dm46 (polar dm46t (DTR 90.0) 6140)) ;b46
				(setq dm47t (polar ibp (DTR 0.0) 6803.01)) (setq dm47 (polar dm47t (DTR 90.0) 3158.55)) ;b47
				(setq dm48t (polar ibp (DTR 0.0) 6915.49)) (setq dm48 (polar dm48t (DTR 90.0) 3158.55)) ;b48
				(setq dm49t (polar ibp (DTR 0.0) 7050.21)) (setq dm49 (polar dm49t (DTR 90.0) 3158.84)) ;b49
				(setq dm50t (polar ibp (DTR 0.0) 6720.21)) (setq dm50 (polar dm50t (DTR 90.0) 3076.04)) ;b50
				(setq dm51t (polar ibp (DTR 0.0) 6720.21)) (setq dm51 (polar dm51t (DTR 90.0) 2963.55)) ;b51
				(setq dm52t (polar ibp (DTR 0.0) 6720.21)) (setq dm52 (polar dm52t (DTR 90.0) 2813.55)) ;b52
				(setq dm53t (polar ibp (DTR 0.0) 3349.81)) (setq dm53 (polar dm53t (DTR 90.0) 2773)) ;b53
				
				(if(< newst1_newmem1_y1 newst1_newmem2_y1)
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem1_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem2_y1 newst1_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem2_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				(if(< newst1_newmem2_y1 newst1_newmem1_y1)
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem2_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem1_y1 newst2_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem1_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				
				(command "dim1" "hor" dm8 dm9 (polar dm8 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm10 dm11 (polar dm10 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm7 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm6 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm12 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm18 "" "" "" )				

				(command "dim1" "hor" dm13 dm14 (polar dm14 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm14 dm15 (polar dm14 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm13 dm16 (polar dm16 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm16 dm17 (polar dm16 (DTR 180.0) 47) newstud1_platey1)
								
				(if (= newst1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_2BOLTS" dm44 "" "" "" )))
				(if (= newst1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_2BOLTS" dm44 "" "" "" )))
				(if (= newst1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_2BOLTS" dm44 "" "" "" )))
				(if (= newst1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_2BOLTS" dm44 "" "" "" )))
				(if (= newst1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_2BOLTS" dm44 "" "" "" )))
				(if (= newst1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_2BOLTS" dm44 "" "" "" )))
				(if (= newst1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_2BOLT_48.3_2_120" dm19 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_2BOLTS" dm44 "" "" "" )))
	
				(if (= newst1_newmem1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm45 "" "" "" )))
				(if (= newst1_newmem1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm45 "" "" "" )))
				(if (= newst1_newmem1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm45 "" "" "" )))
				(if (= newst1_newmem1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm45 "" "" "" )))
				(if (= newst1_newmem1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm45 "" "" "" )))
				(if (= newst1_newmem1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm45 "" "" "" )))
				(if (= newst1_newmem1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm45 "" "" "" )))
				
				(if (= newst1_newmem2_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm45 "" "" "" ))))
				(if (= newst1_newmem2_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm45 "" "" "" ))))
				(if (= newst1_newmem2_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm45 "" "" "" ))))
				(if (= newst1_newmem2_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm45 "" "" "" ))))
				(if (= newst1_newmem2_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm45 "" "" "" ))))
				(if (= newst1_newmem2_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm45 "" "" "" ))))
				(if (= newst1_newmem2_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm34 "" "" "" ) (if (/= newst1_newmem2_size newst1_newmem1_size) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm45 "" "" "" ))))
				
				(if (= newstud1_hipmem1_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem1_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem1_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem1_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem1_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem1_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem1_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm45 "" "" "" )))
				
				(if (= newstud1_hipmem2_size 48.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_48.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_48.3_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem2_size 60.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_60.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_60.3_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem2_size 76.1) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_76.1" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_76.1_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem2_size 88.9) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_88.9" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_88.9_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem2_size 101.6) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_101.6" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_101.6_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem2_size 114.3) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_114.3" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_114.3_1BOLTS" dm45 "" "" "" )))
				(if (= newstud1_hipmem2_size 139.7) (progn (command "_insert" "c:/detail/POLEDATA/PIPE_SINGLEBOLT_139.7" dm25 "" "" "" ) (command "_insert" "c:/detail/POLEDATA/PIPEPRESS_139.7_1BOLTS" dm45 "" "" "" )))
				
				(command "dim1" "hor" dm20 dm21 (polar dm21 (DTR 270.0) 157) (- newst1_joint1 (+ newst1_sizename2 35) 40))
				(command "dim1" "hor" dm21 dm22 (polar dm21 (DTR 270.0) 157) newst1_joint2)
				(command "dim1" "hor" dm22 dm23 (polar dm22 (DTR 270.0) 157) (- newst1_joint3 (+ newst1_sizename2 35) 40))
				(command "_insert" "f3x" dm24 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm26 dm27 (polar dm26 (DTR 270.0) 181) (Number_Round (- newst1_newmem1_len (+ newst1_newmem1_sizename2 35) (+ newst1_newmem1_sizename2 35)) 1))
				(command "_insert" "f3x" dm28 "0.0394" "0.0394" "" "N4" (strcat newst1_newmem1_memname ".." (itoa (Number_Round (+ newst1_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm35 dm36 (polar dm35 (DTR 270.0) 181) (Number_Round (- newst1_newmem2_len (+ newst1_newmem2_sizename2 35) (+ newst1_newmem2_sizename2 35)) 1))
				(command "_insert" "f3x" dm37 "0.0394" "0.0394" "" "N6" (strcat newst1_newmem2_memname ".." (itoa (Number_Round (+ newst2_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm29 dm30 (polar dm34 (DTR 90.0) 71) newst1_newmem1_stx2)
				(command "dim1" "hor" dm31 dm32 (polar dm36 (DTR 270.0) 90) (Number_Round newst1_newmem1_stx1 1))
				(command "_insert" "f3x" dm33 "0.0394" "0.0394" "" "N5" (strcat "PLT" (itoa (fix clampstk)) "x50.." (itoa (Number_Round newst1_newmem1_stx1 1)) " Lg"))
				
				(command "dim1" "hor" dm38 dm39 (polar dm26 (DTR 270.0) 181) (Number_Round (- newstud1_hipmem1_len (+ newstud1_hipmem1_sizename2 35) (+ newstud1_hipmem1_sizename2 35)) 1))
				(command "_insert" "f3x" dm40 "0.0394" "0.0394" "" "N4" (strcat newst1_newmem1_memname ".." (itoa (Number_Round (+ newst1_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "hor" dm41 dm42 (polar dm35 (DTR 270.0) 181) (Number_Round (- newstud1_hipmem2_len (+ newstud1_hipmem2_sizename2 35) (+ newstud1_hipmem2_sizename2 35)) 1))
				(command "_insert" "f3x" dm43 "0.0394" "0.0394" "" "N6" (strcat newstud1_hipmem2_memname ".." (itoa (Number_Round (+ newstud1_hipmem2_len 50) 1)) " Lg"))
			
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm47 dm48 (polar dm48 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm48 dm49 (polar dm48 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm50 dm51 (polar dm51 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm51 dm52 (polar dm51 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm46)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N5 (* (/ clampstk 1000.0 )(/ 50 1000.0) (/ (Number_Round newst1_newmem1_stx1 1) 1000.0) 7850.0 3))
				(setq N6 (* (/ (Number_Round (+ newst1_newmem2_len 50) 1) 1000.0) newst1_newmem2_blockwt 3))
				(setq N8 (* (/ (Number_Round (+ newstud1_hipmem1_len 50) 1) 1000.0) newstud1_hipmem1_blockwt 3))
				(setq N9 (* (/ (Number_Round (+ newstud1_hipmem2_len 50) 1) 1000.0) newstud1_hipmem2_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 N6 N8 N9 33.3))
				(setq total_weight (+ total_mem_weight 9.2))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL5_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1625.47)) (setq bom1 (polar bom1t (DTR 270.0) 650.48)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1224.72)) (setq bom2 (polar bom2t (DTR 270.0) 650.48)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 911.85)) (setq bom3 (polar bom3t (DTR 270.0) 651.7)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 565.52)) (setq bom4 (polar bom4t (DTR 270.0) 651.7)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1625.47)) (setq bom5 (polar bom5t (DTR 270.0) 708.47)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1224.72)) (setq bom6 (polar bom6t (DTR 270.0) 708.47)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 912.61)) (setq bom7 (polar bom7t (DTR 270.0) 711.72)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 546.05)) (setq bom8 (polar bom8t (DTR 270.0) 711.72)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1625.47)) (setq bom9 (polar bom9t (DTR 270.0) 770.52)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1224.72)) (setq bom10 (polar bom10t (DTR 270.0) 770.52)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 912.61)) (setq bom11 (polar bom11t (DTR 270.0) 771.74)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 546.05)) (setq bom12 (polar bom12t (DTR 270.0) 771.74)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 1625.47)) (setq bom13 (polar bom13t (DTR 270.0) 828.51)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 1224.72)) (setq bom14 (polar bom14t (DTR 270.0) 828.51)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 912.61)) (setq bom15 (polar bom15t (DTR 270.0) 831.76)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 555.79)) (setq bom16 (polar bom16t (DTR 270.0) 831.76)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 1625.47)) (setq bom17 (polar bom17t (DTR 270.0) 948.55)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 1224.72)) (setq bom18 (polar bom18t (DTR 270.0) 948.55)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 912.61)) (setq bom19 (polar bom19t (DTR 270.0) 951.8)) ;aa19
				(setq bom20t (polar ibom (DTR 180.0) 555.79)) (setq bom20 (polar bom20t (DTR 270.0) 951.8)) ;aa20
				(setq bom21t (polar ibom (DTR 180.0) 1625.47)) (setq bom21 (polar bom21t (DTR 270.0) 1007.35)) ;aa21
				(setq bom22t (polar ibom (DTR 180.0) 1224.72)) (setq bom22 (polar bom22t (DTR 270.0) 1007.35)) ;aa22
				(setq bom23t (polar ibom (DTR 180.0) 912.61)) (setq bom23 (polar bom23t (DTR 270.0) 1010.6)) ;aa23
				(setq bom24t (polar ibom (DTR 180.0) 555.79)) (setq bom24 (polar bom24t (DTR 270.0) 1010.6)) ;aa24
				(setq bom25t (polar ibom (DTR 180.0) 923.61)) (setq bom25 (polar bom25t (DTR 270.0) 1069.4)) ;aa25
				(setq bom26t (polar ibom (DTR 180.0) 577.28)) (setq bom26 (polar bom26t (DTR 270.0) 1069.4)) ;aa26
				(setq bom27t (polar ibom (DTR 180.0) 934.96)) (setq bom27 (polar bom27t (DTR 270.0) 1476.16)) ;aa27
				(setq bom28t (polar ibom (DTR 180.0) 588.64)) (setq bom28 (polar bom28t (DTR 270.0) 1476.16)) ;aa28
				(setq bom29t (polar ibom (DTR 180.0) 934.96)) (setq bom29 (polar bom29t (DTR 270.0) 1603.5)) ;aa29
				(setq bom30t (polar ibom (DTR 180.0) 588.64)) (setq bom30 (polar bom30t (DTR 270.0) 1603.5)) ;aa30
				(setq bom31t (polar ibom (DTR 180.0) 673.01)) (setq bom31 (polar bom31t (DTR 270.0) 1662.2)) ;aa31
								
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
				
				(command "TEXT" bom9 "0" (strcat "PL" (rtos clampstk 2 0) "x50"))
				(command "TEXT" bom10 "0" (rtos (Number_Round newst1_newmem1_stx1 1) 2 0))
				(command "TEXT" bom11 "0" (rtos N5 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N5 ) 2 2))
				
				(command "TEXT" bom13 "0" newst1_newmem2_memname)
				(command "TEXT" bom14 "0" (itoa (Number_Round (+ newst1_newmem2_len 50) 1)))
				(command "TEXT" bom15 "0" (rtos N6 2 2))
				(command "TEXT" bom16 "0" (rtos (* 1.035 N6 ) 2 2))
				
				(command "TEXT" bom17 "0" newstud1_hipmem1_memname)
				(command "TEXT" bom18 "0" (itoa (Number_Round (+ newstud1_hipmem1_len 50) 1)))
				(command "TEXT" bom19 "0" (rtos N8 2 2))
				(command "TEXT" bom20 "0" (rtos (* 1.035 N8 ) 2 2))
				
				(command "TEXT" bom21 "0" newstud1_hipmem2_memname)
				(command "TEXT" bom22 "0" (itoa (Number_Round (+ newstud1_hipmem2_len 50) 1)))
				(command "TEXT" bom23 "0" (rtos N9 2 2))
				(command "TEXT" bom24 "0" (rtos (* 1.035 N9 ) 2 2))
				
				(command "TEXT" bom31 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom25 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom26 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom27 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom28 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom29 "0" (rtos total_weight 2 2))
				(command "TEXT" bom30 "0" (rtos (* total_weight 1.035) 2 2))
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)

		))
	
		
		(if (and (= newstudnum 1) (= newstud1_memty "A") (= newst_mem_onpole 0) (= newst_mem_onstruct 0) (= hip_mem 0) ) (progn 			
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_A_SOL1" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 1117.33)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 1097.33)) (setq dm2 (polar dm2t (DTR 90.0) 4870.42)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 1094.7)) (setq dm3 (polar dm3t (DTR 90.0) 5833.35)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 2178.56)) (setq dm4 (polar dm4t (DTR 90.0) 1539.67)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 3333.75)) (setq dm5 (polar dm5t (DTR 90.0) 2000.29)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1850.72)) (setq dm6 (polar dm6t (DTR 90.0) 1877.72)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2975.72)) (setq dm7 (polar dm7t (DTR 90.0) 1877.72)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 3238.27)) (setq dm8 (polar dm8t (DTR 90.0) 891.2)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 3913.27)) (setq dm9 (polar dm9t (DTR 90.0) 889.85)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 6511.7)) (setq dm10 (polar dm10t (DTR 90.0) 6140)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 5290.44)) (setq dm11 (polar dm11t (DTR 90.0) 6023.39)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 5373.84)) (setq dm12 (polar dm12t (DTR 90.0) 6023.39)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5462.22)) (setq dm13 (polar dm13t (DTR 90.0) 6023.39)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5290.89)) (setq dm14 (polar dm14t (DTR 90.0) 5948.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5290.44)) (setq dm15 (polar dm15t (DTR 90.0) 5880.29)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 4493.54)) (setq dm16 (polar dm16t (DTR 90.0) 4028.43)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 4493.54)) (setq dm17 (polar dm17t (DTR 90.0) 4111.59)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 4791.86)) (setq dm18 (polar dm18t (DTR 90.0) 3945.27)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 6086.03)) (setq dm19 (polar dm19t (DTR 90.0) 3945.27)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 5182.07)) (setq dm20 (polar dm20t (DTR 90.0) 3677.8)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 8750)) (setq dm21 (polar dm21t (DTR 90.0) 6140)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 7901.03)) (setq dm22 (polar dm22t (DTR 90.0) 2762.58)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 8013.51)) (setq dm23 (polar dm23t (DTR 90.0) 2762.58)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 8148.23)) (setq dm24 (polar dm24t (DTR 90.0) 2762.3)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 7818.23)) (setq dm25 (polar dm25t (DTR 90.0) 2679.78)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 7818.23)) (setq dm26 (polar dm26t (DTR 90.0) 2567.3)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 7818.23)) (setq dm27 (polar dm27t (DTR 90.0) 2417.3)) ;b27

				(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 190) (fix newstud1_y1))
				(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 190) (fix (- joint_0 newstud1_y1)))
				(command "dim1" "hor" dm6 dm7 (polar dm4 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm8 dm9 (polar dm8 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm5 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm4 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm10 "" "" "" )				

				(command "dim1" "hor" dm11 dm12 (polar dm12 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm12 dm13 (polar dm12 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm11 dm14 (polar dm14 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm14 dm15 (polar dm14 (DTR 180.0) 47) newstud1_platey1)
	
				(command "dim1" "hor" dm18 dm19 (polar dm18 (DTR 270.0) 181) (Number_Round (- newstud1_memlen 80) 1))
				(command "dim1" "ver" dm16 dm17 (polar dm16 (DTR 180.0) 80) newstud1_backmark)
				
				(command "_insert" "f3x" dm20 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				(command "line" (polar dm20 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				
				(command "dim1" "hor" dm22 dm23 (polar dm23 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm23 dm24 (polar dm23 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm25 dm26 (polar dm26 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm26 dm27 (polar dm26 (DTR 180.0) 79) (+ newstud1_platey2 50))
				;BOM
				(setq ibom dm21)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 20.41))
				(setq total_weight (+ total_mem_weight 2.40))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_A_SOL1_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1609.7)) (setq bom1 (polar bom1t (DTR 270.0) 469.67)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1249.11)) (setq bom2 (polar bom2t (DTR 270.0) 469.67)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 876.57)) (setq bom3 (polar bom3t (DTR 270.0) 470.89)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 529.91)) (setq bom4 (polar bom4t (DTR 270.0) 470.89)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 888.35)) (setq bom5 (polar bom5t (DTR 270.0) 530.96)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 541.68)) (setq bom6 (polar bom6t (DTR 270.0) 530.96)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 899.71)) (setq bom7 (polar bom7t (DTR 270.0) 1117.95)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 553.04)) (setq bom8 (polar bom8t (DTR 270.0) 1117.95)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 899.71)) (setq bom9 (polar bom9t (DTR 270.0) 1245.41)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 553.04)) (setq bom10 (polar bom10t (DTR 270.0) 1245.41)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 676.08)) (setq bom11 (polar bom11t (DTR 270.0) 1303.68)) ;aa11
				
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				(command "TEXT" bom11 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom5 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom6 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom7 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom8 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom9 "0" (rtos total_weight 2 2))
				(command "TEXT" bom10 "0" (rtos (* total_weight 1.035) 2 2))
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)
		))		
		
		(if (and (= newstudnum 1) (= newstud1_memty "A") (= newst_mem_onpole 1) (= newst_mem_onstruct 1) (= newst1_newmem1_type "A") (= (fix hip_mem) 0)) (progn
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/bolckss/IN-6.0M-RIT-120-CNTR-MP_A_SOL2" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 1081.33)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 1081.33)) (setq dm2 (polar dm2t (DTR 90.0) 3425.86)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 1058.7)) (setq dm3 (polar dm3t (DTR 90.0) 4891.84)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 1133.94)) (setq dm4 (polar dm4t (DTR 90.0) 5829.96)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 2142.56)) (setq dm5 (polar dm5t (DTR 90.0) 1539.67)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1814.72)) (setq dm6 (polar dm6t (DTR 90.0) 1877.72)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2939.72)) (setq dm7 (polar dm7t (DTR 90.0) 1877.72)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 3297.75)) (setq dm8 (polar dm8t (DTR 90.0) 2000.29)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 3202.27)) (setq dm9 (polar dm9t (DTR 90.0) 891.2)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 3877.27)) (setq dm10 (polar dm10t (DTR 90.0) 889.85)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 6511.02)) (setq dm11 (polar dm11t (DTR 90.0) 6140)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 6511.02)) (setq dm12 (polar dm12t (DTR 90.0) 4555.77)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5289.76)) (setq dm13 (polar dm13t (DTR 90.0) 6023.39)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5373.16)) (setq dm14 (polar dm14t (DTR 90.0) 6023.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5461.54)) (setq dm15 (polar dm15t (DTR 90.0) 6023.39)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5290.21)) (setq dm16 (polar dm16t (DTR 90.0) 5948.39)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 5289.76)) (setq dm17 (polar dm17t (DTR 90.0) 5880.29)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 4551.54)) (setq dm18 (polar dm18t (DTR 90.0) 2551.38)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 4551.54)) (setq dm19 (polar dm19t (DTR 90.0) 2634.54)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 4551.54)) (setq dm20 (polar dm20t (DTR 90.0) 2717.7)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 5402.36)) (setq dm21 (polar dm21t (DTR 90.0) 2717.7)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5565.34)) (setq dm22 (polar dm22t (DTR 90.0) 2717.7)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 6417.58)) (setq dm23 (polar dm23t (DTR 90.0) 2717.7)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 4551.54)) (setq dm24 (polar dm24t (DTR 90.0) 2496.23)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 4551.54)) (setq dm25 (polar dm25t (DTR 90.0) 2413.07)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 4551.54)) (setq dm26 (polar dm26t (DTR 90.0) 2329.91)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 4670.34)) (setq dm27 (polar dm27t (DTR 90.0) 2329.91)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 4849.86)) (setq dm28 (polar dm28t (DTR 90.0) 2329.91)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 5484.56)) (setq dm29 (polar dm29t (DTR 90.0) 2329.91)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 6144.03)) (setq dm30 (polar dm30t (DTR 90.0) 2329.91)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 5240.07)) (setq dm31 (polar dm31t (DTR 90.0) 2089.43)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 4551.54)) (setq dm32 (polar dm32t (DTR 90.0) 1834.69)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 4551.54)) (setq dm33 (polar dm33t (DTR 90.0) 1751.53)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 4551.54)) (setq dm34 (polar dm34t (DTR 90.0) 1668.37)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 4670.34)) (setq dm35 (polar dm35t (DTR 90.0) 1668.37)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 6298.78)) (setq dm36 (polar dm36t (DTR 90.0) 1668.37)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 5167.45)) (setq dm37 (polar dm37t (DTR 90.0) 1420.4)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 8749.32)) (setq dm38 (polar dm38t (DTR 90.0) 6140)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 7895.96)) (setq dm39 (polar dm39t (DTR 90.0) 2521.19)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 8008.44)) (setq dm40 (polar dm40t (DTR 90.0) 2521.19)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 8143.16)) (setq dm41 (polar dm41t (DTR 90.0) 2521.47)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 7813.16)) (setq dm42 (polar dm42t (DTR 90.0) 2438.67)) ;b42
				(setq dm43t (polar ibp (DTR 0.0) 7813.16)) (setq dm43 (polar dm43t (DTR 90.0) 2326.19)) ;b43
				(setq dm44t (polar ibp (DTR 0.0) 7813.16)) (setq dm44 (polar dm44t (DTR 90.0) 2176.19)) ;b44
				(setq dm45t (polar ibp (DTR 0.0) 7891.1)) (setq dm45 (polar dm45t (DTR 90.0) 1965.13)) ;b45
								
				(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 190) (fix newst1_newmem1_y1))
				(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 190) (fix (- newstud1_y1 newst1_newmem1_y1)))
				(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 190) (fix (- joint_0 newstud1_y1)))
				
				(command "dim1" "hor" dm6 dm7 (polar dm6 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm9 dm10 (polar dm9 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm8 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm5 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm11 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm12 "" "" "" )				

				(command "dim1" "hor" dm13 dm14 (polar dm14 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm14 dm15 (polar dm14 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm13 dm16 (polar dm16 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm16 dm17 (polar dm16 (DTR 180.0) 47) newstud1_platey1)
				
				(command "dim1" "ver" dm24 dm25 (polar dm24 (DTR 180.0) 80) newstud1_backmark)
				(command "dim1" "hor" dm28 dm29 (polar dm29 (DTR 270.0) 139) (- newst1_joint1 40))
				(command "dim1" "hor" dm29 dm30 (polar dm29 (DTR 270.0) 139) (- newst1_joint2 40))
				(command "_insert" "f3x" dm31 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (rtos (+ (Number_Round newstud1_memlen 1) 50) 2 0) " Lg" ))
				(command "dim1" "ver" dm32 dm33 (polar dm32 (DTR 180.0) 80) newst1_newmem1_backmark)
				(command "dim1" "hor" dm35 dm36 (polar dm35 (DTR 270.0) 139) newst1_newmem1_len)
				(command "_insert" "f3x" dm37 "0.0394" "0.0394" "" "N4" (strcat newst1_newmem1_memname ".." (rtos newst1_newmem1_len 2 0) " Lg" ))
				
				(command "dim1" "hor" dm39 dm40 (polar dm40 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm40 dm41 (polar dm40 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm42 dm43 (polar dm43 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm43 dm44 (polar dm43 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm38)

				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 27.28))
				(setq total_weight (+ total_mem_weight 3.98))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_A_SOL2_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1609.69)) (setq bom1 (polar bom1t (DTR 270.0) 653.56)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1249.11)) (setq bom2 (polar bom2t (DTR 270.0) 653.56)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 865.74)) (setq bom3 (polar bom3t (DTR 270.0) 654.77)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 522.18)) (setq bom4 (polar bom4t (DTR 270.0) 654.77)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1609.69)) (setq bom5 (polar bom5t (DTR 270.0) 712.42)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1249.11)) (setq bom6 (polar bom6t (DTR 270.0) 712.42)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 844.07)) (setq bom7 (polar bom7t (DTR 270.0) 713.63)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 505.76)) (setq bom8 (polar bom8t (DTR 270.0) 713.63)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 888.34)) (setq bom9 (polar bom9t (DTR 270.0) 773.71)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 541.68)) (setq bom10 (polar bom10t (DTR 270.0) 773.71)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 899.71)) (setq bom11 (polar bom11t (DTR 270.0) 1360.69)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 553.04)) (setq bom12 (polar bom12t (DTR 270.0) 1360.69)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 899.71)) (setq bom13 (polar bom13t (DTR 270.0) 1488.16)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 553.04)) (setq bom14 (polar bom14t (DTR 270.0) 1488.16)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 675.55)) (setq bom15 (polar bom15t (DTR 270.0) 1545.38)) ;aa15
				
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
				
				(command "TEXT" bom15 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom9 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom10 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom11 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom12 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom13 "0" (rtos total_weight 2 2))
				(command "TEXT" bom14 "0" (rtos (* total_weight 1.035) 2 2))
				
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)
		))	
		
		(if (and (= newstudnum 1) (= newstud1_memty "A") (= newst_mem_onpole 1) (= newst_mem_onstruct 1) (= newst1_newmem1_type "A") (= hip_mem 1) (= hip_mem1_type "A") ) (progn
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				;(command "_insert" "IN-6.0M-RIT-CNTR-MP_A_SOL3" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 914.83)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 914.83)) (setq dm2 (polar dm2t (DTR 90.0) 3423.68)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 892.2)) (setq dm3 (polar dm3t (DTR 90.0) 4891.84)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 967.44)) (setq dm4 (polar dm4t (DTR 90.0) 5829.96)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 1976.06)) (setq dm5 (polar dm5t (DTR 90.0) 1539.67)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 3131.25)) (setq dm6 (polar dm6t (DTR 90.0) 2000.29)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 1648.22)) (setq dm7 (polar dm7t (DTR 90.0) 1877.72)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 2773.22)) (setq dm8 (polar dm8t (DTR 90.0) 1877.72)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 2799.95)) (setq dm9 (polar dm9t (DTR 90.0) 925.05)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 3470.14)) (setq dm10 (polar dm10t (DTR 90.0) 863.29)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 6511.7)) (setq dm11 (polar dm11t (DTR 90.0) 6140)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 5290.44)) (setq dm12 (polar dm12t (DTR 90.0) 6023.39)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 5373.84)) (setq dm13 (polar dm13t (DTR 90.0) 6023.39)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5462.22)) (setq dm14 (polar dm14t (DTR 90.0) 6023.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5290.89)) (setq dm15 (polar dm15t (DTR 90.0) 5948.39)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5290.44)) (setq dm16 (polar dm16t (DTR 90.0) 5880.29)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 6511.7)) (setq dm17 (polar dm17t (DTR 90.0) 4555.77)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 4551.54)) (setq dm18 (polar dm18t (DTR 90.0) 2635.1)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 4551.54)) (setq dm19 (polar dm19t (DTR 90.0) 2718.26)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 4551.54)) (setq dm20 (polar dm20t (DTR 90.0) 2801.42)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 5402.36)) (setq dm21 (polar dm21t (DTR 90.0) 2718.26)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5565.34)) (setq dm22 (polar dm22t (DTR 90.0) 2718.26)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 6417.58)) (setq dm23 (polar dm23t (DTR 90.0) 2801.42)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 4551.54)) (setq dm24 (polar dm24t (DTR 90.0) 2579.95)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 4551.54)) (setq dm25 (polar dm25t (DTR 90.0) 2496.79)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 4849.86)) (setq dm26 (polar dm26t (DTR 90.0) 2413.63)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 5484.56)) (setq dm27 (polar dm27t (DTR 90.0) 2413.63)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 6144.03)) (setq dm28 (polar dm28t (DTR 90.0) 2413.63)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 5240.07)) (setq dm29 (polar dm29t (DTR 90.0) 2228.27)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 4551.54)) (setq dm30 (polar dm30t (DTR 90.0) 2016.59)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 4551.54)) (setq dm31 (polar dm31t (DTR 90.0) 1933.43)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 4670.34)) (setq dm32 (polar dm32t (DTR 90.0) 1850.27)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 6298.78)) (setq dm33 (polar dm33t (DTR 90.0) 1850.27)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 5167.45)) (setq dm34 (polar dm34t (DTR 90.0) 1654.23)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 4395.29)) (setq dm35 (polar dm35t (DTR 90.0) 449.1)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 4395.29)) (setq dm36 (polar dm36t (DTR 90.0) 532.26)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 4514.09)) (setq dm37 (polar dm37t (DTR 90.0) 386.1)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 6142.54)) (setq dm38 (polar dm38t (DTR 90.0) 386.1)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 5083.82)) (setq dm39 (polar dm39t (DTR 90.0) 157.78)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 4396.04)) (setq dm40 (polar dm40t (DTR 90.0) 1580.37)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 4681.41)) (setq dm41 (polar dm41t (DTR 90.0) 1307.63)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 4882.25)) (setq dm42 (polar dm42t (DTR 90.0) 1307.63)) ;b42
				(setq dm43t (polar ibp (DTR 0.0) 5131.48)) (setq dm43 (polar dm43t (DTR 90.0) 1580.37)) ;b43
				(setq dm44t (polar ibp (DTR 0.0) 4500.33)) (setq dm44 (polar dm44t (DTR 90.0) 1498.96)) ;b44
				(setq dm45t (polar ibp (DTR 0.0) 4681.41)) (setq dm45 (polar dm45t (DTR 90.0) 1008.18)) ;b45
				(setq dm46t (polar ibp (DTR 0.0) 4785.77)) (setq dm46 (polar dm46t (DTR 90.0) 1008.18)) ;b46
				(setq dm47t (polar ibp (DTR 0.0) 4882.25)) (setq dm47 (polar dm47t (DTR 90.0) 1008.18)) ;b47
				(setq dm48t (polar ibp (DTR 0.0) 4976.92)) (setq dm48 (polar dm48t (DTR 90.0) 1498.96)) ;b48
				(setq dm49t (polar ibp (DTR 0.0) 5114.05)) (setq dm49 (polar dm49t (DTR 90.0) 1008.18)) ;b49
				(setq dm50t (polar ibp (DTR 0.0) 4457.5)) (setq dm50 (polar dm50t (DTR 90.0) 1008.18)) ;b50
				(setq dm51t (polar ibp (DTR 0.0) 5114.05)) (setq dm51 (polar dm51t (DTR 90.0) 1008.18)) ;b51
				(setq dm52t (polar ibp (DTR 0.0) 4480.13)) (setq dm52 (polar dm52t (DTR 90.0) 716.48)) ;b52
				(setq dm53t (polar ibp (DTR 0.0) 8750)) (setq dm53 (polar dm53t (DTR 90.0) 6140)) ;b53
				(setq dm54t (polar ibp (DTR 0.0) 7895.96)) (setq dm54 (polar dm54t (DTR 90.0) 2522.83)) ;b54
				(setq dm55t (polar ibp (DTR 0.0) 8008.44)) (setq dm55 (polar dm55t (DTR 90.0) 2523.12)) ;b55
				(setq dm56t (polar ibp (DTR 0.0) 8143.16)) (setq dm56 (polar dm56t (DTR 90.0) 2523.12)) ;b56
				(setq dm57t (polar ibp (DTR 0.0) 7813.16)) (setq dm57 (polar dm57t (DTR 90.0) 2440.32)) ;b57
				(setq dm58t (polar ibp (DTR 0.0) 7813.16)) (setq dm58 (polar dm58t (DTR 90.0) 2327.83)) ;b58
				(setq dm59t (polar ibp (DTR 0.0) 7813.16)) (setq dm59 (polar dm59t (DTR 90.0) 2177.83)) ;b59

				(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 190) (fix newst1_newmem1_y1))
				(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 190) (fix (- newstud1_y1 newst1_newmem1_y1)))
				(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 190) (fix (- joint_0 newstud1_y1)))
				
				(command "dim1" "hor" dm7 dm8 (polar dm7 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm9 dm10 (polar dm9 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm5 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm6 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm11 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm17 "" "" "" )				

				(command "dim1" "hor" dm12 dm13 (polar dm13 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm13 dm14 (polar dm13 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm12 dm15 (polar dm15 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm15 dm16 (polar dm15 (DTR 180.0) 47) newstud1_platey1)				
                ;top flange
				(command "dim1" "ver" dm18 dm19 (polar dm18 (DTR 180.0) 80) newstud1_backmark)
				(command "dim1" "hor" dm20 dm21 (polar dm20 (DTR 90.0) 65) (rtos (Number_Round newst1_joint1 1) 2 0))
				(command "dim1" "hor" dm22 dm23 (polar dm23 (DTR 90.0) 65) (rtos (Number_Round newst1_joint2 1) 2 0))
				;bottom flange
				(command "dim1" "ver" dm24 dm25 (polar dm24 (DTR 180.0) 80) newstud1_backmark)
				(command "dim1" "hor" dm26 dm27 (polar dm26 (DTR 270.0) 139) (- newst1_joint1 40))
				(command "dim1" "hor" dm27 dm28 (polar dm27 (DTR 270.0) 139) (- newst1_joint2 40))
				(command "_insert" "f3x" dm29 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (rtos (+ (Number_Round newstud1_memlen 1) 50) 2 0) " Lg" ))
				
				(command "dim1" "ver" dm30 dm31 (polar dm30 (DTR 180.0) 80) newst1_newmem1_backmark)
				(command "dim1" "hor" dm32 dm33 (polar dm33 (DTR 270.0) 139) newst1_newmem1_len)
				(command "_insert" "f3x" dm34 "0.0394" "0.0394" "" "N4" (strcat newst1_newmem1_memname ".." (rtos newst1_newmem1_len 2 0) " Lg" ))
				
				;hip
				(command "dim1" "hor" dm41 dm42 (polar dm41 (DTR 90.0) 71.5) (rtos (+ newst1_size 20) 2 0))
				(command "dim1" "hor" dm45 dm46 (polar dm46 (DTR 270.0) 86) (rtos (+ newstud1_backmark 10) 2 0))
				(command "dim1" "hor" dm46 dm47 (polar dm46 (DTR 270.0) 86) (rtos (- (+ newst1_size 20) (+ newstud1_backmark 10)) 2 0))
				
				(command "dim1" "hor" dm50 dm51 (polar dm50 (DTR 270.0) 173) (rtos (+ (+ newst1_size 20) 130) 2 0))
				(command "_insert" "f3x" dm52 "0.0394" "0.0394" "" "N6" (strcat "PLT.." (rtos (fix clampstk) 2 0) "x100x" (rtos (+ (+ newst1_size 20) 130) 2 0)))
				(command "style" "standard" "simplex" (* 2.0 sf) "0.8" "" "" "" "")
				(defun tan (z / cosz)
				(if (zerop (setq cosz (cos z)))
				9.7e307
				(/ (sin z) cosz)
				))
				(command "TEXT" dm44 "0" "1000")
				(command "TEXT" dm48 "0" "1000")
				(command "TEXT" dm40 "0" (rtos (Number_Round (* (tan (dtr newstud1_hipmem1_ang1)) 1000) 1) 2 0))
				(command "TEXT" dm43 "0" (rtos (Number_Round (* (tan (dtr newstud1_hipmem1_ang1)) 1000) 1) 2 0))
				
				(command "dim1" "ver" dm35 dm36 (polar dm35 (DTR 180.) 80) (fix newstud1_hipmem1_backmark))
				(command "dim1" "hor" dm37 dm38 (polar dm37 (DTR 270.0) 113) newstud1_hipmem1_len)
				(command "_insert" "f3x" dm39 "0.0394" "0.0394" "" "N5" (strcat newstud1_hipmem1_memname ".." (rtos (+ newstud1_hipmem1_len 50) 2 0) " Lg"))
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm54 dm55 (polar dm55 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm55 dm56 (polar dm55 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm57 dm58 (polar dm58 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm58 dm59 (polar dm58 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm53)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N6 (* (/ clampstk 1000.0 )(/ 100 1000.0) (/ (Number_Round (rtos (+ (+ newst1_size 20) 130) 2 0) 1) 1000.0) 7850.0 3))
				(setq N5 (* (/ (Number_Round (+ newstud1_hipmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 N6 27.43))
				(setq total_weight (+ total_mem_weight 6.5))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_A_SOL3_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1609.69)) (setq bom1 (polar bom1t (DTR 270.0) 653.56)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1249.11)) (setq bom2 (polar bom2t (DTR 270.0) 653.56)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 877.4)) (setq bom3 (polar bom3t (DTR 270.0) 654.77)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 522.18)) (setq bom4 (polar bom4t (DTR 270.0) 654.77)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1609.69)) (setq bom5 (polar bom5t (DTR 270.0) 712.42)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1249.11)) (setq bom6 (polar bom6t (DTR 270.0) 712.42)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 854.23)) (setq bom7 (polar bom7t (DTR 270.0) 713.64)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 505.76)) (setq bom8 (polar bom8t (DTR 270.0) 713.64)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1609.69)) (setq bom9 (polar bom9t (DTR 270.0) 773.71)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1249.11)) (setq bom10 (polar bom10t (DTR 270.0) 773.71)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 857.09)) (setq bom11 (polar bom11t (DTR 270.0) 774.93)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 510.42)) (setq bom12 (polar bom12t (DTR 270.0) 774.93)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 1609.69)) (setq bom13 (polar bom13t (DTR 270.0) 832.57)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 1249.11)) (setq bom14 (polar bom14t (DTR 270.0) 832.57)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 857.35)) (setq bom15 (polar bom15t (DTR 270.0) 833.79)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 520.16)) (setq bom16 (polar bom16t (DTR 270.0) 833.79)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 888.34)) (setq bom17 (polar bom17t (DTR 270.0) 890.88)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 541.68)) (setq bom18 (polar bom18t (DTR 270.0) 890.88)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 899.71)) (setq bom19 (polar bom19t (DTR 270.0) 1360.7)) ;aa19
				(setq bom20t (polar ibom (DTR 180.0) 553.04)) (setq bom20 (polar bom20t (DTR 270.0) 1360.7)) ;aa20
				(setq bom21t (polar ibom (DTR 180.0) 899.71)) (setq bom21 (polar bom21t (DTR 270.0) 1488.16)) ;aa21
				(setq bom22t (polar ibom (DTR 180.0) 553.04)) (setq bom22 (polar bom22t (DTR 270.0) 1488.16)) ;aa22
				(setq bom23t (polar ibom (DTR 180.0) 677.92)) (setq bom23 (polar bom23t (DTR 270.0) 1548.6)) ;aa23
				
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
						
				(command "TEXT" bom9 "0" newstud1_hipmem1_memname)
				(command "TEXT" bom10 "0" (itoa (Number_Round (+ newstud1_hipmem1_len 50) 1)))
				(command "TEXT" bom11 "0" (rtos N5 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N5 ) 2 2))
				
				(command "TEXT" bom13 "0" (strcat "PLT.." (rtos (fix clampstk) 2 0) "x100x" (rtos (+ (+ newst1_size 20) 130) 2 0)))
				(command "TEXT" bom14 "0" (rtos (+ (+ newst1_size 20) 130) 2 0))
				(command "TEXT" bom15 "0" (rtos N6 2 2))
				(command "TEXT" bom16 "0" (rtos (* 1.035 N6 ) 2 2))
				
				(command "TEXT" bom23 "0" (rtos concrete_vol 2 3))	
				
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom17 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom18 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom19 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom20 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom21 "0" (rtos total_weight 2 2))
				(command "TEXT" bom22 "0" (rtos (* total_weight 1.035) 2 2))
				
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)
				
		))
		
		(if (and (= newstudnum 1) (= newstud1_memty "A") (= newst_mem_onpole 2) (= newst_mem_onstruct 2) (= newst1_newmem1_type "A") (= hip_mem 0) ) (progn
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/bolckss/IN-6.0M-RIT-CNTR-MP_A_SOL4" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 959.95)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 840.33)) (setq dm2 (polar dm2t (DTR 90.0) 2936.51)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 840.33)) (setq dm3 (polar dm3t (DTR 90.0) 3903.65)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 817.7)) (setq dm4 (polar dm4t (DTR 90.0) 4891.84)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 892.94)) (setq dm5 (polar dm5t (DTR 90.0) 5829.96)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1899.15)) (setq dm6 (polar dm6t (DTR 90.0) 1539.67)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 3056.75)) (setq dm7 (polar dm7t (DTR 90.0) 2000.29)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 1573.72)) (setq dm8 (polar dm8t (DTR 90.0) 1877.72)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 2698.72)) (setq dm9 (polar dm9t (DTR 90.0) 1877.72)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 2961.27)) (setq dm10 (polar dm10t (DTR 90.0) 891.2)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 3636.27)) (setq dm11 (polar dm11t (DTR 90.0) 889.85)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 6511.7)) (setq dm12 (polar dm12t (DTR 90.0) 6140)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 6511.7)) (setq dm13 (polar dm13t (DTR 90.0) 4555.77)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5290.44)) (setq dm14 (polar dm14t (DTR 90.0) 6023.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5373.84)) (setq dm15 (polar dm15t (DTR 90.0) 6023.39)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5462.22)) (setq dm16 (polar dm16t (DTR 90.0) 6023.39)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 5290.89)) (setq dm17 (polar dm17t (DTR 90.0) 5948.39)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 5290.44)) (setq dm18 (polar dm18t (DTR 90.0) 5880.29)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 4481.99)) (setq dm19 (polar dm19t (DTR 90.0) 1723.56)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 4481.99)) (setq dm20 (polar dm20t (DTR 90.0) 1640.4)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 4780.31)) (setq dm21 (polar dm21t (DTR 90.0) 1557.24)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5127.16)) (setq dm22 (polar dm22t (DTR 90.0) 1557.24)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 5748.48)) (setq dm23 (polar dm23t (DTR 90.0) 1557.24)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 6074.49)) (setq dm24 (polar dm24t (DTR 90.0) 1557.24)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 5170.52)) (setq dm25 (polar dm25t (DTR 90.0) 1271.54)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 4681.66)) (setq dm26 (polar dm26t (DTR 90.0) 2570.87)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 4681.66)) (setq dm27 (polar dm27t (DTR 90.0) 2487.71)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 4800.46)) (setq dm28 (polar dm28t (DTR 90.0) 2404.55)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 6029.57)) (setq dm29 (polar dm29t (DTR 90.0) 2404.55)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 5186.09)) (setq dm30 (polar dm30t (DTR 90.0) 2120.08)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 4642.07)) (setq dm31 (polar dm31t (DTR 90.0) 911.61)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 4642.07)) (setq dm32 (polar dm32t (DTR 90.0) 828.45)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 4760.87)) (setq dm33 (polar dm33t (DTR 90.0) 765.45)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 6069.16)) (setq dm34 (polar dm34t (DTR 90.0) 765.45)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 5137.2)) (setq dm35 (polar dm35t (DTR 90.0) 534.54)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 7900.62)) (setq dm36 (polar dm36t (DTR 90.0) 2512.14)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 8013.1)) (setq dm37 (polar dm37t (DTR 90.0) 2512.14)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 8147.82)) (setq dm38 (polar dm38t (DTR 90.0) 2512.42)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 7817.82)) (setq dm39 (polar dm39t (DTR 90.0) 2429.62)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 7817.82)) (setq dm40 (polar dm40t (DTR 90.0) 2317.14)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 7817.82)) (setq dm41 (polar dm41t (DTR 90.0) 2167.14)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 8750)) (setq dm42 (polar dm42t (DTR 90.0) 6140)) ;b42
				
				(if(< newst1_newmem1_y1 newst1_newmem2_y1) 
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem1_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem2_y1 newst1_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem2_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				(if(< newst1_newmem2_y1 newst1_newmem1_y1) 
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem2_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem1_y1 newst2_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem1_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				
				(command "dim1" "hor" dm8 dm9 (polar dm6 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm10 dm11 (polar dm10 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm6 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm7 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm12 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm13 "" "" "" )				

				(command "dim1" "hor" dm14 dm15 (polar dm15 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm15 dm16 (polar dm15 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm14 dm17 (polar dm17 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm17 dm18 (polar dm17 (DTR 180.0) 47) newstud1_platey1)
				
				(command "dim1" "ver" dm19 dm20 (polar dm20 (DTR 180.0) 80) newstud1_backmark)
				(command "dim1" "hor" dm21 dm22 (polar dm22 (DTR 270.0) 157) (- newst1_joint1 40))
				(command "dim1" "hor" dm22 dm23 (polar dm22 (DTR 270.0) 157) newst1_joint2)
				(command "dim1" "hor" dm23 dm24 (polar dm23 (DTR 270.0) 157) (- newst1_joint3 40))
				(command "_insert" "f3x" dm25 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (itoa (Number_Round (+ newstud1_memlen 50) 1)) " Lg"))
				
				(command "dim1" "ver" dm26 dm27 (polar dm26 (DTR 180.0) 80) newst1_newmem1_backmark)
				(command "dim1" "hor" dm28 dm29 (polar dm28 (DTR 270.0) 139) newst1_newmem1_len)
				(command "_insert" "f3x" dm30 "0.0394" "0.0394" "" "N4" (strcat newstud1_memname ".." (itoa (Number_Round (+ newst1_newmem1_len 50) 1)) " Lg"))
				
				(command "dim1" "ver" dm31 dm32 (polar dm32 (DTR 180.0) 80) newst1_newmem2_backmark)
				(command "dim1" "hor" dm33 dm34 (polar dm33 (DTR 270.0) 139) newst1_newmem2_len)
				(command "_insert" "f3x" dm35 "0.0394" "0.0394" "" "N6" (strcat newstud1_memname ".." (itoa (Number_Round (+ newst2_newmem1_len 50) 1)) " Lg"))
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm36 dm37 (polar dm37 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm37 dm38 (polar dm37 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm39 dm40 (polar dm40 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm40 dm41 (polar dm40 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm42)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N5 (* (/ (Number_Round (+ newst1_newmem2_len 50) 1) 1000.0) newst1_newmem2_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 27.43))
				(setq total_weight (+ total_mem_weight 4.3))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_P_SOL4_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1609.69)) (setq bom1 (polar bom1t (DTR 270.0) 653.56)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1249.11)) (setq bom2 (polar bom2t (DTR 270.0) 653.56)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 865.74)) (setq bom3 (polar bom3t (DTR 270.0) 654.77)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 522.18)) (setq bom4 (polar bom4t (DTR 270.0) 654.77)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1609.69)) (setq bom5 (polar bom5t (DTR 270.0) 712.42)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1249.11)) (setq bom6 (polar bom6t (DTR 270.0) 712.42)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 844.07)) (setq bom7 (polar bom7t (DTR 270.0) 713.64)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 505.76)) (setq bom8 (polar bom8t (DTR 270.0) 713.64)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1609.69)) (setq bom9 (polar bom9t (DTR 270.0) 771.28)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1249.11)) (setq bom10 (polar bom10t (DTR 270.0) 771.28)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 844.07)) (setq bom11 (polar bom11t (DTR 270.0) 772.5)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 505.76)) (setq bom12 (polar bom12t (DTR 270.0) 772.5)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 888.34)) (setq bom13 (polar bom13t (DTR 270.0) 835.82)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 541.67)) (setq bom14 (polar bom14t (DTR 270.0) 835.82)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 899.71)) (setq bom15 (polar bom15t (DTR 270.0) 1360.7)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 553.04)) (setq bom16 (polar bom16t (DTR 270.0) 1360.7)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 899.71)) (setq bom17 (polar bom17t (DTR 270.0) 1488.16)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 553.04)) (setq bom18 (polar bom18t (DTR 270.0) 1488.16)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 664.26)) (setq bom19 (polar bom19t (DTR 270.0) 1545.88)) ;aa19
								
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
				
				(command "TEXT" bom9 "0" newst1_newmem2_memname)
				(command "TEXT" bom10 "0" (itoa (Number_Round (+ newst1_newmem2_len 50) 1)))
				(command "TEXT" bom11 "0" (rtos N6 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N6 ) 2 2))
				
				(command "TEXT" bom19 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom13 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom14 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom15 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom16 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom17 "0" (rtos total_weight 2 2))
				(command "TEXT" bom18 "0" (rtos (* total_weight 1.035) 2 2))
				
				
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)

		))
		
		(if (and (= newstudnum 1) (= newstud1_memty "A") (= newst_mem_onpole 2) (= newst_mem_onstruct 2) (= newst1_newmem1_type "A") (= hip_mem 2) (= hip_mem1_type "A") ) (progn
				
				(if (= ibp nil) (setq ibp '(0.0 0.0 0.0)))
				(if (= polenumber nil) (setq polenumber 1) (setq polenumber (1+ polenumber)))
				(command "_insert" "c:/detail/bolckss/IN-6.0M-RIT-CNTR-MP_A_SOL5" ibp "" "" "" )
				
				(setq dm1t (polar ibp (DTR 0.0) 739.68)) (setq dm1 (polar dm1t (DTR 90.0) 2079.96)) ;b1
				(setq dm2t (polar ibp (DTR 0.0) 739.68)) (setq dm2 (polar dm2t (DTR 90.0) 2936.51)) ;b2
				(setq dm3t (polar ibp (DTR 0.0) 739.68)) (setq dm3 (polar dm3t (DTR 90.0) 3903.65)) ;b3
				(setq dm4t (polar ibp (DTR 0.0) 717.05)) (setq dm4 (polar dm4t (DTR 90.0) 4891.84)) ;b4
				(setq dm5t (polar ibp (DTR 0.0) 792.28)) (setq dm5 (polar dm5t (DTR 90.0) 5829.96)) ;b5
				(setq dm6t (polar ibp (DTR 0.0) 1800.9)) (setq dm6 (polar dm6t (DTR 90.0) 1539.67)) ;b6
				(setq dm7t (polar ibp (DTR 0.0) 2956.1)) (setq dm7 (polar dm7t (DTR 90.0) 2000.29)) ;b7
				(setq dm8t (polar ibp (DTR 0.0) 1473.07)) (setq dm8 (polar dm8t (DTR 90.0) 1877.72)) ;b8
				(setq dm9t (polar ibp (DTR 0.0) 2598.07)) (setq dm9 (polar dm9t (DTR 90.0) 1877.72)) ;b9
				(setq dm10t (polar ibp (DTR 0.0) 2505.71)) (setq dm10 (polar dm10t (DTR 90.0) 891.2)) ;b10
				(setq dm11t (polar ibp (DTR 0.0) 3172.16)) (setq dm11 (polar dm11t (DTR 90.0) 884.81)) ;b11
				(setq dm12t (polar ibp (DTR 0.0) 6521.7)) (setq dm12 (polar dm12t (DTR 90.0) 6140)) ;b12
				(setq dm13t (polar ibp (DTR 0.0) 6521.7)) (setq dm13 (polar dm13t (DTR 90.0) 4555.77)) ;b13
				(setq dm14t (polar ibp (DTR 0.0) 5300.44)) (setq dm14 (polar dm14t (DTR 90.0) 6023.39)) ;b14
				(setq dm15t (polar ibp (DTR 0.0) 5383.84)) (setq dm15 (polar dm15t (DTR 90.0) 6023.39)) ;b15
				(setq dm16t (polar ibp (DTR 0.0) 5472.22)) (setq dm16 (polar dm16t (DTR 90.0) 6023.39)) ;b16
				(setq dm17t (polar ibp (DTR 0.0) 5300.89)) (setq dm17 (polar dm17t (DTR 90.0) 5948.39)) ;b17
				(setq dm18t (polar ibp (DTR 0.0) 5300.44)) (setq dm18 (polar dm18t (DTR 90.0) 5880.29)) ;b18
				(setq dm19t (polar ibp (DTR 0.0) 4621.56)) (setq dm19 (polar dm19t (DTR 90.0) 2236.71)) ;b19
				(setq dm20t (polar ibp (DTR 0.0) 4621.56)) (setq dm20 (polar dm20t (DTR 90.0) 2319.87)) ;b20
				(setq dm21t (polar ibp (DTR 0.0) 4621.56)) (setq dm21 (polar dm21t (DTR 90.0) 2403.03)) ;b21
				(setq dm22t (polar ibp (DTR 0.0) 5190.51)) (setq dm22 (polar dm22t (DTR 90.0) 2319.87)) ;b22
				(setq dm23t (polar ibp (DTR 0.0) 5353.48)) (setq dm23 (polar dm23t (DTR 90.0) 2319.87)) ;b23
				(setq dm24t (polar ibp (DTR 0.0) 5756.57)) (setq dm24 (polar dm24t (DTR 90.0) 2319.87)) ;b24
				(setq dm25t (polar ibp (DTR 0.0) 5919.55)) (setq dm25 (polar dm25t (DTR 90.0) 2319.87)) ;b25
				(setq dm26t (polar ibp (DTR 0.0) 6486.18)) (setq dm26 (polar dm26t (DTR 90.0) 2403.03)) ;b26
				(setq dm27t (polar ibp (DTR 0.0) 4621.56)) (setq dm27 (polar dm27t (DTR 90.0) 2145.88)) ;b27
				(setq dm28t (polar ibp (DTR 0.0) 4621.56)) (setq dm28 (polar dm28t (DTR 90.0) 2062.72)) ;b28
				(setq dm29t (polar ibp (DTR 0.0) 4919.88)) (setq dm29 (polar dm29t (DTR 90.0) 1979.56)) ;b29
				(setq dm30t (polar ibp (DTR 0.0) 5266.72)) (setq dm30 (polar dm30t (DTR 90.0) 1979.56)) ;b30
				(setq dm31t (polar ibp (DTR 0.0) 5888.04)) (setq dm31 (polar dm31t (DTR 90.0) 1979.56)) ;b31
				(setq dm32t (polar ibp (DTR 0.0) 6214.05)) (setq dm32 (polar dm32t (DTR 90.0) 1979.56)) ;b32
				(setq dm33t (polar ibp (DTR 0.0) 5310.09)) (setq dm33 (polar dm33t (DTR 90.0) 1692.74)) ;b33
				(setq dm34t (polar ibp (DTR 0.0) 4550.82)) (setq dm34 (polar dm34t (DTR 90.0) 1333.78)) ;b34
				(setq dm35t (polar ibp (DTR 0.0) 4550.82)) (setq dm35 (polar dm35t (DTR 90.0) 1416.94)) ;b35
				(setq dm36t (polar ibp (DTR 0.0) 4669.62)) (setq dm36 (polar dm36t (DTR 90.0) 1270.78)) ;b36
				(setq dm37t (polar ibp (DTR 0.0) 5352.2)) (setq dm37 (polar dm37t (DTR 90.0) 1270.78)) ;b37
				(setq dm38t (polar ibp (DTR 0.0) 4750.03)) (setq dm38 (polar dm38t (DTR 90.0) 1042.46)) ;b38
				(setq dm39t (polar ibp (DTR 0.0) 4550.82)) (setq dm39 (polar dm39t (DTR 90.0) 652.74)) ;b39
				(setq dm40t (polar ibp (DTR 0.0) 4550.82)) (setq dm40 (polar dm40t (DTR 90.0) 735.9)) ;b40
				(setq dm41t (polar ibp (DTR 0.0) 4669.62)) (setq dm41 (polar dm41t (DTR 90.0) 589.73)) ;b41
				(setq dm42t (polar ibp (DTR 0.0) 5352.2)) (setq dm42 (polar dm42t (DTR 90.0) 589.73)) ;b42
				(setq dm43t (polar ibp (DTR 0.0) 4750.03)) (setq dm43 (polar dm43t (DTR 90.0) 376.24)) ;b43
				(setq dm44t (polar ibp (DTR 0.0) 5603.61)) (setq dm44 (polar dm44t (DTR 90.0) 1416.94)) ;b44
				(setq dm45t (polar ibp (DTR 0.0) 5603.61)) (setq dm45 (polar dm45t (DTR 90.0) 1333.78)) ;b45
				(setq dm46t (polar ibp (DTR 0.0) 5722.41)) (setq dm46 (polar dm46t (DTR 90.0) 1270.78)) ;b46
				(setq dm47t (polar ibp (DTR 0.0) 6404.98)) (setq dm47 (polar dm47t (DTR 90.0) 1270.78)) ;b47
				(setq dm48t (polar ibp (DTR 0.0) 5802.81)) (setq dm48 (polar dm48t (DTR 90.0) 1042.46)) ;b48
				(setq dm49t (polar ibp (DTR 0.0) 5603.61)) (setq dm49 (polar dm49t (DTR 90.0) 735.9)) ;b49
				(setq dm50t (polar ibp (DTR 0.0) 5603.61)) (setq dm50 (polar dm50t (DTR 90.0) 652.74)) ;b50
				(setq dm51t (polar ibp (DTR 0.0) 5722.41)) (setq dm51 (polar dm51t (DTR 90.0) 589.73)) ;b51
				(setq dm52t (polar ibp (DTR 0.0) 6404.98)) (setq dm52 (polar dm52t (DTR 90.0) 573.48)) ;b52
				(setq dm53t (polar ibp (DTR 0.0) 5802.81)) (setq dm53 (polar dm53t (DTR 90.0) 376.24)) ;b53
				(setq dm54t (polar ibp (DTR 0.0) 3813.48)) (setq dm54 (polar dm54t (DTR 90.0) 1030.6)) ;b54
				(setq dm55t (polar ibp (DTR 0.0) 4014.32)) (setq dm55 (polar dm55t (DTR 90.0) 1030.6)) ;b55
				(setq dm56t (polar ibp (DTR 0.0) 3813.39)) (setq dm56 (polar dm56t (DTR 90.0) 731.15)) ;b56
				(setq dm57t (polar ibp (DTR 0.0) 3917.84)) (setq dm57 (polar dm57t (DTR 90.0) 731.15)) ;b57
				(setq dm58t (polar ibp (DTR 0.0) 4014.32)) (setq dm58 (polar dm58t (DTR 90.0) 731.15)) ;b58
				(setq dm59t (polar ibp (DTR 0.0) 3589.56)) (setq dm59 (polar dm59t (DTR 90.0) 731.15)) ;b59
				(setq dm60t (polar ibp (DTR 0.0) 4246.11)) (setq dm60 (polar dm60t (DTR 90.0) 731.15)) ;b60
				(setq dm61t (polar ibp (DTR 0.0) 3612.2)) (setq dm61 (polar dm61t (DTR 90.0) 439.46)) ;b61
				(setq dm62t (polar ibp (DTR 0.0) 3632.4)) (setq dm62 (polar dm62t (DTR 90.0) 1221.94)) ;b62
				(setq dm63t (polar ibp (DTR 0.0) 4108.98)) (setq dm63 (polar dm63t (DTR 90.0) 1221.94)) ;b63
				(setq dm64t (polar ibp (DTR 0.0) 3528.11)) (setq dm64 (polar dm64t (DTR 90.0) 1303.35)) ;b64
				(setq dm65t (polar ibp (DTR 0.0) 4263.54)) (setq dm65 (polar dm65t (DTR 90.0) 1303.35)) ;b65
				(setq dm66t (polar ibp (DTR 0.0) 7880.85)) (setq dm66 (polar dm66t (DTR 90.0) 2439.15)) ;b66
				(setq dm67t (polar ibp (DTR 0.0) 7993.34)) (setq dm67 (polar dm67t (DTR 90.0) 2439.15)) ;b67
				(setq dm68t (polar ibp (DTR 0.0) 8128.05)) (setq dm68 (polar dm68t (DTR 90.0) 2439.43)) ;b68
				(setq dm69t (polar ibp (DTR 0.0) 7798.05)) (setq dm69 (polar dm69t (DTR 90.0) 2356.63)) ;b69
				(setq dm70t (polar ibp (DTR 0.0) 7798.05)) (setq dm70 (polar dm70t (DTR 90.0) 2244.15)) ;b70
				(setq dm71t (polar ibp (DTR 0.0) 7798.05)) (setq dm71 (polar dm71t (DTR 90.0) 2094.15)) ;b71
				(setq dm72t (polar ibp (DTR 0.0) 8760)) (setq dm72 (polar dm72t (DTR 90.0) 6150)) ;b72

				
				(if(< newst1_newmem1_y1 newst1_newmem2_y1)
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem1_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem2_y1 newst1_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem2_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				(if(< newst1_newmem2_y1 newst1_newmem1_y1)
					(progn 
						(command "dim1" "ver" dm1 dm2 (polar dm1 (DTR 180.0) 140) (fix newst1_newmem2_y1))
						(command "dim1" "ver" dm2 dm3 (polar dm1 (DTR 180.0) 140) (- newst1_newmem1_y1 newst2_newmem1_y1))
						(command "dim1" "ver" dm3 dm4 (polar dm1 (DTR 180.0) 140) (fix (- newstud1_y1 newst1_newmem1_y1)))
						(command "dim1" "ver" dm4 dm5 (polar dm1 (DTR 180.0) 140) (fix (- joint_0 newstud1_y1)))
					)
				)
				
				(command "dim1" "hor" dm8 dm9 (polar dm8 (DTR 270.0) 160) (fix newstud1_x1 ))
				(command "dim1" "hor" dm10 dm11 (polar dm10 (DTR 270.0) 170) (fix newstud1_x1))
				
				(command "style" "TRB" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" dm7 "0" (strcat (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdwt 2 0 ) "x" (rtos newstud1_pdht 2 0 )))
				(command "TEXT" dm6 "0" (strcat "(POLE-" (itoa polenumber) ")"))
				(command "_insert" "c:/detail/POLEDATA/POLE-L4_120x3" dm12 "" "" "" )				
				(command "_insert" "c:/detail/POLEDATA/POLE-L14_120x3" dm13 "" "" "" )				

				(command "dim1" "hor" dm14 dm15 (polar dm15 (DTR 90.0) 42.5) newstud1_platex2)
				(command "dim1" "hor" dm15 dm16 (polar dm15 (DTR 90.0) 42.5) newstud1_platex1)
				(command "dim1" "ver" dm14 dm17 (polar dm17 (DTR 180.0) 47) newstud1_platey2)
				(command "dim1" "ver" dm17 dm18 (polar dm17 (DTR 180.0) 47) newstud1_platey1)
				;===================================================
				(command "dim1" "ver" dm19 dm20 (polar dm20 (DTR 180.0) 80) newstud1_backmark)
				(command "dim1" "hor" dm21 dm22 (polar dm21 (DTR 90.0) 65) newst1_joint1)
				(command "dim1" "hor" dm23 dm24 (polar dm24 (DTR 90.0) 148) (- newst1_joint2 50))
				(command "dim1" "hor" dm25 dm26 (polar dm26 (DTR 90.0) 65) newst1_joint3)
				
				(command "dim1" "ver" dm27 dm28 (polar dm28 (DTR 180.0) 80) newstud1_backmark)
				(command "dim1" "hor" dm29 dm30 (polar dm30 (DTR 270.0) 139) (- newst1_joint1 40))
				(command "dim1" "hor" dm30 dm31 (polar dm31 (DTR 270.0) 139) newst1_joint2)
				(command "dim1" "hor" dm31 dm32 (polar dm31 (DTR 270.0) 139) (- newst1_joint3 40))
				(command "_insert" "f3x" dm33 "0.0394" "0.0394" "" "N3" (strcat newstud1_memname ".." (rtos (+ (Number_Round newstud1_memlen 1) 50) 2 0) " Lg" ))
				
				(command "dim1" "ver" dm34 dm35 (polar dm35 (DTR 180.0) 60) newst1_newmem1_backmark)
				(command "dim1" "hor" dm36 dm37 (polar dm37 (DTR 270.0) 113) newst1_newmem1_len)
				(command "_insert" "f3x" dm38 "0.0394" "0.0394" "" "N4" (strcat newst1_newmem1_memname ".." (rtos (+ newst1_newmem1_len 50) 2 0) " Lg" ))
				
				(command "dim1" "ver" dm39 dm40 (polar dm40 (DTR 180.0) 60) newst1_newmem2_backmark)
				(command "dim1" "hor" dm41 dm42 (polar dm42 (DTR 270.0) 113) (Number_Round newst1_newmem2_len 1))
				(command "_insert" "f3x" dm43 "0.0394" "0.0394" "" "N5" (strcat newst1_newmem2_memname ".." (rtos (+ (Number_Round newst1_newmem2_len 1) 50) 2 0) " Lg" ))
				
				(command "dim1" "ver" dm44 dm45 (polar dm45 (DTR 180.0) 60) newstud1_hipmem1_backmark)
				(command "dim1" "hor" dm46 dm47 (polar dm47 (DTR 270.0) 98) newstud1_hipmem1_len)
				(command "_insert" "f3x" dm48 "0.0394" "0.0394" "" "N7" (strcat newstud1_hipmem1_memname ".." (rtos (+ newstud1_hipmem1_len 50) 2 0) " Lg" ))
				
				(command "dim1" "ver" dm49 dm50 (polar dm50 (DTR 180.0) 60) newstud1_hipmem2_backmark)
				(command "dim1" "hor" dm51 dm52 (polar dm52 (DTR 270.0) 98) newstud1_hipmem2_len)
				(command "_insert" "f3x" dm53 "0.0394" "0.0394" "" "N8" (strcat newstud1_hipmem2_memname ".." (rtos (+ newstud1_hipmem2_len 50) 2 0) " Lg" ))
				;===================================================
				
				;hip
				(command "dim1" "hor" dm54 dm55 (polar dm54 (DTR 90.0) 71.5) (rtos (+ newst1_size 20) 2 0))
				(command "dim1" "hor" dm56 dm57 (polar dm57 (DTR 270.0) 86) (rtos (+ newstud1_backmark 10) 2 0))
				(command "dim1" "hor" dm57 dm58 (polar dm57 (DTR 270.0) 86) (rtos (- (+ newst1_size 20) (+ newstud1_backmark 10)) 2 0))
				
				(command "dim1" "hor" dm59 dm60 (polar dm60 (DTR 270.0) 173) (rtos (+ (+ newst1_size 20) 130) 2 0))
				(command "_insert" "f3x" dm61 "0.0394" "0.0394" "" "N6" (strcat "PLT.." (rtos (fix clampstk) 2 0) "x100x" (rtos (+ (+ newst1_size 20) 130) 2 0)))
				(command "style" "standard" "simplex" (* 2.0 sf) "0.8" "" "" "" "")
				(defun tan (z / cosz)
				(if (zerop (setq cosz (cos z)))
				9.7e307
				(/ (sin z) cosz)
				))
				(command "TEXT" dm62 "0" "1000")
				(command "TEXT" dm63 "0" "1000")
				(command "TEXT" dm64 "0" (rtos (Number_Round (* (tan (dtr newstud1_hipmem1_ang1)) 1000) 1) 2 0))
				(command "TEXT" dm65 "0" (rtos (Number_Round (* (tan (dtr newstud1_hipmem1_ang1)) 1000) 1) 2 0))
				
				(command "dim1" "ver" dm35 dm36 (polar dm35 (DTR 180.) 80) (fix newstud1_hipmem1_backmark))
				(command "dim1" "hor" dm37 dm38 (polar dm37 (DTR 270.0) 113) newstud1_hipmem1_len)
				(command "_insert" "f3x" dm39 "0.0394" "0.0394" "" "N5" (strcat newstud1_hipmem1_memname ".." (rtos (+ newstud1_hipmem1_len 50) 2 0) " Lg"))
				
				;(command "line" (polar dm19 (DTR 7.0) 119) (polar (polar dm19 (DTR 7.0) 119) (DTR 0.0) 640) "") 
				(command "dim1" "hor" dm66 dm67 (polar dm67 (DTR 90.0) 79) newstud1_platex1)
				(command "dim1" "hor" dm67 dm68 (polar dm57 (DTR 90.0) 79) newstud1_platex2)
				(command "dim1" "ver" dm69 dm70 (polar dm70 (DTR 180.0) 79) newstud1_platey1)
				(command "dim1" "ver" dm70 dm71 (polar dm70 (DTR 180.0) 79) newstud1_platey2)
				
				;BOM
				(setq ibom dm46)
				(setq N3 (* (/ (Number_Round (+ newstud1_memlen 50) 1) 1000.0) newstud1_blockwt 3))
				(setq N4 (* (/ (Number_Round (+ newst1_newmem1_len 50) 1) 1000.0) newst1_newmem1_blockwt 3))
				(setq N5 (* (/ (Number_Round (+ newst1_newmem2_len 50) 1) 1000.0) newst1_newmem2_blockwt 3))
				(setq N6 (* (/ clampstk 1000.0 )(/ 100 1000.0) (/ (Number_Round (rtos (+ (+ newst1_size 20) 130) 2 0) 1) 1000.0) 7850.0 3))
				(setq N7 (* (/ (Number_Round (+ newstud1_hipmem1_len 50) 1) 1000.0) newstud1_hipmem1_blockwt 3))
				(setq N8 (* (/ (Number_Round (+ newstud1_hipmem2_len 50) 1) 1000.0) newstud1_hipmem2_blockwt 3))
				
				(setq concrete_vol (* (/ newstud1_pdwt 1000.0) (/ newstud1_pdwt 1000.0) (/ newstud1_pdht 1000.0) 3))
				(setq total_mem_weight (+ N3 N4 N5 N6 N8 N9 27.43))
				(setq total_weight (+ total_mem_weight 10.3))
				(command "_insert" "c:/detail/POLEDATA/IN-6.0M-RIT-120-CNTR-MP_A_SOL5_bom" ibom "" "" "" )
				
				(setq bom1t (polar ibom (DTR 180.0) 1609.7)) (setq bom1 (polar bom1t (DTR 270.0) 653.56)) ;aa1
				(setq bom2t (polar ibom (DTR 180.0) 1249.11)) (setq bom2 (polar bom2t (DTR 270.0) 653.56)) ;aa2
				(setq bom3t (polar ibom (DTR 180.0) 865.74)) (setq bom3 (polar bom3t (DTR 270.0) 654.77)) ;aa3
				(setq bom4t (polar ibom (DTR 180.0) 522.18)) (setq bom4 (polar bom4t (DTR 270.0) 654.77)) ;aa4
				(setq bom5t (polar ibom (DTR 180.0) 1609.7)) (setq bom5 (polar bom5t (DTR 270.0) 712.42)) ;aa5
				(setq bom6t (polar ibom (DTR 180.0) 1249.11)) (setq bom6 (polar bom6t (DTR 270.0) 712.42)) ;aa6
				(setq bom7t (polar ibom (DTR 180.0) 844.07)) (setq bom7 (polar bom7t (DTR 270.0) 713.64)) ;aa7
				(setq bom8t (polar ibom (DTR 180.0) 505.76)) (setq bom8 (polar bom8t (DTR 270.0) 713.64)) ;aa8
				(setq bom9t (polar ibom (DTR 180.0) 1609.7)) (setq bom9 (polar bom9t (DTR 270.0) 771.28)) ;aa9
				(setq bom10t (polar ibom (DTR 180.0) 1249.11)) (setq bom10 (polar bom10t (DTR 270.0) 771.28)) ;aa10
				(setq bom11t (polar ibom (DTR 180.0) 844.07)) (setq bom11 (polar bom11t (DTR 270.0) 772.5)) ;aa11
				(setq bom12t (polar ibom (DTR 180.0) 505.76)) (setq bom12 (polar bom12t (DTR 270.0) 772.5)) ;aa12
				(setq bom13t (polar ibom (DTR 180.0) 1609.7)) (setq bom13 (polar bom13t (DTR 270.0) 833.39)) ;aa13
				(setq bom14t (polar ibom (DTR 180.0) 1249.11)) (setq bom14 (polar bom14t (DTR 270.0) 833.39)) ;aa14
				(setq bom15t (polar ibom (DTR 180.0) 844.07)) (setq bom15 (polar bom15t (DTR 270.0) 834.6)) ;aa15
				(setq bom16t (polar ibom (DTR 180.0) 505.76)) (setq bom16 (polar bom16t (DTR 270.0) 834.6)) ;aa16
				(setq bom17t (polar ibom (DTR 180.0) 1609.7)) (setq bom17 (polar bom17t (DTR 270.0) 895.49)) ;aa17
				(setq bom18t (polar ibom (DTR 180.0) 1249.11)) (setq bom18 (polar bom18t (DTR 270.0) 895.49)) ;aa18
				(setq bom19t (polar ibom (DTR 180.0) 844.07)) (setq bom19 (polar bom19t (DTR 270.0) 896.71)) ;aa19
				(setq bom20t (polar ibom (DTR 180.0) 505.76)) (setq bom20 (polar bom20t (DTR 270.0) 896.71)) ;aa20
				(setq bom21t (polar ibom (DTR 180.0) 1609.7)) (setq bom21 (polar bom21t (DTR 270.0) 957.6)) ;aa21
				(setq bom22t (polar ibom (DTR 180.0) 1249.11)) (setq bom22 (polar bom22t (DTR 270.0) 957.6)) ;aa22
				(setq bom23t (polar ibom (DTR 180.0) 844.07)) (setq bom23 (polar bom23t (DTR 270.0) 958.82)) ;aa23
				(setq bom24t (polar ibom (DTR 180.0) 505.76)) (setq bom24 (polar bom24t (DTR 270.0) 958.82)) ;aa24
				(setq bom25t (polar ibom (DTR 180.0) 888.35)) (setq bom25 (polar bom25t (DTR 270.0) 1037.96)) ;aa25
				(setq bom26t (polar ibom (DTR 180.0) 541.68)) (setq bom26 (polar bom26t (DTR 270.0) 1037.96)) ;aa26
				(setq bom27t (polar ibom (DTR 180.0) 899.71)) (setq bom27 (polar bom27t (DTR 270.0) 1508.84)) ;aa27
				(setq bom28t (polar ibom (DTR 180.0) 553.04)) (setq bom28 (polar bom28t (DTR 270.0) 1508.84)) ;aa28
				(setq bom29t (polar ibom (DTR 180.0) 871.7)) (setq bom29 (polar bom29t (DTR 270.0) 1572.58)) ;aa29
				(setq bom30t (polar ibom (DTR 180.0) 525.03)) (setq bom30 (polar bom30t (DTR 270.0) 1572.58)) ;aa30
				(setq bom31t (polar ibom (DTR 180.0) 899.71)) (setq bom31 (polar bom31t (DTR 270.0) 1636.31)) ;aa31
				(setq bom32t (polar ibom (DTR 180.0) 553.04)) (setq bom32 (polar bom32t (DTR 270.0) 1636.31)) ;aa32
				(setq bom33t (polar ibom (DTR 180.0) 674.78)) (setq bom33 (polar bom33t (DTR 270.0) 1696.55)) ;aa33

								
				(command "style" "TRB" "Trebuchet MS" (* 2.0 sf) "1" "" "" "")
				(command "TEXT" bom1 "0" newstud1_memname)
				(command "TEXT" bom2 "0" (itoa (Number_Round (+ newstud1_memlen 50) 1)))
				(command "TEXT" bom3 "0" (rtos N3 2 2))
				(command "TEXT" bom4 "0" (rtos (* 1.035 N3 ) 2 2))
				
				(command "TEXT" bom5 "0" newst1_newmem1_memname)
				(command "TEXT" bom6 "0" (itoa (Number_Round (+ newst1_newmem1_len 50) 1)))
				(command "TEXT" bom7 "0" (rtos N4 2 2))
				(command "TEXT" bom8 "0" (rtos (* 1.035 N4 ) 2 2))
							
				(command "TEXT" bom9 "0" newst1_newmem2_memname)
				(command "TEXT" bom10 "0" (itoa (Number_Round (+ newst1_newmem2_len 50) 1)))
				(command "TEXT" bom11 "0" (rtos N5 2 2))
				(command "TEXT" bom12 "0" (rtos (* 1.035 N5 ) 2 2))
				
				(command "TEXT" bom13 "0" (strcat "PLT.." (rtos (fix clampstk) 2 0) "x100x" (rtos (+ (+ newst1_size 20) 130) 2 0)))
				(command "TEXT" bom14 "0" (rtos (+ (+ newst1_size 20) 130) 2 0))
				(command "TEXT" bom15 "0" (rtos N6 2 2))
				(command "TEXT" bom16 "0" (rtos (* 1.035 N6 ) 2 2))
				
				(command "TEXT" bom17 "0" newstud1_hipmem1_memname)
				(command "TEXT" bom18 "0" (itoa (Number_Round (+ newstud1_hipmem1_len 50) 1)))
				(command "TEXT" bom19 "0" (rtos N7 2 2))
				(command "TEXT" bom20 "0" (rtos (* 1.035 N7 ) 2 2))
				
				(command "TEXT" bom21 "0" newstud1_hipmem2_memname)
				(command "TEXT" bom22 "0" (itoa (Number_Round (+ newstud1_hipmem2_len 50) 1)))
				(command "TEXT" bom23 "0" (rtos N8 2 2))
				(command "TEXT" bom24 "0" (rtos (* 1.035 N8 ) 2 2))
				
				(command "TEXT" bom33 "0" (rtos concrete_vol 2 3))	
				(command "style" "WMF-Trebuchet MS0" "Trebuchet MS" (* 2.5 sf) "1" "" "" "")
				(command "TEXT" bom25 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom26 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom27 "0" (rtos total_mem_weight 2 2))
				(command "TEXT" bom28 "0" (rtos (* total_mem_weight 1.035) 2 2))
				(command "TEXT" bom31 "0" (rtos total_weight 2 2))
				(command "TEXT" bom32 "0" (rtos (* total_weight 1.035) 2 2))
				(setq next1 (polar ibp (dtr 0.0) 9900))
				(setq ibp next1)

		))
	
	
	))
))
)