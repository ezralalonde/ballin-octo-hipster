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

3.  Without looking at the definitions from the standard prelude, define the
    following library functions using recursion:
    
    -   Decide if all logical values in a list are `True`:
        `and :: [Bool] -> Bool`
    -   Concatenate a list of lists:
        `concat :: [[a]] -> [a]`
    -   Produce a list with `n` identical elements:
        `replicate :: Int -> a -> [a]
    -   Select the `n`th element of a list:
        `(!!) :: [a] -> Int -> a
    -   Decide if a value is an element of a list:
        `elem :: Eq a => a -> [a] -> Bool
    
    Note: most of these functions are in fact defined in the prelude using
    other library functions, rather than using explicit recursion.

    ---------------------------------------------------------------------------

>and' :: [Bool] -> Bool
>and' [x]    = x
>and' (x:xs) = x && (and' xs)

>concat' :: [[a]] -> [a]
>concat' [x]    = x
>concat' (x:xs) = x ++ (concat' xs)

>replicate' :: Int -> a -> [a]
>replicate' 0 _ = []
>replicate' n x = x : replicate' (n - 1) x

>select :: [a] -> Int -> a
>select (x:xs) 0 = x
>select (x:xs) n = select xs (n - 1)

>elem' :: Eq a => a -> [a] -> Bool
>elem' x []     = False
>elem' x (y:ys) = (x == y) || (elem' x ys)
