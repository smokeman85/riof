#lang racket/gui

(require "../core/image.rkt")
(define image (read-image "../example/sample.jpg"))

(define frame (new frame%
                   [label "Bitmap"]
                   [width (send image get-width)]
                   [height (send image get-height)]))

(define msg (new message% [parent frame]
                          [label ""]))

(define bitmap-canvas%
  (class canvas%
    (inherit get-dc)
    (super-new)

    ;; start point for rectangle
    (init-field [old-x 0] [old-y 0])

    (define/private (draw-rectangle x y)
      (define old-x (get-field old-x this))
      (define old-y (get-field old-y this))
      (define w (abs (- old-x x)))
      (define h (abs (- old-y y)))
      (send (get-dc) draw-rectangle old-x old-y w h))

    (define/override (on-event event)
      (send msg set-label (format "x:~a, y:~a" (send event get-x) (send event get-y)))
      (cond
        [(and (send event button-changed? 'left) (send event button-down? 'left))
         (set-field! old-x this (send event get-x))
         (set-field! old-y this (send event get-y))]
        [(and (send event button-changed? 'left) (send event button-up? 'left))
         (send this on-paint)
         (send (get-dc) set-brush "red" 'transparent)
         (draw-rectangle (send event get-x) (send event get-y))]))))
    

(define canvas (new bitmap-canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc draw-bitmap image 0 0))]))
(send frame show #t)

