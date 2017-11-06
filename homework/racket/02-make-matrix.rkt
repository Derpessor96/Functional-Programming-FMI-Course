#lang racket
(require rackunit)
(require rackunit/text-ui)
(provide make-matrix)
(provide drop)

(define (drop n xs)
  (if (or (= n 0) (null? xs))
      xs
      (drop (- n 1) (cdr xs))))

; В следващите задачи ще работим с матрици.
; Матрица за нас ще означава списък от списъци.
; Всеки подсписък на основния е ред на матрицата.

; В тази задача искаме да построим матрица на база списък от стойности
; и брой редове и колони, които искаме тя да има.
; Има два начина да конструираме такава матрица - по редове и по колони.
; По редове ще рече, че първо запълваме първия ред със стойности, след това втория и т.н.
; По колони - първо запълваме първата колона със стойности, след това втората и т.н.

; В тази задача искаме запълването да се случи по редове.
(define (make-matrix xs rows cols)
  (define (make-row items cols-remaining result-accumulator)
    (if (= cols-remaining 0)
        (reverse result-accumulator)
        (make-row (cdr items) (- cols-remaining 1) (cons (car items) result-accumulator))))

  (define (make-matrix-inner items rows-remaining result-accumulator)
    (if (= rows-remaining 0)
        (reverse result-accumulator)
        (make-matrix-inner (drop cols items) (- rows-remaining 1) (cons (make-row items cols '()) result-accumulator))))

  (make-matrix-inner xs rows '()))

(define tests
  (test-suite "Make matrix tests"
    (check-equal? (make-matrix (range 1 7) 2 3) '((1 2 3) (4 5 6)))
    (check-equal? (make-matrix (range 1 7) 6 1) '((1) (2) (3) (4) (5) (6)))
    (check-equal? (make-matrix (range 1 101) 4 5) '((1 2 3 4 5)
                                                   (6 7 8 9 10)
                                                   (11 12 13 14 15)
                                                   (16 17 18 19 20)))))

(run-tests tests 'verbose)