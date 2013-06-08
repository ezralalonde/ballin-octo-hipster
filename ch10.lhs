> module CH10 where

1.  Using recursion and the function `add`, define a multiplication function
    mult :: Nat -> Nat -> Nat for natural numbers.

> data Nat = Zero | Succ Nat
>   deriving Show

> add Zero n        = n
> add (Succ m) n    = Succ (add m n)

> mult :: Nat -> Nat -> Nat
> mult Zero n       = Zero
> mult (Succ m) n   = add n (mult m n)

2.  Although not included in appendix A, the standard library defines
        data Ordering = LT | EQ | GT
    together with a function
        compare :: Ord a -> a -> a -> Ordering
    that decides if one value in an ordered type is less than (LT),
    equal to (EQ), or greater than (GT) another such value. Using this
    function, redefine the function `occurs :: Int -> Tree -> Bool` for search
    trees. Why is the new definition more efficient than the orignal version?

> data Tree = Leaf Int | Node Tree Int Tree
>   deriving Show

> occurs :: Int -> Tree -> Bool
> occurs m (Leaf n)     = m == n
> occurs m (Node l n r) = case compare m n of
>                           EQ -> True
>                           LT -> occurs m l
>                           GT -> occurs m r

    This version may be more efficient because it does fewer comparisons.
    That is, it always does exactly one comparison (`compare m n`),
    whereas the previous version might do two (`m == n`, `m < n`).
