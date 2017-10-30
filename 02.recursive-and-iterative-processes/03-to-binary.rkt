#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (binary-digits number)
  (define (binary-digits-inner number result-accumulator)
    (if (= number 0)
        result-accumulator
        (binary-digits-inner (quotient number 2) (+ result-accumulator 1))))
  
  (if (= number 0)
      1
      (binary-digits-inner number 0)))

; Обръщаме число в двоична бройна система
(define (to-binary number)
  (define (to-binary-inner number next-power result-accumulator)
    (cond
      ((= next-power 1) (+ (* result-accumulator 10) (remainder number 2)))
      ((< number next-power) (to-binary-inner number (/ next-power 2) (* result-accumulator 10)))
      (else (to-binary-inner (- number next-power) (/ next-power 2) (+ (* result-accumulator 10) 1)))))
    
  (to-binary-inner number (expt 2 (- (binary-digits number) 1)) 0))

(define tests
  (test-suite "to-binary tests"
    (check-equal? (to-binary 10) 1010)
    (check-equal? (to-binary 0) 0)
    (check-equal? (to-binary 8) 1000)
  )
)

(run-tests tests 'verbose)
