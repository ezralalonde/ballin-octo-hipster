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

3.  The script below contains three syntactic errors.  Correct these errors
    and then check that your script works properly using Hugs.

    N = a 'div' length xs
        where
             a = 10
            xs = [1, 2, 3, 4, 5]

    ---------------------------------------------------------------------------

    The definition of this function would properly be:

>q3 = a `div` length xs
>     where
>       a  = 10
>       xs = [1, 2, 3, 4, 5]

    The three errors are as follows:

        1.  The name of a function must start with a lowercase letter.
            `N` is not legal, so it has bee substituted with `q3`, which is.

        #.  The symbol "'" is used instead of "`" for infix notation.
            The symbols surrounding `div` have been changed.

        #.  The letter `a` is indented more than `xs` underneath it.
            This violates the Haskell indentation rules, so it must be changed
            to instead have the `a` and `x` (from `xs`) in the same column.
