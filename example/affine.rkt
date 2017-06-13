#lang racket

(require "../core/affine.rkt")
(require "../core/image.rkt")
(require "../gui/simple.rkt")

(define image (read-image "sample.jpg"))

(show-bitmap image)
(show-bitmap (rotate-image image (degrees->radians 45)))
(show-bitmap (rotate-image image (degrees->radians 45) #:x 15 #:y 50))
(show-bitmap (scale-image image 0.5 0.5))
(show-bitmap (scale-image image 0.5 0.5 #:x 35 #:y 35))