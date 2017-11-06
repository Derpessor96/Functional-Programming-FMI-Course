#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (take n xs)
  (if (or (= n 0) (null? xs))
      '()
      (cons (car xs) (take (- n 1) (cdr xs)))))

(define (drop n xs)
  (if (or (= n 0) (null? xs))
      xs
      (drop (- n 1) (cdr xs))))

; Искаме функция, която приема списък и две числа и връща
; списък, състоящ се от елементите на списъка, които се намират на индекси от първото число до второто.
(define (slice xs start end)
  (take (+ (- end start) 1) (drop start xs)))

(define tests
 (test-suite "Slice tests"
     (check-equal? (slice '(1 9 8 2) 1 2) '(9 8))
     (check-equal? (slice '(1 9 2 8 3) 2 10) '(2 8 3))
     (check-equal? (slice '(9 7 2 3) 0 2) '(9 7 2)) 
  )
)

(run-tests tests 'verbose)