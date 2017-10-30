#lang racket
(require rackunit)
(require rackunit/text-ui)

; Функцията sum, която видяхме на упражнение.
; Да стане по итеративен начин.
(define (sum start end term next)
  (define (sum-iterative current result-accumulator)
    (if (> current end)
        result-accumulator
        (sum-iterative (next current) (+ (term current) result-accumulator))))

  (sum-iterative start 0))

(define (id x) x)
(define (inc x) (+ x 1))

(define tests
  (test-suite "Iterative sum tests"

    (check-equal? (sum 1 100 id inc) 5050)
    (check-equal? (sum 9 9 id inc) 9)
  )
)

(run-tests tests 'verbose)
