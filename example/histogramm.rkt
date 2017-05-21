#lang racket

(require "../core/image.rkt")
(require "../core/brightness.rkt")
(require "../gui/simple.rkt")

;; Read image
(define image (read-image "sample.jpg"))

(displayln (send image get-width))
(displayln (send image get-height))
;; Convert to grayscale
(define gl (image->graylist image))

;; Histogramm and norma
(define hist (histogramm gl))

(show-bitmap image)
;; Show result
(show-hist hist)

