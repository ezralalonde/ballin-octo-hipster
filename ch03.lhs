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
