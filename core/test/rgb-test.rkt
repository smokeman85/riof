#lang racket

(require rackunit "../rgb.rkt")
 (require rackunit/text-ui)

(define-test-suite module-test
  (test-equal? "Check lightness-gray"
               (lightness-gray 10 20 30) 20)
  (test-equal? "Check average-gray"
               (average-gray 10 20 30) 20)
  (test-equal? "Check luminosity-gray"
               (luminosity-gray 1 1 1) 1)
  (test-pred "Check gray->rgb"
               rgb? (gray->rgb 0))
  (test-pred "Check gray->argb"
               argb? (gray->argb 0)))

(run-tests module-test)

