module Main where

import PreludeGlaST

main = putStr (shows res "\n")
	where
	res = unsafePerformPrimIO (
		ca `thenPrimIO` \r -> returnPrimIO r)
	ca :: PrimIO Float
	ca = _ccall_ nn
