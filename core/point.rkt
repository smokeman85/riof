#lang racket

(struct point (x y) #:mutable)

(struct rect (x0 y0 x1 y1) #:mutable)

(define (build-rect p0 p1)
  (rect (point-x p0) (point-y p0)
        (point-x p1) (point-y p1)))

(define (print-point p)
  (displayln (format "x:~a y:~a"
                     (point-x p)
                     (point-y p))))

(define (print-rect r)
  (displayln (format "x0:~a y0:~a x1:~a y1:~a"
                     (rect-x0 r) (rect-y0 r)
                     (rect-x1 r) (rect-y1 r))))

(provide (contract-out
          [struct point ((x real?)
                         (y real?))]
          [struct rect ((x0 real?)
                        (y0 real?)
                        (x1 real?)
                        (y1 real?))]
          [build-rect (-> point? point? rect?)]
          [print-point (-> point? void?)]
          [print-rect (-> rect? void?)]))