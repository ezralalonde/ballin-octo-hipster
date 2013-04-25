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

4.  Show how the library function `last` that selects the last element of a 
    non-empty list could be defined in terms of the library functions 
    introduced in this chapter.  Can you think of another possible definition?

    ---------------------------------------------------------------------------

    The library functions introduced in this chapter include:

        1.  `length`
        #.  `div`
        #.  `sum`
        #.  `take`
        #.  `reverse`
        #.  `++`
        #.  `product`
        #.  `head`
        #.  `tail`
        #.  `!!`
        #.  `drop`

    Three ways that the function `last` could be defined include:

a.  Using `head` and `reverse`:

>last1 xs = head (reverse xs)

b.  Using recursion and pattern matching:

>last2 [x]    = x
>last2 (x:xs) = last2 xs

c.  Using `!!` and `length`:

>last3 xs = xs!!((length xs) - 1)


5.  Show how the library function `init` that removes the last element from
    a non-empty list could similarly be defined in two different ways.

a.  Using `take` and `length`

>init1 xs = take ((length xs) - 1) xs

b.  Using `reverse` and `tail`:

>init2 xs =  reverse (tail (reverse xs))

    This could be made pointless: `init2 = reverse . tail . reverse`

c.  A third way, using recursion and pattern matching:

>init3 [x]    = []
>init3 (x:xs) = x:(init3 xs)
