#lang racket
(require rackunit)
(require rackunit/text-ui)

; zip
(define (zip xs ys)
  (define (zip-inner xs ys result-accumulator) ; result-accumulator is in reverse
    (if (or (null? xs) (null? ys))
        (reverse result-accumulator)
        (zip-inner (cdr xs) (cdr ys) (cons (cons (car xs) (cons (car ys) '())) result-accumulator))))
  
  (zip-inner xs ys '()))

(define tests
  (test-suite "Zip"
    (check-equal? (zip '(1 2 3) '(4 5 6)) '((1 4) (2 5) (3 6)))
    (check-equal? (zip '(28 9 12) '(1 3)) '((28 1) (9 3)))
  )
)

(run-tests tests 'verbose)
