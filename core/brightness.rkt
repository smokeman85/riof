#lang racket

(require plot)

;; histogramm : list? list? -> list?
;; Calc histogramm of data
(define (histogramm data h)
  (cond
    [(empty? data) h]
    [else (histogramm (rest data)
                     (list-set h (first data)
                               (add1 (list-ref h (first data)))))]))

;; show-hist : lst -> void?
;; Plot histogramm
(define (show-hist h)
  (define x (build-list (length h) values))
  (plot (points (map vector x h))))
