#lang racket

(require plot)

(plot-new-window? #t)

;;Max count of brightness
(define max-brightness 256)
(define h-list (make-list max-brightness 0))

;; Normalize list
(define (normalize hist-lst len)
  (map (lambda (x) (/ x len)) hist-lst))

;; Histogramm of brightness-list
(define (histogramm brightness-list #:method [method 'norm])
  (define hist (make-histogramm brightness-list h-list))
  (cond
    [(symbol=? method 'norm) (normalize hist (length brightness-list))]
    [else hist]))

;; Part sum of list
;; '(1 2 3) -> (list (+ 1 0) (+ 1 2) (+ 1 2 3))
(define (part-list-sum list sum)
  (cond
    [(empty? list) empty]
    [else (cons (+ sum (first list)) (list-sum (rest list) (+ sum (first list))))]))

;; Histogram equalization
(define (equalize brightness-list)
  (define norm-hist (histogramm brightness-list))
  (part-list-sum norm-hist 0))

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

(provide (contract-out
          [histogramm (->* (list?) (#:method symbol?) list?)]
          [show-hist (-> list? any)]
          [negative (-> list? list?)]
          [equalize (-> list? list?)]))
