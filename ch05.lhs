>module CH05 where

1.  Unsing a list comprehension, give an expression that calculates the sum
    1^2 + 2^2 + ... 100^2 of the first one hundred integer squares.

    ---------------------------------------------------------------------------

    One way to calculate this would be:

>question1 = sum [ x^2 | x <- [1 .. 100]]
