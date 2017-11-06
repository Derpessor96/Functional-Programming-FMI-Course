#lang racket

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

; Пита се какви процеси (итеративен или рекурсивен) се случват при извикването на тези две процедури
(define (first-add a b)
  (if (= a 0)
      b
      (inc (first-add (dec a) b))))

; first-add is recursive, for instance:
; (first-add 3 10) =
; (inc (first-add (dec 3) 10)) =
; (inc (first-add 2 10)) =
; (inc (inc (first-add (dec 2) 10))) =
; (inc (inc (first-add 1 10))) =
; (inc (inc (first-add (dec 1) 10))) =
; (inc (inc (inc (first-add 0 10)))) = 
; (inc (inc (inc 10))) = 
; (inc (inc 11)) = 
; (inc 12) = 
; 13

(define (second-add a b)
  (if (= a 0)
      b
      (second-add (dec a) (inc b))))

; second-add is iterative, for instance:
; (second-add 3 10) =
; (second-add (dec 3) (inc 10)) = 
; (second-add 2 11) = 
; (second-add (dec 2) (inc 11)) = 
; (second-add 1 12) = 
; (second-add (dec 1) (inc 12)) = 
; (second-add 0 13) = 
; 13
