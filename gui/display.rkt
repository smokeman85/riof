#lang racket/gui

(require "../core/point.rkt")

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
    (init-field [p0 (point 0 0)]
                [r (rect 0 0 0 0)])

    (define/private (update-end-point x y)
      (set-field! r this (build-rect p0 (point x y))))

    (define/private (draw-rectangle x y)
      (define old-x (point-x (get-field p0 this)))
      (define old-y (point-y (get-field p0 this)))
      (define w (abs (- old-x x)))
      (define h (abs (- old-y y)))
      (send (get-dc) draw-rectangle old-x old-y w h))

    (define/override (on-event event)
      (define x (send event get-x))
      (define y (send event get-y))
      (send msg set-label (format "x:~a, y:~a" x y))
      (cond
        [(and (send event button-changed? 'left) (send event button-down? 'left))
         (set-field! p0 this (point x y))]
        [(and (send event button-changed? 'left) (send event button-up? 'left))
         (send this on-paint)
         (send (get-dc) set-brush "red" 'transparent)
         (draw-rectangle x y)]))))
    

(define canvas (new bitmap-canvas% [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       (send dc draw-bitmap image 0 0))]))

(send frame show #t)

