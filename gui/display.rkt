#lang racket/gui

(require "../core/point.rkt")

(define bitmap-canvas%
  (class canvas%

    (inherit get-dc)
    (super-new)

    ;; start point for rectangle
    (init-field [p0 (point 0 0)]
                [r (rect 0 0 0 0)])

    ;; Get rect
    (define/public (get-rect)
      r)

    ;; Build rect by end point
    (define/private (update-end-point x y)
      (set-field! r this (build-rect p0 (point x y))))

    ;; Draw rectangle with end x and y of image
    (define/private (draw-rectangle x y)
      (define old-x (point-x (get-field p0 this)))
      (define old-y (point-y (get-field p0 this)))
      (define w (abs (- old-x x)))
      (define h (abs (- old-y y)))
      (update-end-point x y)
      (send (get-dc) draw-rectangle old-x old-y w h))

    (define/override (on-event event)
      (define x (send event get-x))
      (define y (send event get-y))
      (cond
        ;; First mouse left click and pressed
        [(and (send event button-changed? 'left) (send event button-down? 'left))
         (set-field! p0 this (point x y))]
        ;; Left mouse button is up
        [(and (send event button-changed? 'left) (send event button-up? 'left))
         (send this on-paint)
         (send (get-dc) set-brush "red" 'transparent)
         (draw-rectangle x y)]))))

(define (get-image-rect image)
  (define lock-thread (thread (lambda () (let loop ()
                                           (loop)))))
  (define frame (new frame%
                     [label "Bitmap"]
                     [width (send image get-width)]
                     [height (send image get-height)]))
  (define canvas (new bitmap-canvas% [parent frame]
                      [paint-callback
                       (lambda (canvas dc)
                         (send dc draw-bitmap image 0 0))]))
  (new button% [parent frame]
       [label "Get rect"]
       [callback (lambda (button event)
                   (send frame show #f)
                   (kill-thread lock-thread))])
  (send frame show #t)
  (yield (thread-dead-evt lock-thread))
  (send canvas get-rect))

(provide (contract-out
           [get-image-rect (-> object? rect?)]))
