#lang pl


#|
Q1.a
......
......

|#

(: open-list : (Listof(Listof Number)) -> (Listof Number))
(define (open-list lst)
  (  if(null? lst) null ;; if the list is empty
      (append (first lst) (open-list (rest lst))) ;; else
   )

 )

(test(open-list '((1 2 3) (2 3 3 4) (9 2 -1) (233 11 90))) => '(1 2 3 2 3 3 4 9 2 -1 233 11 90))

#|
Q1.b
......
......
|#

(: min&max : (Listof (Listof Number)) -> (Listof Number))
(define (min&max lst)
  (cond  [(null? lst ) null];; if the list is empty
         [else (list(exact->inexact (first(sort(open-list lst)<))) (exact->inexact( first(sort(open-list lst)>)))) ]
   )
 )
;; check null list
(test (min&max '((1 2 3) (2 3 3 4) (9 2 -1) (233 11 90))) => '(-1.0 233.0))
(test (min&max '()) => '())


#|
Q1.c  
......
......
|#

(: min&max_apply : (Listof (Listof Number)) -> (Listof Number))
(define (min&max_apply lst)
 
  (cond  [(null? lst ) null];; if the list is empty
         [else (list(apply min(open-list lst)) (apply max(open-list lst))) ]
   )
 )

;; check null list

(test (min&max_apply '((1 2 3) (2 3 3 4) (9 2 -1) (233 11 90))) => '(-1 233))
(test (min&max_apply '()) => '())
























