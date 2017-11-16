#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да изключим всички повтарящи се елементи от xs.
; Подредбата на резултатния списък не ни интересува.
(define (to-set xs)
  (define (helper remaining-list result-accumulator)
    (cond
      ((null? remaining-list) result-accumulator)
      ((member (car remaining-list) result-accumulator) (helper (cdr remaining-list) result-accumulator))
      (else (helper (cdr remaining-list) (cons (car remaining-list) result-accumulator)))))

  (helper xs '()))

(define tests
  (test-suite "to-set tests"
    (letrec ((subset? (lambda (xs ys)
                       (or (null? xs)
                           (and (member (car xs) ys)
                                (subset? (cdr xs) ys)))))
             (equal-sets? (lambda (xs ys)
                            (and (subset? xs ys)
                                 (subset? ys xs))))
             (result-set (to-set '(a a a a b c c a a d e e e e))))
    ; Added an extra check in the test to make it more valid
    (check-true (and (equal-sets? result-set '(a b c d e)) (= (length result-set) 5))))
  )
) 

(run-tests tests 'verbose)
