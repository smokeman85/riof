#lang scribble/manual

@title{GUI module}

This module for simple show image

@(require (for-label racket/gui "../gui/simple.rkt"))
@defmodule["gui/simple.rkt" #:use-sources ("../gui/simple.rkt")]

@defproc[(show-bitmap (image object?) (#:label label string? "Bitmap"))
         any]{
Show @racket[image] with @racket[label] string. Default value of @racket[label]
     is "Bitmap"
}

Example:
@racketblock[
   (define image (read-image "image.bmp"))
   (show-bitmap image)
]