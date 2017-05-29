#lang racket/gui

;; show-bitmap : bitmap? [string?] -> frame
;; Simple view of bitmap with label
(define (show-bitmap image #:label [label "Bitmap"])
  (define f (new frame% [label label]))
  (new message% [parent f] [label image])
  (send f show #t))

;; show-bitmap : bitmap? [string?] -> frame
;; Simple view of bitmap with label and lock main thread
(define (show-bitmap-lock image #:label [label "Bitmap"])
  (define lock-thread (thread (lambda () (let loop ()
                                           (loop)))))
  (define f (new frame% [label label]))
  (new message% [parent f] [label image])
  (new button% [parent f]
       [label "Continue..."]
       [callback (lambda (button event)
                   (send f show #f)
                   (kill-thread lock-thread))])
  (send f show #t)
  (yield (thread-dead-evt lock-thread)))

(provide (contract-out
          [show-bitmap (->* (object?) (#:label string?) any)]
          [show-bitmap-lock (->* (object?) (#:label string?) any)]))

