#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да направим списък от всички стойности в даден такъв.
; Искаме нивата на влагане да изчезнат.
(define (flatten xs)
  ; Appends second to the reverse of first
  (define (helper first second)
    (if (null? first)
        second
        (helper (cdr first) (cons (car first) second)))) 
  
  (define (flatten-inner xs result-accumulator) ; reverse-accumulator is in reverse
    (cond
      ((null? xs) (reverse result-accumulator))
      ((not (list? (car xs))) (flatten-inner (cdr xs) (cons (car xs) result-accumulator)))
      (else (flatten-inner (cdr xs) (helper (flatten (car xs)) result-accumulator)))))

  (flatten-inner xs '()))

(define tests
  (test-suite "Flatten"
    (check-equal? (flatten '(1 3 ("wow" ("nesting") ("overload" 38 91)))) '(1 3 "wow" "nesting" "overload" 38 91))
    (check-equal? (flatten '(1 2 3)) '(1 2 3))
    (check-equal? (flatten '(((3)))) '(3))
  )
)

(run-tests tests 'verbose)
