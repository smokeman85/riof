#lang racket

(require "../core/image.rkt")
(require "../core/brightness.rkt")
(require "../gui/simple.rkt")

;; Read image
(define image (read-image "sample.jpg"))

;; Convert to grayscale
(define gl (image->graylist image))

;; Histogramm
(define hist (histogramm gl))
;; Normilize it
(define norm-hist (normalize hist))

;; Show result
(show-hist hist)
(show-hist norm-hist)

