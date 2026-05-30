import Graphics.Matplotlib
import Lib

decimalPlaces :: Int
decimalPlaces = 3

main = do
  print "With Rounding: "
  print roundedA0
  print roundedA1
  print "Without Rounding: "
  print notRoundedA0
  print notRoundedA1
  print "Errors Squared: "
  print $ sum $ zipWith (\x y -> (x - y) * (x - y)) ys ys_approx
  print "Python Code: "
  onscreen mPlot >> code mPlot >>= correctNewLinesPure >>= putStr
  where
    roundedA0 = roundedF getA0
    roundedA1 = roundedF getA1
    notRoundedA0 = notRoundedF getA0
    notRoundedA1 = notRoundedF getA1
    roundedF f = f (toRound 3) xs ys
    notRoundedF f = f id xs ys
    xs = [1 .. 8]
    ys = [0.5, 0.6, 0.9, 0.8, 1.2, 1.5, 1.7, 2.0]
    ys_approx = [roundedA0 + roundedA1 * x | x <- xs]
    mPlot = scatter xs ys @@ [o2 "c" "#ff0000"] % plot xs ys_approx @@ [o1 "b-"]
