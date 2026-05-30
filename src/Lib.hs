module Lib
  ( getA0,
    getA1,
    stats,
    sumWithF,
    squareListF,
    toRound,
    correctNewLinesPure,
  )
where

correctNewLinesPure :: String -> IO String
correctNewLinesPure s = pure $ correctNewLines s

correctNewLines :: String -> String
correctNewLines [] = []
correctNewLines ('\\' : 'n' : xs) = '\n' : correctNewLines xs
correctNewLines (x0 : xs) = x0 : correctNewLines xs

getA0 f xs ys = (sumOfSquaredXs * sumOfYs - sumOfXTimesY * sumOfXs) / denominator
  where
    (sumOfXs, sumOfYs, sumOfSquaredXs, sumOfXTimesY, m) = stats f xs ys
    denominator = m * sumOfSquaredXs - sumOfXs * sumOfXs

getA1 f xs ys = (m * sumOfXTimesY - sumOfXs * sumOfYs) / denominator
  where
    (sumOfXs, sumOfYs, sumOfSquaredXs, sumOfXTimesY, m) = stats f xs ys
    denominator = m * sumOfSquaredXs - sumOfXs * sumOfXs

stats f xs ys =
  ( sumWithF f xs,
    sumWithF f ys,
    sumWithF f $ squareListF f xs,
    sumWithF f $ zipWith (*) (map f xs) (map f ys),
    fromIntegral $ length xs
  )

sumWithF :: (Double -> Double) -> [Double] -> Double
sumWithF f xs = sum $ map f xs

squareListF :: (Double -> Double) -> [Double] -> [Double]
squareListF f = map (f . (\x -> x * x) . f)

toRound :: Int -> Double -> Double
toRound n x = realToFrac (round (x * 10 ^ n)) / 10 ^ n
