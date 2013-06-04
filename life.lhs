Game of life example from section 9.7 of Programming in Haskell,
Graham Hutton, Cambridge University Press, 2007.

Note: the control characters used in this example may not work
on some Haskell systems, such as WinHugs.

> import Data.List ((\\),)
> import Data.Char (ord,)

Derived primitives
------------------

> cls                           :: IO ()
> cls                           =  putStr "\ESC[2J"
>
> type Pos                      = (Int,Int)
>
> goto                          :: Pos -> IO ()
> goto (x,y)                    =  putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")
>
> writeat                       :: Pos -> String -> IO ()
> writeat p xs                  =  do goto p
>                                     putStr xs
>
> seqn                          :: [IO a] -> IO ()
> seqn []                       =  return ()
> seqn (a:as)                   =  do a
>                                     seqn as

Game of life
------------

> width                         :: Int
> width                         =  5
>
> height                        :: Int
> height                        =  5
>
> type Board                    =  [Pos]
>
> glider                        :: Board
> glider                        =  [(4,2),(2,3),(4,3),(3,4),(4,4)]
>
> showcells                     :: Board -> IO ()
> showcells b                   =  seqn [writeat p "O" | p <- b]
>
> isAlive                       :: Board -> Pos -> Bool
> isAlive b p                   =  elem p b
>
> isEmpty                       :: Board -> Pos -> Bool
> isEmpty b p                   =  not (isAlive b p)
>
> neighbs                       :: Pos -> [Pos]
> neighbs (x,y)                 =  map wrap [(x-1,y-1), (x,y-1),
>                                            (x+1,y-1), (x-1,y),
>                                            (x+1,y)  , (x-1,y+1),
>                                            (x,y+1)  , (x+1,y+1)]
>
> wrap                          :: Pos -> Pos
> wrap (x,y)                    =  (((x-1) `mod` width) + 1, ((y-1) `mod` height + 1))
>
> liveneighbs                   :: Board -> Pos -> Int
> liveneighbs b                 =  length . filter (isAlive b) . neighbs
>
> survivors                     :: Board -> [Pos]
> survivors b                   =  [p | p <- b, elem (liveneighbs b p) [2,3]]
>
> births b                      =  [p | p <- rmdups (concat (map neighbs b)),
>                                       isEmpty b p,
>                                       liveneighbs b p == 3]
>
> rmdups                        :: Eq a => [a] -> [a]
> rmdups []                     =  []
> rmdups (x:xs)                 =  x : rmdups (filter (/= x) xs)
>
> nextgen                       :: Board -> Board
> nextgen b                     =  survivors b ++ births b
>
> life                          :: Board -> IO ()
> life b                        =  do cls
>                                     showcells b
>                                     wait 50000
>                                     life (nextgen b)
>
> wait                          :: Int -> IO ()
> wait n                        =  seqn [return () | _ <- [1..n]]
>
> life'                         :: (Board, Board) -> IO ()
> life' (l,d)                   = do
>                                    showcells l
>                                    clearcells d
>                                    wait 50000
>                                    life' (nextgen' l)
>
> nextgen'                       :: Board -> (Board, Board)
> nextgen' b                     =  (live, dead)
>                                where live = survivors b ++ births b
>                                      dead = b \\ live
>
> clearcells                     :: Board -> IO ()
> clearcells b                   =  seqn [writeat p " " | p <- b]
>
> editor                         :: Pos -> Board -> IO Board
> editor p b                     = do cls
>                                     readMove 
>                                 
> readMove :: IO Board
> readMove = get [] (1,1)

> get :: Board -> Pos -> IO Board
> get b p = do cls
>              showcells b  
>              x <- getChar
>              case x of 
>                '\ESC'  -> do getChar
>                              y <- getChar
>                              get b (move y p)
>                'x'    -> get (toggle p b) p
>                'q'    -> return b
>                _      -> get b p
>
> move            :: Char -> Pos -> Pos
> move dir (x,y) = wrap (x + xoff, y + yoff)
>                where 
>                  (xoff, yoff) = case dir of 
>                    'A' -> ( 0, -1)
>                    'B' -> ( 0,  1)
>                    'C' -> ( 1,  0)
>                    'D' -> (-1,  0)
>                    _   -> ( 0,  0)
>
> toggle         :: Pos -> Board -> Board
> toggle p b 
>        | p `elem` b = filter (/=p) b
>        | otherwise  = p : b 
