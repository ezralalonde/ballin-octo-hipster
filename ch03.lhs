>module CH03 where

1.  What are the types of the following values?

        ['a', 'b', 'c']
        ('a', 'b', 'c')
        [(False, 'O'), (True, '1')]
        ([False, True], ['0', '1'])
        [tail, init, reverse]

    --------------------------------------------------------------------------

    1.  `['a', 'b', 'c']` is `[Char]`: a list of characters.
    #.  `('a', 'b', 'c']` is `(Char, Char, Char)`: a 3-tuple of characters.
    #.  `[(False, '0'), (True, '1')` is `[(Bool, Char)]`: a list of tuples.
    #.  `([False, True], ['0', '1'])` is `([Bool], [Char])`: a tuple of lists.
    #.  `[tail, init, reverse]` is `[([a] -> [a])]`: a list of functions.

2.  What are the types of the following functions?

        second xs       = head (tail xs)
        swap (x, y)     = (y, x)
        pair x y        = (x, y)
        double x        = x * 2
        palindrome xs   = reverse xs == xs
        twice f x       = f (f x)

    Hint: take care to include the necessary class constraints if the functions
    are defined using overloaded operators.

    ---------------------------------------------------------------------------

    1.  `second xs` is `[a] -> a`
    #.  `swap (x, y) is `(a, b) -> (b, a)`
    #.  `pair x y` is `a -> b -> (a, b)`
    #.  `double x` is `Num a => a -> a`
    #.  `palindrome xs` is `Eq a => [a] -> Bool`
    #.  `twice f x` is `(a -> a) -> a -> a`     
