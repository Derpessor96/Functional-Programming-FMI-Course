#lang racket
(require rackunit)
(require rackunit/text-ui)

; 1.7 - Търсим процедура, която проверява дали едно число е палиндром.
; Трябва да работи и за отрицателни числа.
(define (reverse-digits number)
  (define (reverse-digits-inner number result-accumulator)
    (cond
      ((< number 0) (- (reverse-digits-inner (- number) result-accumulator)))
      ((= number 0) result-accumulator)
      (else (reverse-digits-inner (quotient number 10) (+ (* 10 result-accumulator) (remainder number 10))))))
  
  (reverse-digits-inner number 0))
  
(define (palindrome? number)
  (= number (reverse-digits number)))

(define tests (test-suite
  "Palindrome tests"

  (test-case "Should function correctly"
    (check-true (palindrome? 12321))
    (check-false (palindrome? 872))
    (check-true (palindrome? 2))
    (check-true (palindrome? 310013))
    (check-true (palindrome? -21212))
)))

(run-tests tests 'verbose)
