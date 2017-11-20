#lang racket

; Да се напише функция (max-duplicate ll), която по списък от списъци от цели числа ll намира най-­голямото от
; тези числа, които се повтарят в рамките на списъка, в който се срещат. Ако в нито един списък няма повтарящи се числа, функцията да връща #f.
; Пример: (max-duplicate '((1 2 3 2) (-­4 -­4) (5))): 2
; Пример: (max-duplicate '((1 2 3) (-­4 -­5 -6) ())): #f
(define (max-duplicate ll)
  (define (max-duplicate-single-list xs)
    (define (helper xs max found-one)
      (cond
        ((<= (length xs) 1) (and found-one max))
        ((and found-one (> max (car xs))) (helper (cdr xs) max found-one))
        ((member (car xs) (cdr xs)) (helper (cdr xs) (car xs) #t))
        (else (helper (cdr xs) max found-one))))

    (helper xs 0 #f))


  (foldl
   (lambda (current-list max)
     (let ((current-list-max (max-duplicate-single-list current-list)))
       (cond
         ((not current-list-max) max)
         ((or (not max) (> current-list-max max)) current-list-max)
         (else max))))
   #f
   ll))