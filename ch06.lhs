>module CH06 where

1.  Define the exponentiation operator `^` for non-negative integers using the
    same pattern of recursion as the multiplication operator `*`, and show how
    2 ^ 3 is evaluated using your definition.

    ---------------------------------------------------------------------------

>toThePowerOf :: Int -> Int -> Int
>x `toThePowerOf` 0 = 1
>x `toThePowerOf` y = x * (x `toThePowerOf` (y - 1))

        2 `toThePowerOf` 3
        2 * (2 `toThePowerOf` 2)
        2 * (2 * (2 `toThePowerOf` 1))
        2 * (2 * (2 * (2 `toThePowerOf` 0)))
        2 * (2 * (2 * (1)))
        8

2.  Using the definitions given in this chapter, show how `length [1, 2, 3]`,
    `drop 3 [1, 2, 3, 4, 5]`, and `init [1, 2, 3]` are evaluated.

    ---------------------------------------------------------------------------

    1.  `length [1, 2, 3]`
            length [1, 2, 3]
            1 + length [2, 3]
            1 + (1 + length [3])
            1 + (1 + (1 + length []))
            1 + (1 + (1 + (0)))
            3

    #.  `drop 3 [1, 2, 3, 4, 5]`
            drop 3 [1, 2, 3, 4, 5]
            drop 2 [2, 3, 4, 5]
            drop 1 [3, 4, 5]
            drop 0 [4, 5]
            [4, 5]

    #.  `init [1, 2, 3]`
            init [1, 2, 3]
            1 : init [2, 3]
            1 : 2 : init [3]
            1 : 2 : []
            [1, 2]
