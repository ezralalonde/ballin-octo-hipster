> module CH08 where

    Note, from viewing the sources of the files that Dr. Hutton has made
    available on the site (ie. the `Parsing` library that this module imports)
    and others, I've changed the style of my literate Haskell to have a space
    after the opening `>`.

> import Parsing

1.  The library file also defines a parser `int :: Parser Int` for an integer.
    Without looking at this definition, define `int`.  Hint: an integer is
    either a minus symbol followed by a natural number, or a natural number.

    ---------------------------------------------------------------------------

> int :: Parser Int
> int = do char '-'
>          xs <- nat
>          return ((-1) * xs)
>       +++ nat

2.  Define a parser `comment :: Parser ()` for ordinary Haskell comments that
    begin with the symbol -- and extend to the end of the current line, which
    is represented by the control character `\n`.

    ---------------------------------------------------------------------------

> comment :: Parser ()
> comment = do  string "--"
>               c <- many (sat (/= '\n'))
>               space
>               return ()

3.  Using our second grammar for arithmetic expressions, draw the two possible
    parse trees for the expression 2 + 3 + 4.

    ---------------------------------------------------------------------------

    Note: these trees will only "render" well in a monospace font.

    The first grammar:
        
        expr    ::= expr = expr | expr * expr | (expr) | nat
        nat     ::= 0 | 1 | 2 | ...

    The second grammar:

        expr    ::= expr + expr | term
        term    ::= term * term | factor
        factor  ::= (expr) | nat
        nat     ::= 0 | 1 | 2 | ...

    My trees:

        1.           expr             2.            expr
                    / +  \                         / +  \
                   /      \                       /      \
                 expr     expr                  expr     expr
                / +  \      \                  /        / +  \
               /      \    term               /        /     expr
             expr    expr     \             term    expr       \
               |       |    factor            |       |       term
             term    term     |             factor  term         \
               |       |     nat              |       |        factor
             factor  factor   |              nat    factor       |
               |       |      4               |       |         nat
              nat     nat                     2      nat         |
               |       |                              |          4
               2       3                              3

4.  Using our third grammar for arithmetic expressions, draw the parse trees
    for the expressions `2 + 3`, `2 * 3 * 4` and `(2 + 3) + 4`.

    ---------------------------------------------------------------------------

    The third grammar:

        expr    ::= term + expr | term
        term    ::= factor * term | factor
        factor  ::= (expr) | nat
        nat     ::= 0 | 1 | 2 | ...

    -   `2 + 3`

                    expr
                   / +  \
                term   expr
                 /        \
               factor    term
                 |          \
                nat        factor
                 |            \
                 2           nat
                              |
                              3

    -   `2 * 3 * 4`

                   expr
                     |
                   term
                  / *  \
               factor  term
                /     /  * \
               nat  factor term
                |     |      \
                2    nat    factor
                      |       |
                      3      nat
                              |
                              4

    -   `(2 + 3) + 4`

                       expr
                      / +  \
                    term   expr
                    /        \
                 factor      term
                  / ()         \
                 expr         factor
                / +  \           \
              term  expr         nat
               |       \           \
             factor   term          4
               |         \
              nat      factor
               |           \
               2           nat
                             \
                              3

5.  Explain why the final simplifiaction of the grammar arithmetic expressions
    has a dramatic effect on the efficiency of the resulting parser.  Hint:
    begin by considering how an expression comprising a single number would be
    parsed if this step had not been made.

    ---------------------------------------------------------------------------

    The final simplified grammar is:

        expr    ::= term (+ expr | <-)
        term    ::= factor (* term | <-)
        factor  ::= (expr) | nat
        nat     ::= 0 | 1 | 2 | ...

    The final grammar is more efficient because it binds the first item before
    considering the other, more complex rules, such as addition or subtraction.
    This allows it to be more efficient, because it doesn't fail to bind as
    frequently for simple expressions, such as single numbers.

    The parse trees would be identical, it would just arrive at the result more
    quickly because, in the case of the single number, there would be one (1)
    secondary rule considered, instead of 3. 

    As all leaf nodes of a valid tree will always be natural numbers, this 
    gain in efficiency will be large.

