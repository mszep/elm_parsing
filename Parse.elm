module Parse where

type Parser s t = [s] -> [(t, [s])]

--parseLetter : Char -> String -> [(Char, String)]
--parseLetter a str = case str of
--		    s::ss -> if s == a then [(s, ss)] else []
--		    []  -> []
--
--pReturn : a -> String -> [(a, String)]
--pReturn a = \ inp -> [(a, inp)]
--
--pFail : String -> [(a)]
--pFail = \ inp -> []
--
----Tuples are awkward, might need to define a type Parseresult { t : a, s : String } or something
----no, fst /snd should do the job
--
--pAnd : (String -> [((b -> a), String)]) -> (String -> [(b, String)]) -> (String -> [(a, String)])
--pAnd p1 p2 = \ inp ->
--		let r = p1 inp
--		    app f t = 
--		    rr = map p2 (
--
--data TexToken
--    = Word String
--    | TexCommand String
