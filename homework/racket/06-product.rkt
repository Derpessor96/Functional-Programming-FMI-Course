#lang racket
(require rackunit)
(require rackunit/text-ui)
(require "02-make-matrix.rkt")
(require "03-get-row.rkt")
(require "04-get-column.rkt")

; Търсим произведението на две матрици
(define (matrix* m1 m2)
  (let
      ((rows (length m1))
       (cols (length (car m2)))
       (result-at
        (lambda (x y)
          (foldl (lambda (a b result) (+ result (* a b))) 0 (get-row m1 x) (get-column m2 y)))))
    
    (map (lambda (x) (map (lambda (y) (result-at x y)) (range 0 cols))) (range 0 rows))))

(define tests
  (test-suite "Multiplication tests"
    (let ((first-matrix (make-matrix (range 1 7) 2 3))
          (second-matrix (make-matrix (range 7 13) 3 2))
          (expected-result (make-matrix '(58 64 139 154) 2 2)))
      (check-equal? (matrix* first-matrix second-matrix) expected-result))
  )
)

(display "ACTUAL TESTS-----------------------------------------------------------\n")

(run-tests tests 'verbose)
