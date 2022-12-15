#lang pl 02


#|
  
  ██████╗  ██╗   ██╗ ███████╗ ███████╗ ████████╗ ██╗  ██████╗  ███╗   ██╗      ██╗
 ██╔═══██╗ ██║   ██║ ██╔════╝ ██╔════╝ ╚══██╔══╝ ██║ ██╔═══██╗ ████╗  ██║     ███║
 ██║   ██║ ██║   ██║ █████╗   ███████╗    ██║    ██║ ██║   ██║ ██╔██╗ ██║     ╚██║
 ██║▄▄ ██║ ██║   ██║ ██╔══╝   ╚════██║    ██║    ██║ ██║   ██║ ██║╚██╗██║      ██║
 ╚██████╔╝ ╚██████╔╝ ███████╗ ███████║    ██║    ██║ ╚██████╔╝ ██║ ╚████║      ██║
  ╚══▀▀═╝   ╚═════╝  ╚══════╝ ╚══════╝    ╚═╝    ╚═╝  ╚═════╝  ╚═╝  ╚═══╝      ╚═╝

The SE grammer:


<SE> ::= (1)  "<D>"
         (20) <D>
         (2) | #\v
         (3) | λ
         (4) | (string-length <SE>)
         (5) | (string <char>)
         (6) | (string-append (<SE>)(<SE>))
         (7) | <str>
         (8) | (number->string <SE>)
          

<str> ::= (9)  "<D>"
          (21) <D>
          (10) | #\v
          (11) | λ
          (12) | (string-length <str>)
          (13) | (string <char>)
          (14) | (string-append (<str>)(<str>))
          (15) | (string-insert <str> <str> <str>)
          (16) | (number->string <SE>)
           


<char> ::= (17) #\v <char>
           (18) | #\v
           (19) | λ

          
