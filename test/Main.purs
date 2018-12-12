module Test.Main where

import Prelude
import Data.ArrayBuffer.ArrayBuffer as AB
import Effect (Effect)
import Data.Either (fromRight)
import Partial.Unsafe (unsafePartial)
import Test.QuickCheck (quickCheck', (<?>), quickCheck)
import Test.Input (WellFormedInput(..))

assertEquals :: forall a. Eq a => Show a => a -> a -> Effect Unit
assertEquals expected actual = do
  let msg = show expected <> " /= " <> show actual
  quickCheck' 1 $ expected == actual <?> msg

main :: Effect Unit
main = do
  assertEquals "釺椱�밸造ə㊡癥闗" (unsafePartial $ fromRight $ AB.decodeToString $ AB.fromString "釺椱�밸造ə㊡癥闗")	
  quickCheck	
    \(WellFormedInput s) ->	
        let	
          result = (unsafePartial $ fromRight $ AB.decodeToString $ AB.fromString s)	
        in	
          s == result	
          <?> "Isormorphic arraybuffer conversion with string failed for input\n"	
          <> s	
          <> " which, after the round trip, result in\n"	
          <> result	
