#lang racket/gui

;; show-bitmap : bitmap? [string?] -> frame
;; Simple view of bitmap with label
(define (show-bitmap image #:label [label "Bitmap"])
  (define f (new frame% [label label]))
  (new message% [parent f] [label image])
  (send f show #t))
