>module CH04 where

1.  Using library functions, define a function

        halve :: [a] -> ([a], [a])

    that splits an even-lengthed list into two halves.  For example:

        >halve [1, 2, 3, 4, 5, 6]
        ([1, 2, 3], [4, 5, 6])

    --------------------------------------------------------------------------

>halve :: [a] -> ([a], [a])
>halve xs = (first_half, second_half)
>           where
>               half        = div (length xs) 2 
>               first_half  = take half xs
>               second_half = drop half xs
    
    This results in the following:

        *CH04> halve [1..6]
        ([1,2,3],[4,5,6])

2.  Consider a function `safetail :: [a] -> [a]` that behaves as the library
    function `tail`, except that `safetail` maps the empty list to itself, 
    whereas `tail` produces an error in this case.  Define `safetail` using:

        a.  a condidional expression;
        b.  guarded equations;
        c.  pattern matching.

    Hint: make use of the library function `null`.
    
    --------------------------------------------------------------------------

>safetailA xs = if null xs then xs else tail xs

>safetailB xs 
>   | null xs   = xs
>   | otherwise = tail xs

>safetailC []     = []
>safetailC (x:xs) = xs

3.  In a similar way to `&&`, show how the logical disjunction operator `||`
    can be defined in four different ways using pattern matching.

    --------------------------------------------------------------------------

>myOr1 True  _     = True
>myOr1 _     True  = True
>myOr1 _     _     = False

>myOr2 True  _ = True
>myOr2 False x = x

>myOr3 False False = False
>myOr3 _     _     = True

>myOr4 x y 
>   | x /= y    = True  -- if they're different, one is True
>   | otherwise = x     -- if they're the same, we can return either.

4.  Redefine the following version of the conjuction operator using conditional
    expressions rather than pattern matching:

        True && True = True
        _    && _    = False

    --------------------------------------------------------------------------

    This is ugly, but I think it's what was asked for:

>myAnd x y = if x
>               then if y
>                       then True
>                       else False
>               else False

5.  Do the same for the following version, and note the difference in the 
    number of conditional expressions required:

        True  && b = b
        False && _ = False

    --------------------------------------------------------------------------

>myAnd5 x y = if x
>               then y
>               else False

6.  Show how the curried function definition `mult x y z = x * y * z` can be
    understood in terms of lambda expressions.

    --------------------------------------------------------------------------

    The expression above is equivalent to:

        mult = \x -> \y -> \z -> x * y * z

    with parentheses in place to make the ordering more clear, it's:

        mult = \x -> (\y -> (\z -> x * y * z))

    When evaluated, the `x` is given the first attribute and returns a function
    on `y` and `z`.

    For example `mult 3` would be `\y -> \z -> 3 * y * z`.
    `mult 3 4` would be `\z -> 3 * 4 * z`, and
    `mult 3 4 5` would be `3 * 4 * 5`, or `60`.
