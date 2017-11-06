#lang racket
(require rackunit)
(require rackunit/text-ui)

; 1.5 - Съчинете процедура, която обръща цифрите на дадено число.
; Трябва да работи и за отрицателни числа.
(define (reverse-digits number)
  (define (reverse-digits-inner number result-accumulator)
    (cond
      ((< number 0) (- (reverse-digits-inner (- number) result-accumulator)))
      ((= number 0) result-accumulator)
      (else (reverse-digits-inner (quotient number 10) (+ (* 10 result-accumulator) (remainder number 10))))))
  
  (reverse-digits-inner number 0))

(define tests
  (test-suite
  "Reverse digits tests"

    (test-case "Should reverse correctly"
      (check-equal? (reverse-digits 2134) 4312)
    )

    (test-case "Should work alright with digits"
      (let ((k (random 10)))
        (check-equal? (reverse-digits k) k))
    )

    (test-case "Should work with negative numbers"
      (check-equal? (reverse-digits -298245) -542892)
    )
  )
)

(run-tests tests)
