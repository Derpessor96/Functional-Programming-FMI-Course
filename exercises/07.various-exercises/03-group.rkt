#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да групираме последователни еднакви елементи на списък в подсписъци.
; Както в теста.
(define (group xs)
  (define (helper remaining-list result-accumulator next-sublist)
    (cond
      ((null? remaining-list) (reverse (cons next-sublist result-accumulator)))
      ((= (car next-sublist) (car remaining-list)) (helper (cdr remaining-list) result-accumulator (cons (car remaining-list) next-sublist)))
      (else (helper (cdr remaining-list) (cons next-sublist result-accumulator) (list (car remaining-list))))))

  (if (null? xs)
      '()
      (helper (cdr xs) '() (list (car xs)))))

(define tests
  (test-suite "Group tests"
    (check-equal? (group '(1 1 1 2 2 3 1 1 1 2 2 2 2 2 3 3 3 3)) '((1 1 1) (2 2) (3) (1 1 1) (2 2 2 2 2) (3 3 3 3)))
  )
)

(run-tests tests 'verbose)
