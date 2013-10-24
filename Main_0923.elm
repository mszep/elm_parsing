module Main where                                        

import Char

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

applyTup : (a->b) -> (a, c) -> (b, c)
applyTup f (a, b) = (f a, b)

applyParser : Parser s b -> (b->a, [s]) -> [(a, [s])]
applyParser p (f, ss) =
  let r = p ss
  in map (\tup -> applyTup f tup) r 

--Swierstra's paper calls this <*>
--pAnd : Parser s (b -> a) -> Parser s b -> Parser s a --also fails to compile
--pAnd : Parser Char (b -> a) -> Parser Char b -> Parser Char a
pAnd p1 p2 = \inp ->
  let l1 = p1 inp
      l2 = map (\tup -> applyParser p2 tup) l1
  in foldl (::) [] l2

testpSym = asText ((pSym 'i') "ihello")                   
testpReturn = asText ( pReturn 4 "ihello")               
testpFail = asText (pFail "failtest!!")                  
testapplyParser = asText (applyParser (pSym 'b') (Char.toUpper, "blablabla"))
testpAnd = asText (pAnd (pReturn Char.toUpper) (pSym 'i') "ihello")

main = testpAnd --doubly nested list is wrong! That's probably why the type check fails as well

