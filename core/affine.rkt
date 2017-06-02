#lang racket

(require math/matrix)

(define (scale val)
  (exact-round (/ val 2)))  

(define (offset x y w)
  (+ x (* y w)))

(define (affine-scale matrix)
  (define w (matrix-num-cols matrix))
  (define h (matrix-num-rows matrix))
  (define l (make-list (* w h) 0))
  (for ([x (in-range h)])
    (for ([y (in-range w)])
      (define rx (scale x))
      (define ry (scale y))
      (set! l (list-set l (offset rx ry w) (matrix-ref matrix x y))))) ;<- too slow alg.
  (list->matrix w h l))

; Test
(require "image.rkt")
(require "../gui/simple.rkt")

(define image (read-image "../example/sample.jpg"))
(define gray (image->matrix image))
(show-bitmap (matrix->image gray))
(show-bitmap (matrix->image (affine-scale gray)))

