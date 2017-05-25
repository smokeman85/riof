#lang scribble/manual

@title{Image module}

@(require (for-label racket/draw math/matrix "../core/image.rkt"))
@defmodule["core/image.rkt" #:use-sources ("../core/image.rkt")]

Reading image and transforming it to matrix or list formats.

@defproc[(read-image  (path string?)) object?]{
Read image from file system. See bitmap% docs for more info.                                             
}

@defproc[(image->matrix (image object?) (#:type type image-type? 'gray)
                        ( #:method method gray-method? 'luminosity)) matrix?]{
Convert bitmap object to matrix.
 @itemlist[
          @item{@racket[type] may be 'rgb or 'gray. For 'rgb type each element of
   matrix is rgb struct. For 'gray type used grayscale method.}
          @item{@racket[method] may be 'lightness, 'average or 'luminosity.}
 ]
}

@defproc[(matrix->image (matrix matrix?) (#:type type image-type? 'gray)) object?]{
Convert matrix to bitmap object.
 @itemlist[
          @item{@racket[type] may be 'rgb or 'gray. This is type of matrix element.}
 ]
}

@defproc[(image->graylist (image object?) (#:method method gray-method? 'gray)) list?]{
Convert image object to list.
@itemlist[
          @item{@racket[method] may be 'lightness, 'average or 'luminosity.}
 ]
}

@defproc[(graylist->image (gray-list list?)
                          (width exact-nonnegative-integer?) (height exact-nonnegative-integer?)) object?]{
Convert grayscale list to bitmap object
}
