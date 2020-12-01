-- Learning source: https://en.wikibooks.org/wiki/Haskell/
-- Usage: ghc script && ./script 3 input.txt

import Data.List

import System.Environment


-- https://stackoverflow.com/a/21775467
combinations k l = filter ((k==).length.nub) $ mapM (const l) [1..k]

findCombsProduct k l = product $ head $ [comb | comb <- combinations k l, sum comb == 2020]

expenseList :: [[Char]] -> [Int]
expenseList = map read

main = do
    args <- getArgs
    let arg1 = head args
    let k = read arg1 :: Int
    let filename = head $ tail args

    f <- readFile filename
    let expenses = expenseList (lines f)

    let output = findCombsProduct k expenses
    print output
