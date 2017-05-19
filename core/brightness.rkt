#lang racket

(require plot)

(plot-new-window? #t)

;;Max count of brightness
(define max-brightness 256)
(define h-list (make-list max-brightness 0))

;;histogramm : list? -> list?
;; Histogramm of brightness-list
(define (histogramm brightness-list)
  (make-histogramm brightness-list h-list))

;; make-histogramm : list? list? -> list?
;; Make histogramm of data
;; For example (make-histogramm '(1 1 0 0 0) '(0 0 0)) -> '(3 2 0)
(define (make-histogramm data h)
  (cond
    [(empty? data) h]
    [else (make-histogramm (rest data)
                     (list-set h (first data)
                               (add1 (list-ref h (first data)))))]))

;; show-hist : lst -> void?
;; Plot histogramm
(define (show-hist h)
  (define x (build-list (length h) values))
  (plot (points (map vector x h) #:sym 'fullcircle3)
        #:title "Brightness histogramm"
        #:x-label "Brightness" #:y-label "Count"))

(provide (contract-out
          [histogramm (-> list? list?)]
          [show-hist (-> list? any)]))
