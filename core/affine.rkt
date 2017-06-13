#lang racket

(require racket/draw)

;; rotate-image bitmap? real? int? int? -> bitmap?
;; Rotate image to radian value around center (0,0)
;; by default
(define (rotate-image image angle #:x [x 0] #:y [y 0])
  (define w (send image get-width))
  (define h (send image get-height))
  (define bitmap-blank (make-bitmap w h))
  (define dx (/ w 2))
  (define dy (/ h 2))
  (define dc (make-object bitmap-dc% bitmap-blank))
  (define t (send dc get-transformation))
  (send dc set-smoothing 'smoothed)
  (send dc set-origin (+ x dx) (+ y dy))
  (send dc rotate angle)
  (send dc draw-bitmap image (- dx) (- dy))
  (send dc set-transformation t)
  (or (send dc get-bitmap) (bitmap-blank)))

;; scale-image bitmap? real? real? int? int? -> bitmap?
;; Scale image around center of image (0, 0)
(define (scale-image image scale-x scale-y #:x [x 0] #:y [y 0])
  (define w (send image get-width))
  (define h (send image get-height))
  (define bitmap-blank (make-bitmap w h))
  (define dx (/ w 2))
  (define dy (/ h 2))
  (define dc (make-object bitmap-dc% bitmap-blank))
  (define t (send dc get-transformation))
  (send dc set-smoothing 'smoothed)
  (send dc set-origin (+ x dx) (+ y dy))
  (send dc scale scale-x scale-y)
  (send dc draw-bitmap image (- dx) (- dy))
  (send dc set-transformation t)
  (or (send dc get-bitmap) (bitmap-blank)))

(provide (contract-out
          [rotate-image (->* (object? real?) (#:x integer? #:y integer?) object?)]
          [scale-image (->* (object? real? real?) (#:x integer? #:y integer?) object?)]))