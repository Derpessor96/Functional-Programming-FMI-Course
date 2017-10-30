#lang racket
(require rackunit)
(require rackunit/text-ui)

; Търсим сумата на числата от даден списък
(define (sum-elements xs)
  (define (sum-elements-inner xs result-accumulator)
    (if (null? xs)
        result-accumulator
        (sum-elements-inner (cdr xs) (+ result-accumulator (car xs)))))

  (sum-elements-inner xs 0))

(define tests
  (test-suite "Sum elements tests"
    (check-equal? (sum-elements (range 1 6)) 15)
    (check-equal? (sum-elements '(1 9)) 10)
    (check-equal? (sum-elements '(-2 3 -1)) 0)
  )
)

(run-tests tests 'verbose)
