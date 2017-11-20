#lang racket

; Да се напише функция (meet-twice? f g a b), която проверява дали в целочисления интервал [a; b] съществуват
; две различни цели числа x и y такива, че f(x) = g(x) и f(y) = g(y).
; Пример: (meet-twice? (lambda(x)x) (lambda(x) (- x)) -3 1): #f
; Пример: (meet-twice? (lambda(x)x) sqrt 0 5): #t
(define (meet-twice? f g a b)
  (define (helper current count-so-far)
    (cond
      ((> current b) (>= count-so-far 2))
      ((= (f current) (g current)) (helper (+ current 1) (+ count-so-far 1)))
      (else (helper (+ current 1) count-so-far))))
  (helper a 0))