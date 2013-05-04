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


3.  A triple(x, y, z) of positive integers is *pythagorean* if x^2 = y^2 = z^2.
    Using a list comprehension, define a function 
    `pyths :: Int -> [(Int, Int, Int)]` that returns the list of all 
    pythagorean triples whose components re at most a given limit.  For
    example:

        > pyths 10
        [(3, 4, 5), (4, 3, 5), (6, 8, 10), (8,6 10)]

    ---------------------------------------------------------------------------

>pyths :: Int -> [(Int, Int, Int)]
>pyths n = [(x, y, z) | x <- [1..n],
>                       y <- [1..n],
>                       z <- [1..n], x^2 + y^2 == z^2]

