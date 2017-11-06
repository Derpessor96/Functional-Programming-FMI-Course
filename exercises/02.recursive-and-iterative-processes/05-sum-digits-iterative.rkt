#lang racket
(require rackunit)
(require rackunit/text-ui)

; Търсим сумата от цифрите на дадено число.
; Процедурата да генерира итеративен процес.
(define (sum-digits number)
  (define (sum-digits-inner number result-accumulator)
    (if(= number 0)
       result-accumulator
       (sum-digits-inner (quotient number 10) (+ result-accumulator (remainder number 10)))))
    
  (if(< number 0)
     (sum-digits (- number))
     (sum-digits-inner number 0)))

(define tests
  (test-suite "to-decimal tests"
    (check-equal? (sum-digits 11001) 3)
    (check-equal? (sum-digits 804357) 27)
    (check-equal? (sum-digits 981) 18)
  )
)

(run-tests tests 'verbose)
