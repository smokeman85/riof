#lang racket

(require racket/draw)
(require math/matrix)

;; RGB struct
(define-struct rgb (r g b))

;; read-image : string? -> bitmap?
;; Make bitmap object
(define (read-image image-path)
  (make-object bitmap% image-path))

;; offset-at : exact-positive-integer? exact-positive-integer? exact-positive-integer? -> exact-positive-integer?
;; offset = (y*w + x)*4
;; multiplier is 4 because '(alfa r g b)
(define (offset-at x y w) (* 4 (+ (* y w) x)))

;; make-rgb-matrixx : exact-positive-integer? exact-positive-integer? bytes? -> matrix?
;; Create matrix with RGB elements
;; (matrix-ref a x y) -> rgb
(define (make-rgb-matrix width height buffer)
  (build-matrix width height (lambda (x y)
                               (rgb (bytes-ref buffer (+ (offset-at x y width) 1))
                                    (bytes-ref buffer (+ (offset-at x y width) 2))
                                    (bytes-ref buffer (+ (offset-at x y width) 3))))))

;; image->rgb-matrix : bitmap? -> matrix?
;; Convert bitmap to matrix
(define (image->rgb-matrix image)
  (define w (send image get-width))
  (define h (send image get-height))
  (define buffer (make-bytes (* w h 4)))
  (send image get-argb-pixels 0 0 w h buffer)
  (make-rgb-matrix w h buffer))

;; image->byte : bitmap? -> bytes?
(define (image->byte image)
  (define w (send image get-width))
  (define h (send image get-height))
  (define pixels (make-bytes (* w h 4)))
  (send image get-argb-pixels 0 0 w h pixels)
  pixels)

;(define a (image->matrix (read-image "sample.bmp")))
