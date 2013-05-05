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
