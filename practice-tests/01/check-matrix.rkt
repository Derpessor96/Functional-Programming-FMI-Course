#lang racket

(define (any? predicate? xs)
  (cond
    ((null? xs) #f)
    ((predicate? (car xs)) #t)
    (else (any? predicate? (cdr xs)))))

(define (all? predicate? xs)
  (not (any? (lambda (x) (not (predicate? x))) xs)))

; Да се напише функция (check-matrix? m k) която проверява дали на всеки ред в дадена матрица m от цели числа има поне по едно число, кратно на k.
; Пример: (check-matrix? '((1 2 6) (3 8 9) (10 12 11)) 3): #t
; Пример: (check-matrix? '((1 2 4) (3 8 9) (10 12 11)) 3): #f
(define (check-matrix? m k)
  (all? (lambda (row) (any? (lambda (x) (= (remainder x k) 0)) row)) m))