#lang racket
(require rackunit)
(require rackunit/text-ui)

; Обръщаме число в двоична бройна система

(define (binary-digits number)
  (define (binary-digits-inner number accumulator)
    (if (= number 0)
        accumulator
        (binary-digits-inner (floor (/ number 2)) (+ accumulator 1))))
  
  (if (= number 0)
    1
    (binary-digits-inner number 0)))

(define (to-binary number)
  (define (to-binary-inner number next-power result)
    (cond
      ((= next-power 1) (+ (* result 10) (mod number 2)))
      ((< number next-power) (to-binary-inner number (/ next-power 2) (* result 10)))
      (else (to-binary-inner (- number next-power) (/ next-power 2) (+ (* result 10) 1)))))
    
  (to-binary-inner number (expt 2 (- (binary-digits number) 1)) 0))

(define tests
  (test-suite "to-binary tests"
    (check-equal? (to-binary 10) 1010)
    (check-equal? (to-binary 0) 0)
    (check-equal? (to-binary 8) 1000)
  )
)

(run-tests tests 'verbose)