ex1: (string-append ( string #\1 #\2 #\4 ) "12" ) useing string-append:

<SE>
=> (6) string-append (<SE>)(<SE>))
=> (5) string-append  ((string <char>))(<SE>))
=> (1)  string-append  ((string <char>))(<SE>))
=> (17) string-append  ((string #\1 <char>))(<SE>))
=> (17) string-append  ((string #\1 #\2 <char>))(<SE>))             
=> (17) string-append  ((string #\1 #\2 <char>))(<SE>))  
=> (18) string-append  ((string #\1 #\2 #\4))(<SE>))
=> (1) string-append  ((string #\1 #\2 #\4))("12"))
 
ex2: ( number->string ( string-length "0033344" ) ) using string-length:

<SE>
=>  (8) (number->string <SE>)
=>  (4) (number->string (string-length <SE>))
=>  (1) (number->string (string-length "0033344"))


ex3: ( number->string 156879 ) 

<SE>
=> (8) (number->string <SE>)
=> (20) (number->string 156879)


|#


#|
  
  ██████╗  ██╗   ██╗ ███████╗ ███████╗ ████████╗ ██╗  ██████╗  ███╗   ██╗     ██████╗
 ██╔═══██╗ ██║   ██║ ██╔════╝ ██╔════╝ ╚══██╔══╝ ██║ ██╔═══██╗ ████╗  ██║     ╚════██╗
 ██║   ██║ ██║   ██║ █████╗   ███████╗    ██║    ██║ ██║   ██║ ██╔██╗ ██║      █████╔╝
 ██║▄▄ ██║ ██║   ██║ ██╔══╝   ╚════██║    ██║    ██║ ██║   ██║ ██║╚██╗██║     ██╔═══╝
 ╚██████╔╝ ╚██████╔╝ ███████╗ ███████║    ██║    ██║ ╚██████╔╝ ██║ ╚████║     ███████╗
  ╚══▀▀═╝   ╚═════╝  ╚══════╝ ╚══════╝    ╚═╝    ╚═╝  ╚═════╝  ╚═╝  ╚═══╝     ╚══════╝

In this Q we use helper function "square" to calc the square of digit,
and using "foldl" with + to sum all the squares in list.
Using "map" in "foldl" we call "square" on evety element in the list.

|#

(: square : Number -> Number)
(define (square x) (* x x))


(: sum-of-squares :(Listof Number) -> Number)
(define (sum-of-squares lst)
  (foldl + 0 (map square lst)))


 
(test (sum-of-squares '(1 2 3)) => 14)
(test (sum-of-squares '(-1 -2 -3)) => 14)
(test (sum-of-squares '()) => 0)
(test (sum-of-squares '(1)) => 1)
(test (square 2) => 4)
 
#|
 
  ██████╗  ██╗   ██╗ ███████╗ ███████╗ ████████╗ ██╗  ██████╗  ███╗   ██╗     ██████╗
 ██╔═══██╗ ██║   ██║ ██╔════╝ ██╔════╝ ╚══██╔══╝ ██║ ██╔═══██╗ ████╗  ██║     ╚════██╗
 ██║   ██║ ██║   ██║ █████╗   ███████╗    ██║    ██║ ██║   ██║ ██╔██╗ ██║      █████╔╝
 ██║▄▄ ██║ ██║   ██║ ██╔══╝   ╚════██║    ██║    ██║ ██║   ██║ ██║╚██╗██║      ╚═══██╗
 ╚██████╔╝ ╚██████╔╝ ███████╗ ███████║    ██║    ██║ ╚██████╔╝ ██║ ╚████║     ██████╔╝
  ╚══▀▀═╝   ╚═════╝  ╚══════╝ ╚══════╝    ╚═╝    ╚═╝  ╚═════╝  ╚═╝  ╚═══╝     ╚═════╝


note: how to cover inner function test in racket

 createPolynomia:
First, call to polyX with the number that we pass, and then call poly
that using tail recursion and calc the curr xi of the polynom and accumulate the first of the list
 every call (tail recursion).
every recursive call we return the accum with the sum of the curr poly
 
|#


  (: poly : (Listof Number) Number Integer Number -> Number) 
  (define (poly argsL x power accum) 
     (if (null? argsL) accum
         (poly (rest argsL) x (+ 1 power) (+ accum (*(first argsL)(expt x power))))
      )  
  )

(: createPolynomial : (Listof Number) -> (Number -> Number))
 (define (createPolynomial coeffs) 
		
  (: polyX : Number -> Number)
  (define (polyX x)
    (poly coeffs x 0 0)
   )
 
  polyX
   
 )

(define p_0 (createPolynomial '()))
(test (p_0 4) => 0) 

(test (poly '(1 1 1) 2 0 0) => 7) 

#|
 
  The grammar of PLANG:
    
    <PLANG> ::= { poly <AEs> } { <AEs> }
    
    <AEs>   ::= <AE>
            | <AE> <AEs>
    
    <AE>    ::= <num>
            | {+ <AE> <AE> }
            | {- <AE> <AE> }
            | {* <AE> <AE> }
            | {/ <AE> <AE> }

|# 

;; evaluation process of PLANG:



(define-type PLANG 
    [Poly (Listof AE) (Listof AE)]) 
 
  (define-type AE 
    [Num  Number] 
    [Add  AE AE] 
    [Sub  AE AE] 
    [Mul  AE AE] 
    [Div  AE AE]) 
 
  (: parse-sexpr : Sexpr -> AE) 
  ;; to convert s-expressions into AEs 
  (define (parse-sexpr sexpr) 
    (match sexpr 
      [(number: n) (Num n)] 
      [(list '+ lhs rhs) (Add (parse-sexpr lhs)  
	   	 	 	 	   (parse-sexpr rhs))] 
      [(list '- lhs rhs) (Sub (parse-sexpr lhs)
                                           (parse-sexpr rhs))] 
      [(list '* lhs rhs) (Mul (parse-sexpr lhs)  
	   	 	 	 	   (parse-sexpr rhs))] 
      [(list '/ lhs rhs) (Div (parse-sexpr lhs)  
	   	 	 	 	   (parse-sexpr rhs))] 
      [else (error 'parse-sexpr "bad syntax in ~s" sexpr)])) 


  (: parse : String -> PLANG) 
  ;; parses a string containing a PLANG expression to a PLANG AST
   (define (parse str) 
    (let ([code (string->sexpr str)])
    (match code
     [(list(list 'poly) (list x ...)) (error 'parse "at least one coefficient is required in ~ s" code)]
     [(list(list 'poly x ...) '(null)) (error 'parse "at least one point is required in ~ s" code)]
     [(list(list 'poly x ...) (list y ...)) (Poly(LSexpr-To-LAE x) (LSexpr-To-LAE y))]
     )
   ))

 (: LSexpr-To-LAE : (Listof Sexpr) -> (Listof AE))
   (define (LSexpr-To-LAE LSxpr)
   (map parse-sexpr LSxpr))


(test (parse "{{poly 1 2 3} {1 2 3}}")  
     => (Poly (list (Num 1) (Num 2) (Num 3)) (list (Num 1) (Num 2) (Num 3))))


(test (parse "{{poly 1 2} {} }")
     =error> "parse: at least one point is  
                       required in ((poly 1 2) ())")



;; evaluates AE expressions to numbers 
  (define (eval expr) 
    (cases expr 
      [(Num n)  n] 
      [(Add l r) (+ (eval l) (eval r))] 
      [(Sub l r) (- (eval l) (eval r))] 
      [(Mul l r) (* (eval l) (eval r))] 
      [(Div l r) (/ (eval l) (eval r))]))

  (: eval-poly : PLANG -> (Listof Number)) 
  (define (eval-poly p-expr) 
    (case p-expr
      [(poly l r)(map (createPolynomial(map eval l)(map eval r)))]
    )
  ) 



  (: run : String -> (Listof Number)) 
  ;; evaluate a FLANG program contained in a string 
  (define (run str) 
    (eval-poly (parse str))) 








