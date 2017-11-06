#lang racket
(require rackunit)
(require rackunit/text-ui)

; Ще сортираме списък по метода на пряката селекция.
; За тази цел започваме с дефиниции на спомагателни функции.

; Намира най-малкото число в списъка
(define (minimum xs)
  (define (minumum-inner xs result-accumulator)
    (if (null? xs)
        result-accumulator
        (minumum-inner (cdr xs) (min (car xs) result-accumulator))))

  (minumum-inner (cdr xs) (car xs))) ; Don't call with an emtpy list...

; Връща списъка xs без първото срещане на x в него
; Only works if x is in xs
(define (remove x xs)
  ; Appends second to the reverse of first
  (define (helper first second)
    (if (null? first)
        second
        (helper (cdr first) (cons (car first) second)))) 

  (define (remove-inner x left-side right-side)
    (if (= x (car right-side))
        (helper left-side (cdr right-side))
        (remove-inner x (cons (car right-side) left-side) (cdr right-side))))
  
  (remove-inner x '() xs))

; Самият selection sort:
(define (selection-sort xs)
  (define (selection-sort-inner sorted-list remaining-list) ; sorted-list is in reverse
    (if (null? remaining-list)
        (reverse sorted-list)
        (let ((current-min (minimum remaining-list))) (selection-sort-inner (cons current-min sorted-list) (remove current-min remaining-list))))) ; TODO: Add a let for to compute (minumum remaining-list) only once

  (selection-sort-inner '() xs))

(define tests
  (test-suite "Selection sort"
    (letrec (
             (original-list '(32 39213 2813 8321 921 23))
             (sorted-list (selection-sort original-list))
             (same-lengths? (lambda (xs ys) (= (length xs) (length ys))))
             (same-elements?
              (lambda (xs ys)
                (cond ((null? xs) #t)
                      ((not (member (car xs) ys)) #f)
                      (else (same-elements? (cdr xs) ys)))))
             (increasing?
              (lambda (xs)
                (cond ((null? (cdr xs)) #t)
                      ((< (car xs) (cadr xs)) (increasing? (cdr xs)))
                      (else #f))))
            )
                        
      (check-true (same-lengths? original-list sorted-list))
      (check-true (same-elements? original-list sorted-list))
      (check-true (increasing? sorted-list)))
  )
)

(run-tests tests 'verbose)