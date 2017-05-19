#lang racket

(require "../core/image.rkt")
(require "../core/brightness.rkt")
(require "../gui/simple.rkt")

;; Read image
(define image (read-image "sample2.jpg"))
;; And get width and height of it
(define w (send image get-width))
(define h (send image get-height))

;; Convert to grayscale
(define gl (image->graylist image))

;; Show original, grayscale and negative images
(show-bitmap image)
(show-bitmap (graylist->image gl w h))
(show-bitmap (graylist->image (negative gl) w h))
