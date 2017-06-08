#lang racket

(require racket/draw)

(define (rotate-image image angle)
  (define w (send image get-width))
  (define h (send image get-height))
  (define bitmap-blank (make-bitmap w h))
  (define dc (make-object bitmap-dc% bitmap-blank))
  (send dc set-smoothing 'aligned)
  (send dc translate 0 h)
  (send dc rotate angle)
  (send dc draw-bitmap image 0 0)
  (send dc get-bitmap)
  (or (send dc get-bitmap) (bitmap-blank)))

; Test
(require "image.rkt")
(require "../gui/simple.rkt")

(define image (read-image "../example/sample.jpg"))

(show-bitmap image)
(define rimage (rotate-image image (degrees->radians 90)))
(show-bitmap rimage)

