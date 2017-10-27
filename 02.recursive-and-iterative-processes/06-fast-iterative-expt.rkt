#lang racket
(require rackunit)
(require rackunit/text-ui)

; Стъпвайки на дефиницията за бързо повдигане на степен,
; търсим такава, която генерира итеративен процес
(define (expt x n)
  (define (expt-inner base power result-accumulator) 
    ; (floor (/ ... 2)) could be replaced by a single quotient in Racket
	(cond
      ((= power 0) result-accumulator)
      ((= (mod power 2) 1) (expt-inner (* base base) (floor (/ power 2)) (* result-accumulator base)))
      (else (expt-inner (* base base) (floor (/ power 2)) result-accumulator))))

  (expt-inner x n 1))

(define tests
  (test-suite "expt tests"
    (check-equal? (expt 4 4) 256)
    (check-equal? (expt 29139123 0) 1)
    (check-equal? (expt 3 4) 81)
    (check-equal? (expt 2 1) 2)
  )
)

(run-tests tests 'verbose)
