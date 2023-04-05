(defun DTR (a)				
(* PI (/ a 180.0))
);defun
(defun c:ant()
(setq ip (getpoint "\n pick the point to generate"))
(setq a (getint "\n 0.0 - 2.5 : "))
(setq b (getint "\n 2.5 - 5.0 : "))
(setq c (getint "\n 5.0 - 7.5 : "))
(setq d (getint "\n 7.5 - 10.0 : "))
(setq e (getint "\n 10.0 - 15.0 : "))
(setq f (getint "\n 15.0 - 20.0 : "))

(setq p1 (polar ip (DTR 0.0) 730)
      p2 (polar p1 (DTR 270.0) 810)
	  p3 (polar p2 (DTR 180.0) 730)
      p4 (polar p3 (DTR 90.0) 810)
	  
	  p5tp (polar ip (DTR 270.0) 135)
	  p6tp (polar p5tp (DTR 0.0) 730 )
	  p5 (polar p5tp (DTR 0.0) 365)
	  p6 (polar p5 (DTR 270.0) 675)
	  
	  p7 (polar p5tp (DTR 270.0) 120)
	  p8 (polar p7 (DTR 0.0) 730)
	  
	  p9 (polar p7 (DTR 270.0) 92.5)
	  p10 (polar p9 (DTR 0.0) 730)
	  
	  p11 (polar p9 (DTR 270.0) 92.5)
	  p12 (polar p11 (DTR 0.0) 730)
	  
	  p13 (polar p11 (DTR 270.0) 92.5)
	  p14 (polar p13 (DTR 0.0) 730)
	  
	  p15 (polar p13 (DTR 270.0) 92.5)
	  p16 (polar p15 (DTR 0.0) 730)
	  
	  p17 (polar p15 (DTR 270.0) 92.5)
	  p18 (polar p17 (DTR 0.0) 730)
     
 );setq
	(setq p21 (polar p7 (DTR 270.0) 65))
(setq p22 (polar p21 (DTR 0.0) 50))
	(setq p23 (polar p9 (DTR 270.0) 65))
(setq p24 (polar p23 (DTR 0.0) 50))
	(setq p25 (polar p11 (DTR 270.0) 65))
(setq p26 (polar p25 (DTR 0.0) 50))
	(setq p27 (polar p13 (DTR 270.0) 65))
(setq p28 (polar p27 (DTR 0.0) 50))
	(setq p29 (polar p15 (DTR 270.0) 65))
(setq p30 (polar p29 (DTR 0.0) 50))
	(setq p31 (polar p17 (DTR 270.0) 65))
(setq p32 (polar p31 (DTR 0.0) 50))
;headers;
	(setq p33 (polar ip (DTR 270.0) 51))
(setq p34 (polar p33 (DTR 0.0) 90))
	(setq p35 (polar p34 (DTR 270.0) 60))
(setq p36 (polar p35 (DTR 0.0) 40))
;headers-2;
	(setq p37 (polar p5tp (DTR 270.0) 70))
(setq p38 (polar p37 (DTR 0.0) 80))

	(setq p39 (polar p5tp (DTR 270.0) 51))
(setq p40 (polar p39 (DTR 0.0) 385))
	(setq p41 (polar p5tp (DTR 270.0) 105))
(setq p42 (polar p41 (DTR 0.0) 405))	
	(setq p43 (polar p5tp (DTR 270.0) 89))  ;for square
(setq p44 (polar p43 (DTR 0.0) 570))

(setq a1 (strcat (itoa a ) ".0/" ))
(setq b1 (strcat (itoa b ) ".0/" ))
(setq c1 (strcat (itoa c ) ".0/" ))
(setq d1 (strcat (itoa d ) ".0/" ))
(setq e1 (strcat (itoa e ) ".0/" ))
(setq f1 (strcat (itoa f ) ".0/" ))

(setq p45 (polar p22 (DTR 0.0) 430))
(setq p46 (polar p24 (DTR 0.0) 430))
(setq p47 (polar p26 (DTR 0.0) 430))
(setq p48 (polar p28 (DTR 0.0) 430))
(setq p49 (polar p30 (DTR 0.0) 430))
(setq p50 (polar p32 (DTR 0.0) 430))

(command "layer" "m" "c8" "c" "8" "" "lt" "dot2" "" "")
   (setvar "osmode" 0)
   (setvar "cmdecho" 1)
   (defun mem() (command "layer" "s" "mem" ""))
(defun gus() (command "layer" "s" "gus" ""))
(defun des() (command "layer" "s" "des" ""))
(defun dim() (command "layer" "s" "dim" ""))
(defun c8() (command "layer" "s" "c8" ""))

(gus)(command "line" ip p1 p2 p3 p4 "")
(command "line" p5 p6 "")
(command "line" p5tp p6tp "")
(command "line" p7 p8 "")
(c8)(command "line" p9 p10 "")
(command "line" p11 p12 "")
(command "line" p13 p14 "")
(command "line" p15 p16 "")
(command "line" p17 p18 "")

(command "textsize" "30" "")
(command "textstyle" "ROMANS" "")
(mem)
(command "TEXT" p22 "30" "0" "0.0 - 2.5" "")
(command "TEXT" p24 "30" "0" "2.5 - 5.0" "")
(command "TEXT" p26 "30" "0" "5.0 - 7.5" "")
(command "TEXT" p28 "30" "0" "7.5 - 10.0" "")
(command "TEXT" p30 "30" "0" "10.0 - 15.0" "")
(command "TEXT" p32 "30" "0" "15.0 - 20.0" "")

(command "TEXT" p34 "30" "0" "ADDITIONAL ANTENNA AREA" "")
(command "TEXT" p36 "30" "0" "AFTER STRENGTHENING" "")
(command "TEXT" p38 "30" "0" "LEVEL" "")
(command "TEXT" p40 "30" "0" "PERMISSIBLE" "")
(command "TEXT" p42 "30" "0" "AREA (M )" "")
(command "TEXT" p44 "30" "0" "2" "")
(command "textstyle" "Standard" "")
(des)
(command "TEXT" p45 "0" a1 "")(command "TEXT" p46 "0" b1 "")
(command "TEXT" p47 "0" c1 "")(command "TEXT" p48 "0" d1 "")
(command "TEXT" p49 "0" e1 "")(command "TEXT" p50 "0" f1 "")
(setvar "osmode" 1)
(setvar "osmode" 32767)
)





