(defun c:bom()
(setq unit_weight nil)
(setq sec_size (entget (car (entsel "\nSelect Section size :" ))))
(setq len (cdr (assoc 1 sec_size)))
(setq sec_length (entget (car (entsel "\nSelect Length of the section  :" ))))
(setq slen (atof (cdr (assoc 1 sec_length))))
(setq sec_quantity (entget (car (entsel "\nSelect Quantity of the section  :" ))))
(setq qty (atof (cdr (assoc 1 sec_quantity))))

(if (or (= (substr len 1 1) "L") (= (substr len 5) "ROD" ))
(progn
(if (= len "L40x3") (setq unit_weight  1.8 ))
(if (= len "L40x4") (setq unit_weight  2.4 ))
(if (= len "L40x5") (setq unit_weight  3 ))
(if (= len "L40x6") (setq unit_weight  3.5 ))
(if (= len "L45x3") (setq unit_weight  2.1 ))
(if (= len "L45x4") (setq unit_weight  2.7 ))
(if (or (= len "L45x5") (= len "L45x45x5")) (setq unit_weight  3.4 ))
(if (= len "L45x6") (setq unit_weight  4 ))
(if (= len "L50x3") (setq unit_weight  2.3 ))
(if (= len "L50x4") (setq unit_weight  3 ))
(if (= len "L50x5") (setq unit_weight  3.8 ))
(if (= len "L50x6") (setq unit_weight  4.5 ))
(if (= len "L55x4") (setq unit_weight  3.3 ))
(if (= len "L55x5") (setq unit_weight  4.1 ))
(if (= len "L55x6") (setq unit_weight  4.9 ))
(if (= len "L55x8") (setq unit_weight  6.4 ))
(if (= len "L60x4") (setq unit_weight  3.7 ))
(if (= len "L60x5") (setq unit_weight  4.5 ))
(if (= len "L60x6") (setq unit_weight  5.4 ))
(if (= len "L60x8") (setq unit_weight  7 ))
(if (= len "L65x4") (setq unit_weight  4 ))
(if (= len "L65x5") (setq unit_weight  4.9 ))
(if (= len "L65x6") (setq unit_weight  5.8 ))
(if (= len "L65x8") (setq unit_weight  7.7 ))
(if (= len "L70x5") (setq unit_weight  5.3 ))
(if (= len "L70x6") (setq unit_weight  6.3 ))
(if (= len "L70x8") (setq unit_weight  8.3 ))
(if (= len "L70x10") (setq unit_weight  10.2 ))
(if (= len "L75x5") (setq unit_weight  5.7 ))
(if (= len "L75x75x5") (setq unit_weight  5.7 ))
(if (= len "L75x6") (setq unit_weight  6.8 ))
(if (= len "L75x8") (setq unit_weight  8.9 ))
(if (= len "L75x10") (setq unit_weight  11 ))
(if (= len "L80x6") (setq unit_weight  7.3 ))
(if (= len "L80x8") (setq unit_weight  9.6 ))
(if (= len "L80x10") (setq unit_weight  11.8 ))
(if (= len "L80x12") (setq unit_weight  14 ))
(if (= len "L90x6") (setq unit_weight  8.2 ))
(if (= len "L90x8") (setq unit_weight  10.8 ))
(if (= len "L90x10") (setq unit_weight  13.4 ))
(if (= len "L90x12") (setq unit_weight  15.4 ))
(if (= len "L100x6") (setq unit_weight  9.2 ))
(if (= len "L100x8") (setq unit_weight  12.1 ))
(if (= len "L100x10") (setq unit_weight  14.9 ))
(if (= len "L100x12") (setq unit_weight  17.7 ))
(if (= len "L110x8") (setq unit_weight  13.4 ))
(if (= len "L110x10") (setq unit_weight  16.6 ))
(if (= len "L110x12") (setq unit_weight  16.7 ))
(if (= len "L110x16") (setq unit_weight  25.7 ))
(if (= len "L130x8") (setq unit_weight  15.9 ))
(if (= len "L130x10") (setq unit_weight  19.7 ))
(if (= len "L130x12") (setq unit_weight  23.5 ))
(if (= len "L130x16") (setq unit_weight  30.7 ))
(if (= len "L150x10") (setq unit_weight  22.9 ))
(if (= len "L150x12") (setq unit_weight  27.3 ))
(if (= len "L150x16") (setq unit_weight  35.8 ))
(if (= len "L150x20") (setq unit_weight  44.1 ))
(if (= len "L200x12") (setq unit_weight  36.9 ))
(if (= len "L200x16") (setq unit_weight  48.5 ))
(if (= len "L200x20") (setq unit_weight  60 ))
(if (= len "16Ø ROD") (setq unit_weight  1.58 ))
(if (= len "12Ø ROD") (setq unit_weight  0.89 ))
(if (= len "20Ø ROD") (setq unit_weight  2.47 ))
(if (= len "L200x25") (setq unit_weight  73.9 ))
(setq weigth (rtos(* (/ slen 1000) qty unit_weight 1.035)))
(prompt "\n\n")
(setq p (strcat "Galv. Wt. (Kg.) = " weigth))
(print p)
(prompt "\n\n")
(command "change" pause "" "" "" "" "" "" weigth "")
(setvar "cmdecho" 0)
))
(if (= (substr len 1 2) "PL")
(progn
(setq pl1 (substr len 3))
(setq pln (strlen pl1))
(if (= pln 4) (progn (setq pl2 (atof (substr pl1 1 2))) (setq pl3 (atof (substr pl1 3)))))
(if (= pln 5) (progn (setq pl2 (atof (substr pl1 1 2))) (setq pl3 (atof (substr pl1 4)))))
(if (= pln 6) (progn (setq pl2 (atof (substr pl1 1 2))) (setq pl3 (atof (substr pl1 5)))))
(if (= pln 7) (progn (setq pl2 (atof (substr pl1 1 2))) (setq pl3 (atof (substr pl1 6)))))
(setq weigth (rtos (* (/ (* pl2 pl3 slen qty 7.85 ) 1000000) 1.035)))
(prompt "\n\n")
(setq p (strcat "Galv. Wt. (Kg.) = " weigth))
(print p)
(prompt "\n\n")
(command "change" pause "" "" "" "" "" "" weigth "")
(setvar "cmdecho" 1)
))
)