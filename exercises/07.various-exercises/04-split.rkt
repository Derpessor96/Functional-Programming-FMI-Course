#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да разделим списъка xs на две.
; Дадена е дължината, която искаме да има първия - n.
(define (split n xs)
  (define (helper left-part right-part elements-remaining)
    (if (= elements-remaining 0)
        (list (reverse left-part) right-part)
        (helper (cons (car right-part) left-part) (cdr right-part) (- elements-remaining 1))))

  (helper '() xs n))

(define tests
  (test-suite "Split"
    (check-equal? (split 3 '(1 2 3 4 5 6 7)) '((1 2 3) (4 5 6 7)))
    (check-equal? (split 0 '(1 2 3 4 5 6 7)) '(() (1 2 3 4 5 6 7)))
    (check-equal? (split 7 '(1 2 3 4 5 6 7)) '((1 2 3 4 5 6 7) ()))
  )
)
(run-tests tests 'verbose)
