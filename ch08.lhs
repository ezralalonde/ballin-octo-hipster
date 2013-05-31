> module CH08 where

    Note, from viewing the sources of the files that Dr. Hutton has made
    available on the site (ie. the `Parsing` library that this module imports)
    and others, I've changed the style of my literate Haskell to have a space
    after the opening `>`.

> import Parsing

1.  The library file also defines a parser `int :: Parser Int` for an integer.
    Without looking at this definition, define `int`.  Hint: an integer is
    either a minus symbol followed by a natural number, or a natural number.

    ---------------------------------------------------------------------------

> int :: Parser Int
> int = do char '-'
>          xs <- nat
>          return ((-1) * xs)
>       +++ nat
