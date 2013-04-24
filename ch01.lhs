>module CH1 where

1.7:

1.  Give another possible calculation for the result of double (double 2).

    This could be calculated as:

        1. double (double 2)     -- the original question
        #. double 2 + double 2   -- expanded the outer `double`
        #. double 2 + (2 + 2)    -- expanded `double`
        #. (2 + 2) + (2 + 2)     -- expanded `double`
        #. 4 + 4                 -- performed addition
        #. 8                     -- performed addition

2.  Show that sum [x] = x for any number x.

    This would be performed as follows:

        1. sum [x]          -- the original statement
        #. x + sum []       -- applied `sum` to first element of list
        #. x + (0)          -- applied `sum []`
        #. x                -- performed addition

3.  Define a function product that produces the product of a list of numbers,
    and show using your definition that `product [2, 3, 4] = 24

>product' []     = 1 -- this is the "identity"
>product' (x:xs) = x * product xs

    `product [2, 3, 4] = 24` can be shown:

        1. product [2, 3, 4]            -- the original statement
        #. 2 * (product [3, 4])         -- applied product
        #. 2 * (3 * (product [4]))      -- applied product
        #. 2 * (3 * (4 * (product []))) -- applied product
        #. 2 * (3 * (4 * 1))            -- applied product
        #. 24                           -- performed multiplication

4.  How should the definition of the function qsort be modified so that it
    produces a reverse sorted version of a list?

    The original function was:

        qsort []     = []
        qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                       where
                           smaller = [a | a <- xs, a <= x]
                           larger  = [b | b <- xs, b >  x]

    It had the following effect:

        qsort [2, 5, 1, 4, 2]
        >>> [1, 2, 3, 4, 5]

    My definition, which follows, has the effect of reversing the
    list it is applied to:

        qsort [2, 5, 1, 4, 2]
        >>> [5, 4, 3, 2, 1]

>qsort []     = []
>qsort (x:xs) = qsort larger ++ [x] ++ qsort smaller
>               where
>                   smaller = [a | a <- xs, a <= x]
>                   larger  = [b | b <- xs, b >  x]

5.  What whould be the effect of replacing <= by < in the definition of qsort?
    Hint: consider the example qsort [2, 2, 3, 1, 1].

    The original `qsort` (from the book) would output the sorted list as below:

        qsort [2, 2, 3, 1, 1]
        >>> [1, 1, 2, 2, 3]

    If we changed the `<=` to be `<`, we would have:

        qsort [2, 2, 3, 1, 1]
        >>> [1, 2, 3]

    That is, it would remove the duplicate answers.  This is done because the
    `smaller` element of the list would no longer include elements equal to
    `x`.

    The evaluation of the first two steps would be:

        1. qsort [2, 2, 3, 1, 1]
        #. qsort [1, 1] ++ [2] + qsort [3]

    

