#lang racket

; Да се напише функция (longest-descending­ l), която намира низходящо сортиран подсписък на списъка от числа l с максимална дължина.
; Ако съществуват няколко такива подсписъка, функцията да върне първия отляво надясно.
; Упътване: Реализирайте помощна функция, която намира най-дългия низходящо сортиран префикс на даден списък.
; Пример: (longest-descending­ '(5 3 8 6 4 2 6 7 1)): (8 6 4 2)
; Пример: (longest-descending­ '(1 2 3 4 5 6)): (1)
(define (longest-descending l)
  ; Call only with non-empty lists
  (define (longest-prefix l)
    (define (helper l prefix)
      (if (or (null? l) (>= (car l) (car prefix))) ; Change to > if you want non-strictly descending
          (reverse prefix)
          (helper (cdr l) (cons (car l) prefix))))

    (helper (cdr l) (list (car l))))
  
  (foldl
   (lambda (current-prefix best-prefix)
     (if (>= (length current-prefix) (length best-prefix))
         current-prefix
         best-prefix))
   '()
   (map longest-prefix
        (map (lambda (x) (drop l x)) (range 0 (length l))))))