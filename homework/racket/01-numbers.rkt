#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да дефинираме следните имена

; one, two, three, four, five, six, seven, eight, nine, ten
; plus, minus, times, div

; Така че тестовете долу да минават.
(define (one . args) (if (null? args) 1 ((car args) 1)))
(define (two . args) (if (null? args) 2 ((car args) 2)))
(define (three . args) (if (null? args) 3 ((car args) 3)))
(define (four . args) (if (null? args) 4 ((car args) 4)))
(define (five . args) (if (null? args) 5 ((car args) 5)))
(define (six . args) (if (null? args) 6 ((car args) 6)))
(define (seven . args) (if (null? args) 7 ((car args) 7)))
(define (eight . args) (if (null? args) 8 ((car args) 8)))
(define (nine . args) (if (null? args) 9 ((car args) 9)))
(define (ten . args) (if (null? args) 10 ((car args) 10)))

(define (plus second-arg)
  (lambda (first-arg) (+ first-arg second-arg)))
(define (minus second-arg)
  (lambda (first-arg) (- first-arg second-arg)))
(define (times second-arg)
  (lambda (first-arg) (* first-arg second-arg)))
(define (div second-arg)
  (lambda (first-arg) (/ first-arg second-arg)))

; Така че тестовете долу да минават.
(define tests
  (test-suite "Numbers tests"
    (check-equal? (one (plus (one))) 2)
    (check-equal? (three (times (five))) 15)
    (check-equal? (eight (div (two))) 4)
    (check-equal? (seven (times (six))) 42)
    (check-equal? (nine (minus (three))) 6)
  )
)

(run-tests tests 'verbose)
