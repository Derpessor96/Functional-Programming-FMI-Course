#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys))))

; Търсим функция, която обръща даден списък
(define (reverse xs)
  (if (null? xs)
      '()
      (append (reverse (cdr xs)) (cons (car xs) '())))) ; Very inefficient

; И нейн итеративен вариант
(define (reverse-iter xs)
  (define (reverse-iter-inner xs result-accumulator)
    (if (null? xs)
        result-accumulator
        (reverse-iter-inner (cdr xs) (cons (car xs) result-accumulator))))

  (reverse-iter-inner xs '()))

(define tests
  (test-suite "Reverse tests"
      (check-equal? (reverse-iter '(1 2 3)) (reverse '(1 2 3)))
      (check-equal? (reverse '()) '())
      (check-equal? (reverse '(1)) '(1))
      (check-equal? (reverse '(1 5)) '(5 1))
  )
)

(run-tests tests 'verbose)