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

4.  Define a recursive function `merge :: Ord a => [a] -> [a] -> [a]` that
    merges two sorted lists to give a single sorted list.  For example:

        > merge [2, 5, 6] [1, 3, 4]
        [1, 2, 3, 4, 5, 6]

    Note: your sefinition should not use other functions on sorted lists such
    as `insert` or `isort`, but should be defined using explicit recursion.

    ---------------------------------------------------------------------------

>merge :: Ord a => [a] -> [a] -> [a]
>merge xs       []   = xs
>merge []       ys   = ys
>merge (x:xs) (y:ys) | x <= y    = x : (merge xs (y:ys))
>                    | otherwise = y : (merge (x:xs) ys)

5.  Using `merge`, define a recursive function `msort :: Ord a => [a] -> [a]`
    that implements "merge sort", in which the empty list and singleton lists
    are already sorted, and any other list is sorted by merging together the 
    two lists that result from sorting the two halves of the list separately.

    Hint: first define a function `halve :: [a] -> [([a], [a])]` that splits
    a list into two halves whose lengths differ by at most one.

    ---------------------------------------------------------------------------

    I think that the outer `[` and `]` in the type signature of `halve` 
    are mistakes.  I return a tuple, not a list of tuples.

>halve :: [a] -> ([a], [a])
>halve xs = (take n xs, drop n xs)
>         where n = length xs `div` 2

>msort :: Ord a => [a] -> [a]
>msort []  = []
>msort [x] = [x]
>msort xs  = merge (msort front) (msort back)
>          where (front, back) = halve xs
