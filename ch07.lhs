>module CH07 where
>import Data.Char

1.  Show how the list comprehension [f x | x <- xs, p x] can be re-expressed
    using the higher-order functions `map` and `filter`.

>reexpr f p = map f . filter p

2.  Without looking at the definitions from the standard prelude, define the
    higher-order functions `all`, `any`, `takeWhile`, and `dropWhile`.

>all' :: (a -> Bool) -> [a] -> Bool
>all' p xs = foldr (\y ys -> p y && ys) True xs

>all'' p xs = and $ map p xs

>all''' p []     = True
>all''' p (x:xs) = p x && all''' p xs

>any' :: (a -> Bool) -> [a] -> Bool
>any' p xs = foldr (\y ys -> p y || ys) True xs

>takeWhile' :: (a -> Bool) -> [a] -> [a]
>takeWhile' p xs = foldr (\y ys -> if p y then y : ys else []) [] xs

>dropWhile' :: (a -> Bool) -> [a] -> [a]
>dropWhile' p xs = foldr (\y ys -> if (not . null) ys && p y 
>                                   then ys
>                                   else y: ys
>                        ) [] xs

3.  Redefine the functions `map f` and `filter p` using `foldr`.

>map' f = foldr (\y ys -> f y : ys) []

>filter' p = foldr (\y ys -> if p y then y:ys else ys) []

4.  Using `foldl`, define a function `dec2int :: [Int] -> Int` that converts
    a decimal number into an integer.  For example:
        
        > dec2int [2, 3, 4, 5]
        2345

>dec2int :: [Int] -> Int
>dec2int = foldl (\ys y -> 10 * ys + y) 0

5.  Explain why the following definition is invalid:
    
        sumsqreven = compose [sum, map (^2), filter even]

    ---------------------------------------------------------------------------

    Lists in Haskell must have items of the same type.  It is not possible
    to mix types in a list.  When we see that the types of the functions are:

        sum :: Num a => [a] -> a
        map (^2) :: Num a => [a] -> [a]
        filter even :: Integral a => [a] -> [a]

    we can see that this is illegal in Haskell's type system, even though the
    functions could be composed as:

        sum . map (^2) . filter even

6.  Without looking at the standard prelude, define the higher-order library
    function `curry` that converts a function on pairs into a curried function,
    and, conversely, the function `uncurry` that converts a curried function
    with two arguments into a function on pairs.

    Hint: first write down the types of the two functions.

>curry' :: ((a, b) -> c) -> a -> b -> c
>curry' f = \x y -> f(x, y)

>uncurry' :: (a -> b -> c) -> (a, b) -> c
>uncurry' f = \(x, y) -> f x y
