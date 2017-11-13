#lang racket
(require rackunit)
(require rackunit/text-ui)
(provide fold-right)
 
; Същото като fold-left, само че "свиването" на рекурсията да започва от дясно
; Тук е малко по-интуитивно нещата да се случат с рекурсивен процес
(define (fold-right op null-value xs)
  (if (null? xs)
      null-value
      (op (car xs) (fold-right op null-value (cdr xs)))))

; При добро желание, разбира се, може да се случи и с итеративен:
(define (fold-right-iter op null-value xs)
  (define (helper xs result-accumulator)
    (if (null? xs)
        result-accumulator
        (helper (cdr xs) (op (car xs) result-accumulator))))

  ; helper actually does a fold right on the reverse of its argument so we have to reverse it initially
  (helper (reverse xs) null-value))

(define fold-right-tests
  (test-suite "Fold-right tests"
    (check-equal? (fold-right / 1 '(1 2 3 4 5)) 15/8)
    (check-equal? (fold-right * 1 '(1 2 3 4 5)) (foldl * 1 '(1 2 3 4 5)))
    (check-equal? (fold-right (lambda (current acc) (+ current acc)) 0 (range 1 101)) 5050)
    (check-equal? (fold-right (lambda (current acc) (append acc (list current))) '() '(1 2 3 4 5)) '(5 4 3 2 1))

    (let ((recursive-result (fold-right / 1 '(1 2 3 4 5)))
          (iterative-result (fold-right-iter / 1 '(1 2 3 4 5))))

      (if (not (void? iterative-result))
          (check-equal? recursive-result iterative-result)
          (display "Define the iterative version as well pls\n")))
  )
)

(run-tests fold-right-tests 'verbose)
