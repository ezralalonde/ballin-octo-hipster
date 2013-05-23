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
