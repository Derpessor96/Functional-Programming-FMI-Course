#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (square x) (* x x))

; Искаме да проверим дали число е просто.
(define (prime? number)
  (define (prime-inner number next-divisor)
    (cond
      ((= number 1) #f)
      ((> (square next-divisor) number) #t)
      ((= (remainder number next-divisor) 0) #f)
      (else (prime-inner number (+ next-divisor 1)))))
  
  (prime-inner number 2))

(define tests
  (test-suite "prime? tests"
    (check-false (prime? 1))
    (check-true (prime? 5))
    (check-false (prime? 1729))
    (check-false (prime? 41041))
  )
)

(run-tests tests 'verbose)
