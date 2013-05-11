>module CH07 where
>import Data.Char

1.  Show how the list comprehension [f x | x <- xs, p x] can be re-expressed
    using the higher-order functions `map` and `filter`.

>reexpr f p = map f . filter p
