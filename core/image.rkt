#lang racket

(require racket/draw)
(require math/matrix)

(require "rgb.rkt")

;; read-image : string? -> bitmap?
;; Make bitmap object
(define (read-image image-path)
  (make-object bitmap% image-path))

;; offset = (y*w + x)*4
;; multiplier is 4 because '(alfa r g b)
(define (offset-at x y w) (* 4 (+ (* y w) x)))

;; Create matrix with RGB elements
;; (matrix-ref a x y) -> rgb
(define (make-rgb-matrix width height buffer)
  (matrix-transpose (build-matrix width height (lambda (x y)
                               (rgb (bytes-ref buffer (+ (offset-at x y width) 1))
                                    (bytes-ref buffer (+ (offset-at x y width) 2))
                                    (bytes-ref buffer (+ (offset-at x y width) 3)))))))

;; RGB to grayscale
(define (rgb->gray r g b method)
  (cond
    [(symbol=? method 'lightness) (lightness-gray r g b)]
    [(symbol=? method 'average) (average-gray r g b)]
    [(symbol=? method 'luminosity) (luminosity-gray r g b)]))

;; Make grayscale matrix
(define (make-gray-matrix width height buffer method)
  (matrix-transpose (build-matrix width height (lambda (x y)
                               (rgb->gray (bytes-ref buffer (+ (offset-at x y width) 1))
                                          (bytes-ref buffer (+ (offset-at x y width) 2))
                                          (bytes-ref buffer (+ (offset-at x y width) 3))
                                          method)))))

(define (gray-list->bytes lst)
  (list->bytes (flatten (map (lambda (a) (list 0 a a a)) lst))))

;; Convert matrix grayscale to bytes
(define (gray-matrix->bytes matrix)
  (define m-list (matrix->list matrix))
  (gray-list->bytes m-list))

(define (rgb-matrix->bytes matrix)
  (define m-list (matrix->list matrix))
  (list->bytes (flatten (map (lambda (a) (list 0 (rgb-r a) (rgb-g a) (rgb-b a))) m-list))))

;; Convert image to matrix or bytes
(define (image->matrix image #:type [type 'gray] #:method [method 'luminosity])
  (define w (send image get-width))
  (define h (send image get-height))
  (define buffer (make-bytes (* w h 4)))
  (send image get-argb-pixels 0 0 w h buffer)
  (cond
    [(symbol=? type 'gray) (make-gray-matrix w h buffer method)]
    [(symbol=? type 'rgb) (make-rgb-matrix w h buffer)]))

;; Convert matrix to image
(define (matrix->image matrix #:type [type 'gray])
  (define h (matrix-num-rows matrix))
  (define w (matrix-num-cols matrix))
  (define buffer (make-bytes (* w h 4)))
  (define bmp (make-object bitmap% w h))
  (cond
    [(symbol=? type 'gray) (send bmp set-argb-pixels 0 0 w h (gray-matrix->bytes matrix))]
    [(symbol=? type 'rgb)  (send bmp set-argb-pixels 0 0 w h (rgb-matrix->bytes matrix))])
  bmp)

;; Convert image to list of grayscale
(define (image->graylist image #:method [method 'luminosity])
  (matrix->list (image->matrix image #:method method)))

;; Convert list of grayscale to image
(define (graylist->image gray-list width height)
  (define buffer (make-bytes (* width height 4)))
  (define bmp (make-object bitmap% width height))
  (send bmp set-argb-pixels 0 0 width height (gray-list->bytes gray-list))
  bmp)

(define (image-type? a)
  (or (symbol=? a 'rgb) (symbol=? a 'gray)))

(define (gray-method? a)
  (or (symbol=? a 'lightness) (symbol=? a 'average) (symbol=? a 'luminosity)))

(provide (contract-out
          [read-image (-> string? object?)]
          [image->matrix (->* (object?) (#:type image-type? #:method gray-method?) matrix?)]
          [matrix->image (->* (matrix?) (#:type image-type?) object?)]
          [image->graylist (->* (object?) (#:method gray-method?) list?)]
          [graylist->image (-> list? exact-nonnegative-integer? exact-nonnegative-integer? object?)]))
