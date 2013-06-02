> module CH09 where

1.  Define an action `readLine :: IO String` that behaves the same way as 
    `getLine`, except that it also permits the delete key to be used to remove
    characters.  Hint: the delete character is `'\DEL'`, and the control string
    for moving the cursor back on character is `"\ESC[1D".

> getLine' :: IO String
> getLine' = do x <- getChar
>               if x == '\n' then
>                  return []
>                else
>                  do xs <- getLine
>                     return (x:xs)

Note: `getLine` above allows for the use of the backspace key.
      It works as you'd expect.  Further, GHCI won't allow me to enter '\DEL'
      as a character.

      As a result, on windows, this solution doesn't do anything that 
      `getLine` doesn't despite the added complexity.

      On a linux system, the behaviour is thus:

        > getLine'
        this^?is
        "this\DELis"
        > readLine
        this^?is
        "thiis"

> readLine :: IO String
> readLine = get ""

> get :: String -> IO String
> get xs = do x <- getChar
>             case x of 
>               '\n'   -> return xs
>               '\DEL' -> if null xs then
>                            get xs
>                          else
>                            do putStr "\ESC[1D \ESC[ID"
>                               get $ init xs
>               _      -> get $ xs ++ [x]

2.  Modify the calculator program to indicate the approximate position of an
    error rather than just sounding a beep, by using the fact that the parser
    returns the unconsumed part of the input string.

    ---------------------------------------------------------------------------

    I changed the `calculator.lhs` progam by modifying the function `eval`,
    and adding the functions `fill` and `showError`.

    It now adds an additional line of output to the calculator.  It displays
    the unparsed portion of the input if evaluation fails, and "Success." 
    otherwise.

3.  On some systems the game of life may flicker, due to the entire screen 
    being cleared each generation.  Modify the game to avoid such flicker by
    only redisplaying the portions whose status changes.

    ---------------------------------------------------------------------------

    I've changed the `life.lhs` program, adding the functions `life'`,
    `nextgen'`, and `clearcells`.  Now, instead of calling `life glider`, and
    having the entire board redrawn on each step, we'd call 
    `life' (glider, [])`, and only the "dead" cells would be blanked-out, and
    only the "live" cells would contain the `O` character.

    This new version works by having `life'` return a tuple containing the
    live cells, which are written as `O`, and the dead cells, which are
    cleared.

    Using this method, "live" cells are still redrawn even if they haven't
    changed, but the work needed in maintaining the list of the cells from the
    past iteration which are still alive is ugly.  It's in principle the same
    as the code for maintaining the list of dead ones, which I've done.

4.  Produce an editor that allows the user to interactively create and modify
    the content of the board in the game of life.

    ---------------------------------------------------------------------------

    This is done.  See the `readMove` function in the modified `life.lhs` file
    for the interactive editor.  You start with a blank canvas, and can move
    using the arrow keys.  Pressing 'x' causes a piece to be added to (or
    removed from) the board.  Pressing 'q' returns the `IO Board` you've been
    editing.

5.  Produce graphical versions of the calculator and game of life programs,
    using one of the graphics libraries available from www.haskell.org.

    ---------------------------------------------------------------------------

    I'm not doing this.  I saw the page on haskell.org that outlines the 
    graphical libraries[^gui], and don't want to cope with the sysadmin's 
    burden of setting up wxHaskell, Gtk2Hs, HOpenGL, SDL.

    The Linux machine that I'm doing all this on doesn't have X installed, and
    nothing really works on Windows.

6.  Nim is a game that is played on a board comprising five numbered rows of
    stars, which is initially set up as follows:

        1. *****
        2. ****
        3. ***
        4. **
        5. *

    Two players take it in turn to remove one or more stars from the end of a
    single row.  The winner is the player who removes the last star or stars
    from the board.  Implement the game of nim in Haskell.  Hint: represent the
    board as a list comprising the number of stars remaining on each row, with
    the initial board being [5, 4, 3, 2, 1].

    ---------------------------------------------------------------------------

Note: there is no error checking in this game.  The game assumes that the
indices and values input by the player are valid, and that all input is valid.

Also note that the wikipedia for Nim says that the player who takes the last
piece is the loser.  In this implementation, they are the winner.

> type NimBoard = [Int]
> type Name     = String
>
> start_board :: NimBoard
> start_board = [5, 4, 3, 2, 1]
>
> print_board :: NimBoard -> IO ()
> print_board xs = putStrLn $ unlines $ map output numbered
>                where stars        = map (flip replicate '*') xs
>                      numbered     = zip [0..] stars
>                      output (x,y) = show x ++ " : " ++ y
>
> edit :: NimBoard -> (Int, Int) -> NimBoard
> edit b (row, amt) = filter (> 0) $ zipWith (-) b adder
>                   where adder = replicate row 0 ++ [amt] ++ repeat 0
>
> play m n [] = putStrLn $ show n ++ " is the winner!"
> play m n b  = do print_board b
>                  move <- getMove m
>                  newboard <- return $ edit b move
>                  play n m newboard
>
> getMove :: Name -> IO (Int, Int)
> getMove name = do putStrLn $ "Enter move (row:amount) for " ++ show name
>                   str <- getLine
>                   let start = (read $ takeWhile (/= ':') str) :: Int
>                   let end   = (read $ tail $ dropWhile (/= ':') str) :: Int
>                   return (start, end)

[^gui]: http://www.haskell.org/haskellwiki/Cookbook/Graphical_user_interfaces
