>module CH05 where

1.  Unsing a list comprehension, give an expression that calculates the sum
    1^2 + 2^2 + ... 100^2 of the first one hundred integer squares.

    ---------------------------------------------------------------------------

    One way to calculate this would be:

>question1 = sum [ x^2 | x <- [1 .. 100]]

2.  In a similar way to the funciton `length`, show how the library function
    `replicate :: Int -> a -> [a]` that produces a list of identical elements
    can be defined using a list comprehension.  For example:

        > replicate 3 True
        [True, True, True]

    ---------------------------------------------------------------------------

    One way to define this would be:

>replicate' n e = [ e | x <- [1..n]]

    This yields

        > replicate' 3 True
        [True, True, True]


3.  A triple(x, y, z) of positive integers is *pythagorean* if x^2 = y^2 = z^2.
    Using a list comprehension, define a function 
    `pyths :: Int -> [(Int, Int, Int)]` that returns the list of all 
    pythagorean triples whose components re at most a given limit.  For
    example:

        > pyths 10
        [(3, 4, 5), (4, 3, 5), (6, 8, 10), (8,6 10)]

    ---------------------------------------------------------------------------

>pyths :: Int -> [(Int, Int, Int)]
>pyths n = [(x, y, z) | x <- [1..n],
>                       y <- [1..n],
>                       z <- [1..n], x^2 + y^2 == z^2]

4.  A positive integer is *perfect* if it equals the sum of its factors, 
    excluding the number itself.  Using a list comprehension and the function
    `factors`, define a function `perfects :: Int -> [Int]` that returns the
    list of all perfect numbers up to a given limit.  For example:

        > perfects 500
        [6, 28, 496]

    ---------------------------------------------------------------------------

>factors :: Int -> [Int]
>factors n = [x | x <- [1..n], n `mod` x == 0]

>perfects :: Int -> [Int]
>perfects n = [x | x <- [1..n], x == (sum $ init $ factors x)]

5.  Show how the single comprehension 
    `[(x, y) | x <- [1, 2, 3], y <- [4, 5, 6]]` with two generators can be 
    re-expressed using two comprehensions with single generators.  Hint:
    make use of the library function `concat` and nest one comprehension
    within the other.

    ---------------------------------------------------------------------------

>question5 = concat [[(x, y) | y <- [4, 5, 6]] |  x <- [1, 2, 3]]

        [(x, y) | x <- [1, 2, 3], y <- [4, 5, 6]] == question5

6.  Redefine the function `positions` using the function `find`.

    ---------------------------------------------------------------------------

    From the book:

>find     :: Eq a => a -> [(a, b)] -> [b]
>find k t = [v | (k', v) <- t, k == k']

>positions      :: Eq a => a -> [a] -> [Int]
>positions x xs = [i | (x', i) <- zip xs [0 .. n], x == x']
>                 where n = length xs - 1 -- i don't think this is necessary

My solution:

>positions'      :: Eq a => a -> [a] -> [Int]
>positions' n xs = find n (zip xs [0..])

7.  The *scalar product* of two lists of integers `xs` and `ys` of length `n`
    is given by the sum of the products of corresponding integers:
        summation( i = 0, n - 1)(xs.i * ys.i)
    In a similar manner to the function `chisqr`, show how a list comprehension
    can be used to define a function `scalarproduct :: [Int] -> [Int] -> Int`
    that returns the scalar product of two lists.  For example:

        > scalarproduct [1, 2, 3] [4, 5, 6]
        32

    ---------------------------------------------------------------------------

>scalarproduct       :: Num a => [a] -> [a] -> a
>scalarproduct xs ys = sum [x * y | (x, y) <- zip xs ys]

    This could also be defined as:

        scalarproduct xs ys = sum $ zipWith (*) xs ys

8.  Modify the Caesar cipher program to also handle upper-case letters.

    The letters that will be swapped, in this case upper and lowercase letters:

>letters = ['a' .. 'z'] ++ ['A' .. 'Z']

    Shifts all characters in `xs` `n` places to the right.

>rotate n xs | n >  0 = drop n xs ++ take n xs
>            | n <= 0 = drop m xs ++ take m xs
>                       where m = length xs + n

    Creates a tuple with string and matching rotated string for translation.

>getKey n xs = zip xs (rotate n xs)

    Replaces a character with its corresponding item in the key.

>swap key n | n `elem` map (fst) key = head [y | (x, y) <- key, x == n]
>           | otherwise              = n

    Ciphers `xs` with the Caesae cypher produced by shifting all elements
    of `letters` `n` characters to the right.
    Use a negative `n` to reverse the cypher.

>shift n xs = map (swap key) xs
>           where key = getKey n letters

