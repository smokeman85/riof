#lang scribble/manual

@title{RGB module}

@(require (for-label racket "../core/rgb.rkt"))
@defmodule["core/rgb.rkt" #:use-sources ("../core/rgb.rkt")]
This module for manipulating RGB color.

@defstruct[rgb ([r exact-nonnegative-integer?]
                [g exact-nonnegative-integer?]
                [b exact-nonnegative-integer?])]{
struct of RGB 
}

@defstruct[argb ([a exact-nonnegative-integer?]
                [r exact-nonnegative-integer?]
                [g exact-nonnegative-integer?]
                [b exact-nonnegative-integer?])]{
struct of ARGB 
}

@defproc[(lightness-gray (r exact-nonnegative-integer?)
                         (g exact-nonnegative-integer?)
                         (b exact-nonnegative-integer?))
         exact-nonnegative-integer?]{
Lightness method: (max(r,g,b) + min(r,g,b))/2                      
}

@defproc[(average-gray (r exact-nonnegative-integer?)
                         (g exact-nonnegative-integer?)
                         (b exact-nonnegative-integer?))
         exact-nonnegative-integer?]{
Average method: (r + g + b)/3            
}

@defproc[(luminosity-gray (r exact-nonnegative-integer?)
                         (g exact-nonnegative-integer?)
                         (b exact-nonnegative-integer?))
         exact-nonnegative-integer?]{
Luminosity method: 0.21 r + 0.72 g + 0.07 b            
}

@defproc[(gray->rgb (val exact-nonnegative-integer?)) rgb?]{
Convert gray value to rgb format
}




