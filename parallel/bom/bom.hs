{- 
Time-stamp: <Wed May 22 1996 20:46:49 Stardate: [-31]7544.12 hwloidl>

Source file: /local/grasp/trinder/tests/strategies/

 Module expressing Dates Bill of Material Program
	Phil Trinder 18/9/95                             

Slightly adapted for general GranSim setup by H.W. Loidl

*********************** dateNaive11.hs **************************

Naive functional version. Generates a list of tuples + explodes by
scanning the list. Query is hand-translated into recursive functions

This version uses parallel Strategies. The intention is to very
clearly seperate computation from evaluation.

Good gransim arguments: 70 90 100
Good GUM arguments:	900 980 1000
-}

module Main where

-- import Parallel
-- import ParallelStrategiesV

import Strategies

#if defined(IO13)
import GranRandom
import LibSystem (getArgs)
#else
import PreludeGlaMisc
import PreludeGlaST
import PreludeGlaMonadicIO
#endif

{------------------------------------------------------------------------------
--  For Hugs!

seq x y = y

par x y = y

NB: Ramdom numbers are now taken from GranRandom
-------------------------------------------------------------------------------
-- This section replicated from Lennarts hbc/lib/Random module for use with Hugs

-- Use seeds s1 in 1..2147483562 and s2 in 1..2147483398 to generate
-- an infinite list of random Ints.
randomInts :: Int -> Int -> [Int]
randomInts s1 s2 =
    if 1 <= s1 && s1 <= 2147483562 then
        if 1 <= s2 && s2 <= 2147483398 then
            rands s1 s2
        else
            error "randomInts: Bad second seed."
    else
        error "randomInts: Bad first seed."

rands :: Int -> Int -> [Int]
rands s1 s2 = z' : rands s1'' s2''
        where   z'   = if z < 1 then z + 2147483562 else z
                z    = s1'' - s2''

                k    = s1 `quot` 53668
                s1'  = 40014 * (s1 - k * 53668) - k * 12211
                s1'' = if s1' < 0 then s1' + 2147483563 else s1'
    
                k'   = s2 `quot` 52774
                s2'  = 40692 * (s2 - k' * 52774) - k' * 3791
                s2'' = if s2' < 0 then s2' + 2147483399 else s2'

-------------------------------------------------------------------------------
-}

{- suitable tries a sequence of random numbers until it finds one less
than n (the main part) and that hasn't been chosen already -}

suitable n (r:rs) chosen = if r < n && notElem r chosen then
		      	     (r,rs)
		    	   else
		      	     suitable n rs chosen


genBetween lo hi rs 
	| lo == hi 	= []
	| otherwise	= (lo,m1,2):(lo,m2,4):(lo,m3,1):
	                  genBetween (lo+1) hi rs'''
			  where
			    (m1,rs') = suitable lo rs []
			    (m2,rs'') = suitable lo rs' [m1]
			    (m3,rs''') = suitable lo rs'' [m1,m2]
	
{- Generates 2n tuples in a directed acyclic graph. Each tuple in the
range (n..n/3] is linked to 3 other tuples smaller than it, and no
tuple is linked to the same child twice. e.g. generate 12 = 
[(4,1,2), (4,2,4), (4,3,1), (5,1,2), (5,2,4), (5,3,1),
 (6,1,2), (6,2,4), (6,3,1), (7,4,2), (7,3,4), (7,2,1), 
 (8,1,2), (8,2,4), (8,3,1), (9,3,2), (9,4,4), (9,5,1), 
 (10,5,2), (10,4,4), (10,3,1), (11,2,2), (11,1,4), (11,3,1)]
-}

{-
generate n = genBetween (n `div` 3) n rs
	       where 
		 rs = map (\x -> mod x n) (randomInts 53 107)
-}

#if defined(IO13)
generate :: Int -> IO [(Int, Int, Int)]
generate n = getRandomInts n >>= \ rs ->
	     return (genBetween (n `div` 3) n rs)

explode :: [(Int,Int,Int)] -> Int -> [Int]
explode r ass = nub [p | (m,s,n) <- r, m == ass, p <- (s:explode r s)] 
{- explode r ass = [p | (m,s,n) <- r, m == ass, p <- (s:explode r s)] -}

{- First create the list of tuples, then explode (some), finally print
out how many in each explosion -}

doQuery :: Int -> Int -> Int -> IO [Int]
doQuery lo hi bomSize = generate bomSize >>= \ bom ->
                        let 
			 explodeList = map (explode bom) [lo..hi]
			 strategy result =
			   (seqList rnf bom) `seq` 
                           (parList rnf explodeList) `seq`
			   result
                        in
	                return( strategy (map length explodeList) )

# if defined(ARGS)
main = 	getArgs >>=  \[a1, a2, a3] ->
	let lo      = fst (head (readDec a1))
	    hi      = fst (head (readDec a2))
	    bomSize = fst (head (readDec a3))
	in
        doQuery lo hi bomSize >>= \ l ->
#  if defined(PRINT)
	putStr (show l)
#  else
        (rnf l) `seq` putStr "Done\n" 
#  endif

# else
main = 	let lo      = 70
	    hi      = 90
	    bomSize = 100
	in
        doQuery lo hi bomSize >>= \ l ->
#  if defined(PRINT)
	putStr (show l)
#  else
        (rnf l) `seq` putStr "Done\n" 
#  endif
# endif

#else  /* !IO13 */

generate :: Int -> [(Int, Int, Int)]
generate n = genBetween (n `div` 3) n rs
	     where rs = unsafeGetRandomInts n

doQuery lo hi bomSize = strategy (map length explodeList)
		       where
			 bom = generate bomSize
			 explodeList = map (explode bom) [lo..hi]
			 strategy result =
			   (seqList rnf bom) `seq` 
                           (parList rnf explodeList) `seq`
			   result

# if defined(ARGS)
main = 	getArgs exit ( \[a1, a2, a3] ->
	                  let lo      = fst (head (readDec a1))
			      hi      = fst (head (readDec a2))
			      bomSize = fst (head (readDec a3))
			  in
			    appendChan stdout (show (doQuery lo hi bomSize)) abort done
		     )
# else
main = 	let lo      = 70
	    hi      = 90
	    bomSize = 100
	in
	  appendChan stdout (show (doQuery lo hi bomSize)) abort done
# endif

#endif /* IO13 */
