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
    (inherit get-width get-height refresh get-dc)
    (super-new)

    (init-field [old-x 0] [old-y 0])
    
    (define/override (on-event event)
      (send msg set-label (format "x:~a, y:~a" (send event get-x) (send event get-y)))
      (cond
        [(and (send event button-changed? 'left) (send event button-down? 'left))
         (set-field! old-x this (send event get-x))
         (set-field! old-y this (send event get-y))]
        [(and (send event button-changed? 'left) (send event button-up? 'left))
         (send (get-dc) set-brush "red" 'transparent) 
         (send msg set-label (format "old x:~a, y:~a" (get-field old-x this) (get-field old-y this)))
         (send (get-dc) draw-rectangle (get-field old-x this) (get-field old-y this)
               (- (send event get-x) (get-field old-x this)) (- (send event get-y) (get-field old-y this)))]))))
    

(define canvas (new bitmap-canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (send dc draw-bitmap image 0 0))]))
(send frame show #t)

