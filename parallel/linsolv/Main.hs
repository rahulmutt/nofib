{- Main module for testing linSolv.hs, the solution of a system of 
   linear equations by using the modular method.                             -}

module Main where

-- ----------------------------------------------------------------------------
-- Using modular method for linear system solving
-- ----------------------------------------------------------------------------

import ModArithm

import Matrix (SqMatrix, Vector, vector,
	       lolSqMatrix,listSqMatrix,maxElemVec,jaH)

import ParForce 

import LinSolv (linSolv)

-- ----------------------------------------------------------------------------
-- Functions for I/O
-- ----------------------------------------------------------------------------

seq :: [String] -> IO ()

seq []      = return ()
seq (s1:ss) = putStr s1 >> seq ss

{-
getCpuTime fail succ resps = 
  GetCpuTime : dblDispatch fail succ resps

getTime fail succ resps = 
  GetTime : dblDispatch fail succ resps

dblDispatch fail succ ~(resp:resps) = 
  case resp of Dbl t       -> succ t resps
               Failure msg -> fail msg resps
-}

-- Compute one number out of result; JUST FOR TESTING
-- This demands the computation of the full result and is fast to print
-- i.e. not much IO overhead in timing.

compact :: (Integral a) => (Vector a, a, a) -> [a]
compact (x', a, b) = if a == 0 
	             then if b == 0 then bonzo x
				    else 1 : bonzo x
	             else if b == 1 then bonzo x
				    else 1 : bonzo x
	             where bonzo x = parmap (\ y -> if y==0 then 0 else 1) x
			   x = jaH x'

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

main = 
	let
         a1 = listSqMatrix ((1,1),(3,3)) [ 1, 1, 1, 
                                                  0, 1, 2,
                                                  2, 2, 1 ] 
         b1 = vector [ 6, 8, 9 ]
         x1 = linSolv a1 b1            {- x1 = 1/-1 * [ -1, -2, -3] -}

         a2 = listSqMatrix ((1,1),(3,3)) [  1, -1,  4, 
                                                  -3,  0,  1,
                                                   2, -2,  1 ] 
         b2 = vector [ 12, -7, 10 ]
         x2 = linSolv a2 b2            {- x2 = 1/1 * [3, -1, 2] -}

         a3 = listSqMatrix ((1,1),(2,2)) [  1, 3, 
                                                  -2, 2 ] 
         b3 = vector [ 11, 10 ]
         x3 = linSolv a3 b3            {- x3 = 1/1 * [ -1, 4 ] -}

         a4 = listSqMatrix ((1,1),(4,4)) [  1,  1,  0,  2,
                                                   2, -1,  1, -1, 
                                                   3,  2, -2,  4,
                                                  -1,  2,  3,  0 ] 
         b4 = vector [ 8, 1, 13, 3 ]
         x4 = linSolv a4 b4            {- x4 = 1/-1 * [ -1, 1, -2, -4 ] -}

         a5 = listSqMatrix ((1,1),(3,3)) [  0,  0, -2,
                                                   7,  0,  5,
                                                  -3,  4, -6 ] 
         b5 = vector [ 7, 7, 7 ]
         x5 = linSolv a5 b5            {- x5 = 7/-8 * [ -4, 1, 4 ] -}

         a6 = listSqMatrix ((1,1),(2,2)) [  3,  0,
                                                  -3,  3 ] 
         b6 = vector [ 0, 2 ]
         x6 = linSolv a6 b6            {- x6 = 2/3 * [ 0, 1 ] -}

         a7 = listSqMatrix ((1,1),(4,4)) [ -1, -1,  0,  0,
                                                  -1,  0,  0, -1,
                                                   0, -1, -1,  1,
                                                  -1,  1,  0,  0 ] 
         b7 = vector [ -1, 0, 0, 0 ]
         x7 = linSolv a7 b7            {- x7 = 1/2 * [ 1, 1, -2, -1 ] -}

         a8 = listSqMatrix ((1,1),(8,8)) 
			[  1,  4,  0, 11, -4,  5, 23, -8, 
                           0,  5, 17, -3, 29, 11,  7,  4,
			  -2, -7, -9, -1,  0,  6,  9, 21,
			  32,  6, 11, -6,  2,  5,  9, -9, 
			  13, 17, 29, -9, 12, 35, 38,  0,
			   7,  5, -7,  8, -1,  0,  1,  2,
			   2,  3, -6, 24,  7, -1,  5, 19,
			  -3,  2,  9, 13, 25, -7, -1,  5 ] 

         b8 = vector [526, 244, 274, 320, 1051, 125, 276, 24]
         x8 = linSolv a8 b8            {- x8 =  [ 4, 9, -3, 0, 2, 1, 23, 5 ] -}

         a9 = listSqMatrix ((1,1),(5,5)) 
			[   1,  0,  5,  9,  2,
			    3, -5, 13, -1,  0,
			   -7,  6,  8,  1, 23,
			   -1,  2,  5, 17,  1,
			    0, -5, -2, -1,  7 ] 
	 b9 = vector [115, 156, 229, 140, 37]
	 x9 = linSolv a9 b9                     {- x9 = [ 1, -3, 11, 5, 7 ] -}
 
         a10 = listSqMatrix ((1,1),(6,6)) 
			[  0,  0,  2,  1,  2, -1,
			   3, -5, -1, -7,  0,  2,
			   1,  0,  3, -2,  5,  0,
			  -3,  1, -5,  0,  0, -4,
			   1,  2,  0, -6,  2, -1,
			   7, -2,  5, -3,  0,  5 ] 
	 b10 = vector [14, -18, 19, 18, 3, -24]
	 x10 = linSolv a10 b10             {- x10 = [ 1, 0, -1, 2, 5, -4 ] -}

         a11 = listSqMatrix ((1,1),(7,7))
		[ 13, -6,  5,  1,  9,  11, -21,
		   0,  2, -1, 15, -1,   7,   6,
		  27, -5,  3,  2,  0,  -1,  -8,
		   3,  1, 11, -4,  8,   0, -13,
		   5,  7,  9, 10, 13, -29,   6,
		  17, -2,  7,  1,  6,  -5,   1,
 		   4, -1,  0, 13,  6, -19,   2 ]
	 b11 = vector [ 3, 1, -4, 9, 13, -11, 5 ]
	 x11 = linSolv a11 b11  {- x11 = 1/11138030 *
                                     [ -1361273, 24524143, -5023241, 4646680, 
                                       -4426356, -4257689, -14542705]  -}

         a_huge = lolSqMatrix ((1,1),(16,16)) [
                    [44924, 20447, 29276, 40951, 5939, 996, 828, 62553, 63695, 30588, 25619, 32394, 63129, 63694, 39185, 40378],
                    [42921, 62054, 23399, 29333, 8566, 30909, 30055, 64891, 54909, 49172, 46320, 32652, 45621, 17632, 9264, 19098],
                    [25815, 52465, 63565, 65486, 55552, 52004, 44895, 34511, 49784, 4985, 10311, 27617, 31058, 34162, 35039, 26088],
                    [49670, 59116, 17022, 4689, 38334, 62487, 56107, 45233, 46942, 37146, 55954, 35711, 22658, 2164, 44732, 55607],
                    [44168, 5116, 18693, 40788, 34627, 7578, 35898, 40475, 19712, 4726, 7064, 19388, 23497, 2134, 14499, 2139],
                    [60549, 55183, 26167, 20043, 33321, 13385, 32805, 27000, 37236, 6897, 22401, 11099, 60617, 34354, 53034, 8541],
                    [59027, 54672, 7370, 12417, 4486, 30214, 29519, 22169, 32584, 46623, 62480, 25354, 36661, 30636, 41936, 25868],
                    [40590, 22341, 11608, 19798, 34183, 55625, 44401, 33781, 60677, 27455, 62873, 39102, 23854, 19340, 33328, 18615],
                    [65221, 56835, 15302, 13304, 16, 24870, 62514, 24506, 20878, 45057, 2315, 12301, 29937, 43638, 36656, 10205],
                    [27639, 33459, 56786, 29138, 51908, 15590, 44807, 23451, 42840, 33062, 61254, 14966, 18778, 62308, 8203, 45007],
                    [47620, 3963, 27701, 20749, 40909, 18793, 25356, 61272, 31210, 52127, 59875, 23758, 61105, 35731, 44582, 5403],
                    [4923, 59571, 27361, 32663, 54364, 50740, 47073, 46706, 11430, 39028, 62126, 15938, 13854, 21280, 41020, 44250],
                    [36495, 39319, 22790, 8282, 21049, 53476, 58482, 63690, 24856, 36757, 61169, 28765, 61383, 15468, 27518, 48825],
                    [6670, 22264, 30113, 51909, 7221, 31731, 63234, 7272, 22321, 44164, 7022, 19185, 28804, 53810, 10030, 8397],
                    [23372, 39852, 37439, 8528, 6944, 9497, 40252, 4427, 52306, 14132, 5411, 12954, 23639, 54223, 59029, 57407],
                    [5848, 700, 41324, 34164, 54152, 46356, 32955, 4917, 41869, 52246, 39441, 30706, 45053, 17938, 282, 4849]
                    ]

         b_huge = vector [36495, 39319, 22790, 8282, 21049, 53476, 58482, 63690, 24856, 36757, 61169, 28765, 61383, 15468, 27518, 48825]

	 x_huge = linSolv a_huge b_huge
 
	 -- This is the preferred test setting:

#if (INPUT_SIZE==1)
	 a = a4
	 b = b4
	 x = x4
#elif (INPUT_SIZE==2)
	 a = a9
	 b = b9
	 x = x9
#elif (INPUT_SIZE==3)
	 a = a8
	 b = b8
	 x = x8
#elif (INPUT_SIZE==4)
	 a = a11
	 b = b11
	 x = x11
#elif (INPUT_SIZE==9)
	 a = a_huge
	 b = b_huge
	 x = x_huge
#else
	 a = a9
	 b = b9
	 x = x9
#endif
       in  
         seq [ "Testing linSolv with various matrices:\n",
               "\nSolving a*x=b for a = ",
               show a,
               "b = ",
               show b,
               "\nSolution: ",
               show x,
               "\n"
             ]
