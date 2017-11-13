#lang racket
(require rackunit)
(require rackunit/text-ui)
(require "01-map.rkt")
(require "02-filter.rkt")
(require "03-fold-left.rkt")
(require "04-fold-right.rkt")

; Дефинирайте filter въз основа на fold-right
(define (filter p? xs)
  (fold-right (lambda (current acc) (if (p? current) (cons current acc) acc)) '() xs))

; Дефинирайте map въз основа на fold-left
(define (map f xs)
  (reverse (fold-left (lambda (acc current) (cons (f current) acc)) '() xs)))

(display "ACTUAL TESTS-----------------------------------------------------------\n")

; Copy pasted the tests since otherwise the wrong version of filter/map was used (the ones in 01-map.rkt and 02-filter.rkt).
; As a result filter and map defined here did not get tested. 
(define filter-tests
  (test-suite "Filter tests"
     (check = (length (filter odd? (range 1 101))) (/ (length (range 1 101)) 2))
     (check-equal? (filter (lambda (x) (string-contains? x "ed")) '("qed" "what" "education")) '("qed" "education"))
     
     (letrec ((sum-digits (lambda (n)
                         (if (< (abs n) 10)
                             n
                             (+ (remainder n 10) (sum-digits (quotient n 10)))))))

       (check-equal? (filter (lambda (x) (> (sum-digits x) 15)) '(123 99 1455 7531 821 934)) '(99 7531 934)))
  )
)

(define map-tests
  (test-suite "Map tests"
    
    (check-equal? (map - '(1 2 3 4)) '(-1 -2 -3 -4))
    (check-equal? (map (lambda (x) (* x x)) '(1 2 3 4)) '(1 4 9 16))
    (check-equal? (map (lambda (x) (odd? x)) '(9 28173 8 2 75)) '(#t #t #f #f #t))

    (check-equal? (map (lambda (x) (car x)) '((1 2 3) (4 5 6) (7 8 9))) '(1 4 7))
    (check-equal? (map (lambda (x) (string-length x)) '("Woow" "this" "is" "a" "list" "of" "strings")) '(4 4 2 1 4 2 7))
    (check-equal? (map (lambda (x) (cons x '())) '(1 2 3)) '((1) (2) (3)))
  )
)

(run-tests map-tests 'verbose)
(run-tests filter-tests 'verbose)