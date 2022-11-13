
(setq plotsty "rccdwg.ctb")
(defun dtr(x) (* (/ pi 180.0) x))
(defun rtd(x) (* (/ 180 pi) x))

(defun c:hip()

(setq sp1 (getpoint "\nPick Horizantal starting point:"))

(setq sp2 (getpoint "\nPick Horizantal secound point:"))

(setq sp4 (getpoint "\nPick DIAGNAL SECOUND point:"))

  (if (= sclfac nil)
      (progn
(setq sp5 (getpoint "\nPick TOWER BASE B/B starting point:"))
(setq sp6 (getpoint "\nPick TOWER BASE B/B ENDING point:"))
(setq obs (getreal "\nEnter ORGINAL TOWER B/B LENGHT:"))
(setq bss (distance sp5 sp6))
(setq sclfac (/ obs bss))
       )
  )
(setq sp (getpoint "\nPick the point to generate hip:"))

(setq hsS (distance sp1 sp2))
(setq dsS (distance sp2 sp4))

(setq hsss (* sclfac hss))

(setq dsss (* sclfac dss))

(setq hs hsss)

(setq ds dsss)
(if (= pt nil)
(setq pt (getreal "\nEnter the number <1.Triangular, 2.Square, 3. Rectangular>:"))
)

(defun triangle()

(setq bb (/ hs 2))

(setq aa (sqrt (- (* ds ds) (* bb bb))))

(setq P1 (polar sp (DTR 0.0) hs)

      P2 (polar sp (DTR 0.0) bb)

      P3 (polar P2 (DTR 270.0) aa)
 );setq

(setvar "osmode" 0)

(command "line" SP P1 "" "LINE" P2 P3 "" "LINE" P1 P3 "" "LINE" SP P3 "" )

(setq ven (getreal "\required member adding at mid of hip<1.YES/2.NO>: "))


(defun memadd()

(setq demem1 (getreal "\nEnter diagnal member size: "))

(setq demem2 (/ demem1 2))

(setq demem (+ demem2 90))

(setq sang1 (angle sp p3))

(setq sang2 (angle p1 p3))

(setq ang1 (+ sang1 (* 90 (/ PI 180))))

(setq ang2 (+ sang2 (* 270 (/ PI 180))))

(setq P20 (polar SP ang1 demem))
(setq P21 (polar P3 ang1 demem))
(setq P22 (polar p1 ang2 demem))
(setq P23 (polar P3 ang2 demem))

(command "line" P20 P21 "")
(command "LINE" P22 P23 "")

(setq hdiss (/ aa 2))

(setq spr (polar SP (DTR 270.0) hdiss))
(setq p1r (polar P1 (DTR 270.0) hdiss))

(setq p24 (inters P20 P21 sPr p1r))
(setq p25 (inters P22 P23 sPr p1r))

(command "line" P24 P25 "")


)


(if (= ven 1) (memadd))

(if (= ven 2) (COMMAND ""))

)

(defun square()
(setq cc (* (sqrt 2) hs))
(setq dd (/ cc 2))

(setq ee (sqrt (- (* ds ds) (* dd dd))))

(setq P4 (polar sp (DTR 0.0) cc)

      P5 (polar sp (DTR 0.0) dd)

      P6 (polar P5 (DTR 270.0) ee)
 );setq

(setvar "osmode" 0)

(command "line" SP P4 "" "LINE" P5 P6 "" "LINE" P4 P6 "" "LINE" SP P6 "" )

(command "line" SP P1 "" "LINE" P2 P3 "" "LINE" P1 P3 "" "LINE" SP P3 "" )

(setq venn (getreal "\required member adding at mid of hip<1.YES/2.NO>: "))


(defun memad()

(setq dmem1 (getreal "\nEnter diagnal member size: "))

(setq dmem (+ (/ dmem1 2) 90))

(setq san1 (angle sp P6))

(setq san2 (angle P4 P6))

(setq ang3 (+ san1 (* 90 (/ PI 180))))

(setq ang4 (+ san2 (* 270 (/ PI 180))))

(setq P26 (polar SP ang3 dmem))
(setq P27 (polar P6 ang3 dmem))
(setq P28 (polar P4 ang4 dmem))
(setq P29 (polar P6 ang4 dmem))

(command "line" P26 P27 "")
(command "line" P28 P29 "")

(setq hdi (/ ee 2))

(setq spr (polar SP (DTR 270.0) hdi))
(setq p4r (polar P4 (DTR 270.0) hdi))

(setq P30 (inters P26 P27 sPr p4r))
(setq P31 (inters P28 P29 sPr p4r))

(command "line" P30 P31 "" "")

)

(if (= venn 1)

(memad))

(if (= venn 2)

(COMMAND "" ""))

)


(defun rectangle()
(setq re (getreal "\nEnter horizantal lenght in face2: "))

(setq ff (sqrt (+ (* hs hs) (* re re))))

(setq gg (/ ff 2))


(setq P7 (polar sp (DTR 0.0) ff)

      P8 (polar sp (DTR 0.0) gg)

      P9 (polar P8 (DTR 270.0) DS)
 );setq



(command "line" SP P7 "" "LINE" P8 P9 "" "LINE" P7 P9 "" "LINE" SP P9 "" ))

(if (= pt 1)

(triangle))

(if (= pt 2)

(square))

(if (= pt 3)

(rectangle))

(setvar "osmode" 111)

)