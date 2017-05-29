#lang racket

(require "../core/image.rkt")
(require "../gui/display.rkt")
(require "../gui/simple.rkt")

;; read image and convert it to RGB matrix
(define image (read-image "sample.jpg"))
(define color-image (image->matrix image #:type 'rgb))

;; Get rect of color image and slicing it from matrix
(define r (get-image-rect image))
(define slice-image (slice-matrix color-image r))

;;Show result
(show-bitmap (matrix->image slice-image #:type 'rgb))
