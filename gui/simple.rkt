#lang racket/gui

;; show-bitmap : bitmap? [string?] -> frame
;; Simple view of bitmap with label
(define (show-bitmap image #:label [label "Bitmap"])
  (define f (new frame% [label label]))
  (new message% [parent f] [label image])
  (send f show #t))

(define (show-bitmap-lock image #:label [label "Bitmap"])
  (define lock-thread (thread (lambda ()
                         (let loop ()
                           (sleep 0.2)
                           (loop)))))
  (define f (new frame% [label label]))
  (new message% [parent f] [label image])
  (new button% [parent f]
       [label "Exit"]
             [callback (lambda (button event)
                         (send f show #f)
                         (kill-thread lock-thread))])
  (send f show #t)
  (yield (thread-dead-evt lock-thread)))

(provide (contract-out
          [show-bitmap (->* (object?) (#:label string?) any)]))


(require "../core/image.rkt")
(define image (read-image "../example/sample.jpg"))
(show-bitmap-lock image)
(displayln "End")
