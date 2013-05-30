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

7.  A higher-order function `unfold` that encapsulates a simple pattern of 
    recursion for producing a list can be defined as follows:

>unfold p h t x  | p x       = []
>                | otherwise = h x : unfold p h t (t x)

    That is, the function `unfold p h t` produces the empty list if the 
    predicate `p` is true of the argument, and otherwise produces a non-empty
    list by applying the function `h` to give the head, and the function `t` 
    to generate another argument that is recursively processed in the same way
    to produce the tail of the list.  For example, the function `int2bin` can
    be rewritten more compactly using `unfold` as follows:

>int2bin :: Int -> [Bit]
>int2bin = unfold (==0) (`mod` 2) (`div` 2)

    Redefine the functions `chop8`, `map f` and `iterate f` using `unfold`

>type Bit = Int

>chop8 :: [Bit] -> [[Bit]]
>chop8 = unfold null (take 8) (drop 8)

>map'' :: (a -> b) -> [a] -> [b]
>map'' f = unfold null (f . head) tail

>iterate' :: (a -> a) -> a -> [a]
>iterate' f = unfold (const False) id (\x -> (f x))

8.  Modify the string tranmitter program to detect simple transmission errors
    using parity bits.  That is, each eight-bit binary number produced during
    encoding is extended with a parity bit, set to one if the number contains
    an odd number of ones, and to zero otherwise.  In turn, each resulting 
    nine-bit binary number consumed during decoding is checked to ensure that
    its parity bit is correct, with the parity bit being discarded if this is
    the case, and a parity error reported otherwise.

    Hint: the library function `error :: String -> a` terminates evaluation
    and displays the given string as an error message.

>bin2int :: [Bit] -> Int
>bin2int = foldr (\x xs -> x + 2 * xs) 0

>make8 :: [Bit] -> [Bit]
>make8 = (take 8) . (++ repeat 0)

>decode :: [Bit] -> String
>decode = map (chr . bin2int) . chop8

>encode :: String -> [Bit]
>encode = concat . map (make8 . int2bin . ord)

>transmit :: String -> String
>transmit = decode . channel . encode

>channel :: [Bit] -> [Bit]
>channel = id

    My solution:

>countOnes :: [Bit] -> Int
>countOnes = length . filter (==1)

>check :: [Bit] -> ([Bit], Bit)
>check xs = (xs, if (odd . countOnes) xs then 1 else 0)

>addCheck :: [Bit] -> [Bit]
>addCheck xs = content ++ [digit]
>            where (content, digit) = check xs

>encode' :: String -> [Bit]
>encode' = concat . map (addCheck . make8 . int2bin . ord)


>verify :: [Bit] -> [Bit]
>verify xs = if length xs == 9 && lastBit == co 
>               then original
>               else error "parity check failed"
>          where (original, co) = check (take 8 xs)
>                lastBit = last xs


>decode' :: [Bit] -> String
>decode' = map (chr . bin2int) . (map verify) . (chop 9)

>chop :: Int -> [Bit] -> [[Bit]]
>chop n = unfold null (take n) (drop n)

>transmit' :: String -> String
>transmit' = decode' . channel . encode'

9.  Test your new string transmitter program from the previous exercise 
    using a faulty communication channel that forgets the first bit, which can
    be modelled using the `tail` function on lists of bits.

>transmit'' :: String -> String
>transmit'' = decode' . channel' . encode'

>channel' :: [Bit] -> [Bit]
>channel' = tail
