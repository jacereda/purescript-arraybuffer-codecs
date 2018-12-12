module Data.ArrayBuffer.Encoding
  ( decodeToString
  , fromString
  , module Base64
  ) where

import Prelude ((<<<))
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.ArrayBuffer.Typed (asUint8Array, dataView)
import Data.ArrayBuffer.DataView (buffer, whole)
import Data.Base64(encodeBase64, decodeBase64) as Base64
import Data.Either (Either)
import Data.TextDecoder (decodeUtf8)
import Data.TextEncoder (encodeUtf8)
import Effect.Exception (Error)

-- | Convert a UTF-8 encoded `ArrayBuffer` into a `String`.
-- | Serves as a quick utility function for a common use-case. For more use-cases,
-- | see: [purescript-text-encoding](https://pursuit.purescript.org/packages/purescript-text-encoding/0.0.9)
-- | Requires the TextDecoder class available. A polyfill can be found in the npm package "text-encoding"
decodeToString :: ArrayBuffer -> Either Error String
decodeToString = decodeUtf8 <<< asUint8Array <<< whole

-- | Convert a  `String` into a UTF-8 encoded `ArrayBuffer`.
-- | Serves as a quick utility function for a common use-case. For more use-cases,
-- | see: [purescript-text-encoding](https://pursuit.purescript.org/packages/purescript-text-encoding/0.0.9)
-- | Requires the TextDecoder class available. A polyfill can be found in the npm package "text-encoding"
fromString :: String -> ArrayBuffer
fromString = buffer <<< dataView <<< encodeUtf8
