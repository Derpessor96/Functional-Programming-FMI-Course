#lang racket
(require rackunit)
(require rackunit/text-ui)

; Обръщаме число от двоична в десетична бройна система
(define (to-decimal number)
  (define (to-decimal-inner number next-power-of-2 result-accumulator)
    (if (= number 0)
        result-accumulator
        (to-decimal-inner (quotient number 10) (* next-power-of-2 2) (+ result-accumulator (* next-power-of-2 (remainder number 10))))))
  
  (to-decimal-inner number 1 0))

(define tests
  (test-suite "to-decimal tests"
    (check-equal? (to-decimal 11001) 25)
    (check-equal? (to-decimal 1100011) 99)
  )
)

(run-tests tests 'verbose)
