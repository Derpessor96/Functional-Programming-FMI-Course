#lang racket
(require rackunit)
(require rackunit/text-ui)

; Функцията sum, която видяхме на упражнение.
; Да стане по итеративен начин.
(define (sum start end term next)
  (define (sum-iterative start end term next result-accumulator)
    (if (> start end)
        result-accumulator
        (sum-iterative (next start) end term next (+ (term start) result-accumulator))))

  (sum-iterative start end term next 0))

(define (id x) x)
(define (inc x) (+ x 1))

(define tests
  (test-suite "Iterative sum tests"

    (check-equal? (sum 1 100 id inc) 5050)
    (check-equal? (sum 9 9 id inc) 9)
  )
)

(run-tests tests 'verbose)
