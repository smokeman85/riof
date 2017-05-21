#lang racket

(require "../core/image.rkt")
(require "../core/brightness.rkt")
(require "../gui/simple.rkt")

;; Read image
(define image (read-image "dark.jpg"))

;; Convert to grayscale
(define gl (image->graylist image))

;; Histogramm and it equalization
(define hist (histogramm gl))
(define hist-equal (equalize gl))

;; Show it
(show-hist hist)
(show-hist hist-equal)

(define w (send image get-width))
(define h (send image get-height))

;; Show images
(show-bitmap (graylist->image gl w h))
(show-bitmap (graylist->image (equalize-pixel gl) w h))
