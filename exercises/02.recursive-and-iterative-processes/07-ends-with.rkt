#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (number-of-digits number)
  (define (number-of-digits-inner number result-accumulator)
    (if (= number 0)
        result-accumulator
        (number-of-digits-inner (quotient number 10) (+ result-accumulator 1))))
  
  (cond
    ((= number 0) 1)
    ((< number 0) (number-of-digits-inner (- number) 0))
    (else (number-of-digits-inner number 0))))

; Търсим процедура, която проверява дали дадено число завършва на дадено друго.
(define (ends-with? number test)
  (cond
    ((< number 0) (ends-with? (abs number) test))
    ((< test 0) (ends-with? number (abs test)))
    ((= (remainder number (expt 10 (number-of-digits test))) test) #t)
    (else #f)))

(define tests
  (test-suite "ends-with? tests"
    (check-true (ends-with? 8317 17))
    (check-true (ends-with? 82 82))
    (check-false (ends-with? 8213 31))
    (check-true (ends-with? 210 0))
    (check-false (ends-with? 2921 2))
    (check-false (ends-with? 213 0))
  )
)

(run-tests tests 'verbose)