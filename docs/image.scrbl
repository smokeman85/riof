#lang scribble/manual

@title{Image module}

@(require (for-label racket/draw math/matrix "../core/image.rkt"))
@defmodule["core/image.rkt" #:use-sources ("../core/image.rkt")]

Reading image and transforming it to matrix or list.

@defproc[(read-image  (path string?)) object?]{
Read image from file system. See bitmap% docs for more info.                                             
}

