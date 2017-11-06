#lang racket
(require rackunit)
(require rackunit/text-ui)

; 1.3 - Съчинете процедура, която намира сумата на числата в даден затворен интервал.
; Not iterative
(define (sum-interval start end)
  (if (> start end)
      0
      (+ start (sum-interval (+ start 1) end))))

(define tests
  (test-suite
    "Interval sum tests"

    (test-case "start < end"
     (check-equal? (sum-interval 1 100) 5050)
    )
    (test-case "start > end"
     (check-equal? (sum-interval 500 150) 0)
    )
    (test-case "start = end"
     (check-equal? (sum-interval 9 9) 9)
    )
    (test-case "negative numbers :O"
     (check-equal? (sum-interval -10 0) -55)
    )
  ))

(run-tests tests 'verbose)