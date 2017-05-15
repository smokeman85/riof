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

;; lightness-gray: exact-positive-integer? exact-positive-integer? exact-positive-integer? -> exact-positive-integer?
;; Lightness method (max(r,g,b) + min(r,g,b))/2
(define (lightness-gray r g b)
  (exact-round (/ (+ (max r g b) (min r g b)) 2)))

;; average-gray: exact-positive-integer? exact-positive-integer? exact-positive-integer? -> exact-positive-integer?
;; Average method (r + g + b)/3
(define (average-gray r g b)
  (exact-round (/ (+ r g b) 3)))

;; luminosity-gray : exact-positive-integer? exact-positive-integer? exact-positive-integer? -> exact-positive-integer?
;; Luminosity method is 0.21 r + 0.72 g + 0.07 b
(define (luminosity-gray r g b)
  (exact-round (+ (* 0.21 r) (* 0.72 g) (* 0.07 b))))

;; rgb->gray : exact-positive-integer? exact-positive-integer? exact-positive-integer? gray-method? -> exact-positive-integer?
;; RGB to grayscale
(define (rgb->gray r g b method)
  (cond
    [(symbol=? method 'lightness) (lightness-gray r g b)]
    [(symbol=? method 'average) (average-gray r g b)]
    [(symbol=? method 'luminosity) (luminosity-gray r g b)]))

;; make-gray-matrix: exact-positive-integer? exact-positive-integer? bytes? gray-method? -> matrix?
;; Make grayscale matrix
(define (make-gray-matrix width height buffer method)
  (build-matrix width height (lambda (x y)
                               (rgb->gray (bytes-ref buffer (+ (offset-at x y width) 1))
                                          (bytes-ref buffer (+ (offset-at x y width) 2))
                                          (bytes-ref buffer (+ (offset-at x y width) 3))
                                          method))))

;; image->gray-matrix : bitmap? gray-method? -> matrix?
;; Convert bitmap to grayscale matrix
(define (image->gray-matrix image #:method [method 'luminosity])
  (define w (send image get-width))
  (define h (send image get-height))
  (define buffer (make-bytes (* w h 4)))
  (send image get-argb-pixels 0 0 w h buffer)
  (make-gray-matrix w h buffer method))

;(define a (image->gray-matrix (read-image "sample.bmp")))
