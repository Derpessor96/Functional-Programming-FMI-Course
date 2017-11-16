#lang racket
(require rackunit)
(require rackunit/text-ui)

; Appends second after the reverse of first 
(define (append-reverse first second)
  (if (null? first)
      second
      (append-reverse (cdr first) (cons (car first) second))))

; Искаме да вмъкнем х в списъка хs на съответния index.
; Индексираме от 0.
(define (insert x index xs)
  ; left-side is in reverse
  (define (helper left-side right-side elements-remaining)
    (if (or (= elements-remaining 0) (null? right-side))
        (append-reverse (cons x left-side) right-side)
        (helper (cons (car right-side) left-side) (cdr right-side) (- elements-remaining 1))))

  (helper '() xs index))

(define tests
 (test-suite "random-tests"
   (check-equal? (insert 2 1 '(1 3 4 5)) '(1 2 3 4 5))
   (check-equal? (insert 8 0 '(1 7 5)) '(8 1 7 5))
   (check-equal? (insert 99 3 '()) '(99))
   (check-equal? (insert 99 88 '(1 2 3)) '(1 2 3 99))
 )
) 



(run-tests tests 'verbose)
