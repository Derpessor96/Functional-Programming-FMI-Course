#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (split-to-digits number)
  (define (split-to-digits-inner number result-accumulator)
    (if (= number 0)
        result-accumulator
        (split-to-digits-inner (quotient number 10) (cons (remainder number 10) result-accumulator))))

  (if (= number 0)
      '(0)
      (split-to-digits-inner number '())))

(define (combine-lists first second g null-value operation)
  (define (combine-lists-inner first second result-accumulator)
    (if (or (null? first) (null? second))
        result-accumulator
        (combine-lists-inner (cdr first) (cdr second) (operation result-accumulator (g (car first) (car second))))))
  
  (combine-lists-inner first second null-value))

; Първо е дефинирана бонус фунцкията, защото е използвана за реализация на другата
; Бонус занимавка: Да параметризираме и операцията, с която комбинираме резултатите от g(fk,sl).
(define (combine-numbers first second g null-value operation)
  (combine-lists (split-to-digits first) (split-to-digits second) g null-value operation))

; Функцията, която ще напишете, очаква за вход две цели положителни числа, кръстени за по-удобно "first" и "second", и бинарна функция.
; Ако f1,f2,f3,...,fk и s1,s2,s3,...,sl са цифрите на съответните числа, а g е нашата бинарна функция, търсим резултатът от g(f1,s1) + g(f2,s2) + g(f3,s3) + ...
; Функцията да терминира при достигане края на едно от числата.
(define (combine-numbers-with-plus first second g) ; Stupid name, but whatever
  (combine-numbers first second g 0 +))

(define tests
  (test-suite "Combine numbers tests"
      ; Защото (remainder k k) = 0
      (check-equal? (combine-numbers-with-plus 123 123 remainder) 0)
      ; Защото (4 * 9) + (2 * 8) = 52
      (check-equal? (combine-numbers-with-plus 421384 98 *) 52)
      ; Защото (1 < 7) -> 1, (2 = 2) -> 0, (5 > 3) -> 0, (9 = 9) -> 0, (3 < 7) -> 1
      (check-equal? (combine-numbers-with-plus 12593 72397 (lambda (x y) (if (< x y) 1 0))) 2)
      ; Като горния тест, но с по-късо второ число.
      (check-equal? (combine-numbers-with-plus 2713 98 (lambda (x y) (if (< x y) 1 0))) 2)
      ; Като горния тест, но с по-късо първо число.
      (check-equal? (combine-numbers-with-plus 213 91423 (lambda (x y) (if (< x y) 1 0))) 2)
      ; Тестове на по-общата версия
      (check-equal? (combine-numbers 123 123 remainder 0 +) 0)
      (check-equal? (combine-numbers 421384 98 * 0 +) 52)
      (check-equal? (combine-numbers 12593 72397 (lambda (x y) (if (< x y) 1 0)) 0 +) 2)
      (check-equal? (combine-numbers 2713 98 (lambda (x y) (if (< x y) 1 0)) 0 +) 2)
      (check-equal? (combine-numbers 213 91423 (lambda (x y) (if (< x y) 1 0)) 0 +) 2)
      (check-equal? (combine-numbers 213 91423 + 1 *) 154)
      (check-equal? (combine-numbers 7568913759 123789156 + 1 *) 678585600)
      (check-equal? (combine-numbers 555 555 bitwise-xor 0 +) 0)
      (check-equal? (combine-numbers 555 555 bitwise-xor 1 *) 0)
      (check-equal? (combine-numbers 5874639123 2175525 bitwise-xor 0 +) 33)
      (check-equal? (combine-numbers 5874639123 2175525 + 0 bitwise-xor) 9)
  )
)

(run-tests tests 'verbose)