6.  Extend the parser for arithmetic expressions to support subtraction and
    division, based upon the following extensions to the grammar:

        expr    ::= term (+ expr | - expr | <-)
        term    ::= factor (* term | / term | <-)

    ---------------------------------------------------------------------------

    The complete grammar is now:

        expr    ::= term (+ expr | - expr | <-)
        term    ::= factor (* term | / term | <-)
        factor  ::= (expr) | nat
        nat     ::= 0 | 1 | 2 | ...

    Note that since we're using `nat` -- natural numbers -- division is done
    without remainder, and without decimal places.  `1 / 2 == 0`, `9 / 7 == 1`.

 expr :: Parser Int
 expr = do t <- term
           do symbol "+"
              e <- expr
              return (t + e)
            +++
            do symbol "-"
               e <- expr
               return (t - e)
            +++ return t

 term :: Parser Int
 term = do f <- factor
           do symbol "*"
              t <- term
              return (f + t)
            +++
            do symbol "/"
               t <- term
               return (f `div` t)
            +++ return f

> factor :: Parser Int
> factor = do symbol "("
>             e <- expr
>             symbol ")"
>             return e
>           +++ natural

> eval :: String -> Int
> eval xs = case parse expr xs of
>               [(n,[])]    -> n
>               [(_, out)]  -> error ("unused input " ++ out)
>               []          -> error "invalid input"

7.  Further expend the grammar and parser for arithmetic expressions to support
    exponentiation, which is assumed to associate to the right and have higher
    priority than multiplication and division, but lower than parentheses and 
    numbers.  For example, `2 ^ 3 * 4` means `(2 ^ 3) * 4`.  Hint: the new
    level of priority requires a new rule in the grammar.

    ---------------------------------------------------------------------------

    The complete grammar is now:

        expr    ::= term (+ expr | - expr | <-)
        term    ::= seven (* term | / term | <-)
        seven   ::= factor (^ seven | <-)
        factor  ::= (expr) | nat
        nat     ::= 0 | 1 | 2 | ...

> term :: Parser Int
> term = do f <- seven
>           do symbol "*"
>              t <- term
>              return (f + t)
>            +++
>            do symbol "/"
>               t <- term
>               return (f `div` t)
>            +++ return f

    I named the new rule "seven" because this is question 7.  I have no idea
    what a good name would be.

> seven :: Parser Int
> seven = do f <- factor
>            do symbol "^"
>               s <- seven
>               return (f ^ s)
>             +++ return f

8.  Consider operations built up from natural numbers using a subtraction
    operator that is assumed to associate to the left.

    a)  Define a natural grammar for such expressions.
    b)  Translate this grammar into a parser `expr :: Parser Int`
    c)  What is the problem with this parser?
    d)  Show how it can be fixed.  Hint: rewrite the parser using the 
        repetition primitive `many` and the library function `foldl`.

    ---------------------------------------------------------------------------

    a)  The natural grammar for such expressions is thus:

        expr    ::= expr (- nat | <-)
        nat     ::= 0 | 1 | 2 | ...

    b)  The code is below:

 expr :: Parser Int
 expr = do n <- expr
           do symbol "-"
              e <- natural
              return (n - e)
             +++ return n

    c)  The problem with this parser is that it never terminates.  To make
        the subtraction left-associative, the subexpressions must be matched
        before the symbol "-"; since the sub-rule matches itself (ie. it will
        never match the `nat` clause) the code will never terminate.

    d)  It can be fixed using the following code, which exploits the repetition
        primitive `many`, as well as the library function `foldl`.

> expr :: Parser Int
> expr = do n <- natural
>           ns <- many (do symbol "-" 
>                         natural)
>           return $ foldl (-) n ns
