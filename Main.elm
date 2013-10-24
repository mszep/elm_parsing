module Main where

type Parser s t = [s] -> [(t, [s])]

pSym : Char -> Parser Char Char
pSym sym = \ inp -> case inp of
                      i::is -> if i == sym then [(i, is)]
                               else []
                      _      -> []

pReturn : a -> Parser Char a
pReturn a = \ inp -> [(a, inp)]

pFail : Parser Char a
pFail = \ inp -> []

testpSym = asText ( pSym 'i' "ihello")
testpReturn = asText ( pReturn 4 "ihello")
testpFail = asText (pFail "failtest!!")

main = testpFail
