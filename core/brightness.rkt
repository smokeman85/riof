#lang racket

(require plot)

(plot-new-window? #t)

;;Max count of brightness
(define max-brightness 256)
(define h-list (make-list max-brightness 0))

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

;; Plot histogramm
(define (show-hist h)
  (define x (build-list (length h) values))
  (plot (points (map vector x h) #:sym 'fullcircle3)
        #:title "Brightness histogramm"
        #:x-label "Brightness" #:y-label "Count"))

;; Negative list
;; x = max(list)-x
(define (negative gray-list)
  (define max-brightness (apply max gray-list))
  (map (lambda (x) (- max-brightness x)) gray-list))

;; Normalize list
(define (normalize hist-lst)
  (define len (length hist-lst))
  (map (lambda (x)(/ x len)) hist-lst))

(provide (contract-out
          [histogramm (-> list? list?)]
          [show-hist (-> list? any)]
          [negative (-> list? list?)]
          [normalize (-> list? list?)]))
