>module CH05 where

1.  Unsing a list comprehension, give an expression that calculates the sum
    1^2 + 2^2 + ... 100^2 of the first one hundred integer squares.

    ---------------------------------------------------------------------------

    One way to calculate this would be:

>question1 = sum [ x^2 | x <- [1 .. 100]]

2.  In a similar way to the funciton `length`, show how the library function
    `replicate :: Int -> a -> [a]` that produces a list of identical elements
    can be defined using a list comprehension.  For example:

        > replicate 3 True
        [True, True, True]

    ---------------------------------------------------------------------------

    One way to define this would be:

>replicate' n e = [ e | x <- [1..n]]

    This yields

        > replicate' 3 True
        [True, True, True]
