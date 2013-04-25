>module CH02 where

1.  Parenthesize the following arithmetic expressions:
        2 ^ 3 * 4
        2 * 3 + 4 * 5
        2 + 3 * 4 ^ 5

    ---------------------------------------------------------------------------

    The arithmetic expressions would be parenthesized as:

        1.  2 ^ 3 * 4
            (2 ^ 3) * 4

        #.  2 * 3 + 4 * 5
            (2 * 3) + (4 * 5)

        #.  2 + 3 * 4 ^ 5
            2 + (3 * (4 ^ 5))

    The following Haskell expressions can confirm that the results are correct;
    they should all return `True`.

        1.  `2 ^ 3 * 4 == (2 ^ 3) * 4`

        #.  `2 * 3 + 4 * 5 == (2 * 3) + (4 * 5)`

        #.  `2 + 3 * 4 ^ 5 == 2 + (3 * (4 ^ 5))`

2.  Work through the examples from this chapter using Hugs.

    ---------------------------------------------------------------------------

>double    x = x + x

>quadruple x = double (double x)

>factorial n = product [1..n]

>average ns = sum ns `div` length ns
