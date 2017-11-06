#lang racket
(require rackunit)
(require rackunit/text-ui)
(require math/number-theory)

; Като accumulate, но със списък, вместо с интервал.
; It's a left fold
(define (fold op null-value xs)
  (define (fold-inner xs result-accumulator)
    (if (null? xs)
        result-accumulator
        (fold-inner (cdr xs) (op result-accumulator (car xs)))))

  (fold-inner xs null-value))

(define tests
  (test-suite "Fold tests"
     (check-equal? (fold + 0 '(1 5 9 10 20)) 45)
     (check-equal? (fold * 1 '(8 2 9 1 6)) 864)
     (check-equal? (fold / 1 (range 1 6)) 1/120)
     (check-equal? (fold append '() '((1 2 3) () (4 5 6) (7) ())) '(1 2 3 4 5 6 7))
  )
)

(run-tests tests 'verbose)