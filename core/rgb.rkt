#lang racket

;; RGB struct
(define-struct rgb (r g b))

;; Lightness method (max(r,g,b) + min(r,g,b))/2
(define (lightness-gray r g b)
  (exact-round (/ (+ (max r g b) (min r g b)) 2)))

;; Average method (r + g + b)/3
(define (average-gray r g b)
  (exact-round (/ (+ r g b) 3)))

;; Luminosity method is 0.21 r + 0.72 g + 0.07 b
(define (luminosity-gray r g b)
  (exact-round (+ (* 0.21 r) (* 0.72 g) (* 0.07 b))))

;; Convert grayscale to RGB
(define (gray->rgb val)
  (rgb val val val))

(provide (contract-out
          [struct rgb ((r exact-nonnegative-integer?)
                       (g exact-nonnegative-integer?)
                       (b exact-nonnegative-integer?))]
          [lightness-gray (-> exact-nonnegative-integer?
                              exact-nonnegative-integer?
                              exact-nonnegative-integer?
                              exact-nonnegative-integer?)]
          [average-gray (-> exact-nonnegative-integer?
                            exact-nonnegative-integer?
                            exact-nonnegative-integer?
                            exact-nonnegative-integer?)]
          [luminosity-gray (-> exact-nonnegative-integer?
                               exact-nonnegative-integer?
                               exact-nonnegative-integer?
                               exact-nonnegative-integer?)]
          [gray->rgb (-> exact-nonnegative-integer? rgb?)]))
