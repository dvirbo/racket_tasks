#lang pl


#| Q1.a
In this q we use 'append' to concat between the first item of the list
and use recurtion for the rest of the list
if the list empty -> return null ~ '()
|#

(: open-list : (Listof(Listof Number)) -> (Listof Number))
(define (open-list lst)
  (  if(null? lst) null ;; if the list is empty
      (append (first lst) (open-list (rest lst))) ;; else
   )

 )

(test (open-list '(()))
      => '())

(test (open-list null)
      => '())

(test (open-list '(() () () ())) 
      => null)

(test(open-list '((1 2 3) (2 3 3 4) (9 2 -1) (233 11 90)))
     => '(1 2 3 2 3 3 4 9 2 -1 233 11 90))

(test (open-list '((2) () (4) (6 8)))
      => '(2 4 6 8))

#| Q1.b
In this q we filter the min & max num from the list
first, we check if the list is empty -> return list that contain '(+inf.0 -inf.0)
else, we sort the list twice: for the min num in ascending order and then take the first item
same for the max num, but sort in decending order.
We use exact->inexact to convert the numbers to add floating-point 
|# 

(: min&max : (Listof (Listof Number)) -> (Listof Number))
(define (min&max lst)
  (cond  [(null? (open-list lst ) ) (list -inf.0 +inf.0)];; if the list is empty
         [else (list(exact->inexact (first(sort(open-list lst)<))) (exact->inexact( first(sort(open-list lst)>)))) ]
   )
 )
;; check null list
(test (min&max '((1 2 3) (2 3 3 4) (9 2 -1) (233 11 90)))
      => '(-1.0 233.0))
(test (min&max '()) ;; null ~ '()
      => '(-inf.0 +inf.0)) 
(test (min&max null)      ;; null
      => '(-inf.0 +inf.0)) 
(test (min&max '((-1 1)))
      => '(-1.0 1.0))
(test (min&max '((-1) (1))) ;; two item with ()
      => '(-1.0 1.0))
(test (min&max '((-1))) ;; one item
      => '(-1.0 -1.0))

#| Q1.c
In this q we use "apply min" to find the min max in the list
Using the func "open-list" from 1.a we convert the list of list to one list and then
apply min/max on them. after that we create new list from the output 
|#

(: min&max_apply : (Listof (Listof Number)) -> (Listof Number))
(define (min&max_apply lst)
  (cond  [(null? (open-list lst )) (list -inf.0 +inf.0)];; if the list is empty
         [else (list(apply min(open-list lst)) (apply max(open-list lst))) ]
   )
 )

(test (min&max '()) ;; null ~ '()
      => '(-inf.0 +inf.0))
(test (min&max null)      ;; null
      => '(-inf.0 +inf.0))
(test (min&max_apply '(() () () ())) ;; check 3 empty list
      => '(-inf.0 +inf.0)) 
(test (min&max '((-1 1)))
      => '(-1.0 1.0))
(test (min&max_apply '((-inf.0) (2 4 6) (+inf.0) (-2 -4 -6)))
      => '(-inf.0 +inf.0))
(test (min&max '((-1) (1))) ;; two item with ()
      => '(-1.0 1.0))
(test (min&max '((-1))) ;; one item
      => '(-1.0 -1.0))
(test (min&max_apply '((1 2 3) (2 3 3 4) (9 2 -1) (233 11 90)))
      => '(-1 233))
(test (min&max '((-inf.0))) ;; one item : -inf.0
      => '(-inf.0 -inf.0))
(test (min&max '((+inf.0))) ;; one item : +inf.0
      => '(+inf.0 +inf.0))


#| Q2.a + b
In this q we define new type 'table' that have 2 variant of the
data type (constructor:
EmptyTbl ~ empty variant
Add - input: symbol (key), a string (value),
 and an existing table and return an extended table in the natural
way
|#

(define-type Table
  [EmptyTbl]
  [Add Symbol String Table]
)

(test (EmptyTbl)
      => (EmptyTbl))
(test (Add 'b "B" (Add 'a "A" (EmptyTbl)))
      => (Add 'b "B" (Add 'a "A" (EmptyTbl))))
(test (Add 'a "aa" (Add 'b "B" (Add 'a "A" (EmptyTbl))))
      =>(Add 'a "aa" (Add 'b "B" (Add 'a "A" (EmptyTbl)))))


#| Q2.c
In this q we return the first value that is keyed accordingly to the input
of the symbol that we got.
first we use 'cases' to check if the table is ~ EmptyTbl -> return f
else, we check if the obj is add -> if the symbols equals -> return the str
else keep search in the next table 
|#

(: search-table : Symbol Table -> (U False String))  
(define (search-table symbol table)
        (cases table ;; check the varient type
            [(EmptyTbl) #f]
            [(Add sm str tbl)
               (cond [(equal? sm symbol) str] ;;check if the current symbol eq to input 
                     [else (search-table symbol tbl)] ;; keep search in the next table
                )
             ] 
         )
 )


(test (search-table 'c (Add 'a "AAA" (Add 'b "B" (Add 'a "A"
(EmptyTbl)))))
=> #f)
(test (search-table 'a (Add 'a "AAA" (Add 'b "B" (Add 'a "A"
(EmptyTbl)))))
=> "AAA")


#| Q2.d
In this q we want to remove item from the table that contain the Symbol
that given
same as the q above -> if the symbols equals: return the table without the 'sm str'
else concat by add the head part add call recursive to "remove-item" with the next tbl and the
given symbol
|#
(: remove-item : Table Symbol -> Table)
(define (remove-item table symbol)
        (cases table 
               [(EmptyTbl) (EmptyTbl)] ;; original table empty -> return an empty table
               [(Add sm str tbl) 
                   (cond [(equal? sm symbol) tbl]   ;; return the rest of the table without the 'sm str'                 
                         [else (Add sm str (remove-item tbl symbol))] ;;keep search in the next table and add the part that without the lookink symbol
                    )
               ] 
         )
  )


(test (remove-item (Add 'a "AAA" (Add 'b "B" (Add 'a "A"
(EmptyTbl)))) 'a)
      => (Add 'b "B" (Add 'a "A" (EmptyTbl))))

(test (remove-item (Add 'a "AAA" (Add 'b "B" (Add 'a "A"
(EmptyTbl)))) 'b)
      => (Add 'a "AAA" (Add 'a "A" (EmptyTbl))))

(test (remove-item  (Add 'a "AAAA" (Add 'b "BBBB" (Add 'c "CCCC" (Add 'd "DDDD" (EmptyTbl))))) 'c) 
      =>  (Add 'a "AAAA" (Add 'b "BBBB" (Add 'd "DDDD" (EmptyTbl)))))
