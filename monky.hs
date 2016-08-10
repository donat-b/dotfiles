import Monky
import Monky.Modules

import Monky.Examples.CPU
import Monky.Examples.Memory
import Monky.Examples.Network
import Monky.Examples.Time
import Monky.Examples.Disk

import Monky.Outputs.Ascii

import Data.Text (Text)
import Data.List (isPrefixOf)

filterNs :: String -> Bool
filterNs "lo" = False
filterNs str = not ("tun" `isPrefixOf` str)

main :: IO()
main = startLoop (getAsciiOut)
  [ pollPack 1 $ getDynamicHandle "No Network" filterNs
  --, pollPack 50 $ getMemoryHandle
  , pollPack 5 $ getDiskHandle "f9546c54-8df5-4572-a868-ef3cbb0d9ec5"
  , pollPack 5 $ getDiskHandle "e3cc9481-7566-4a2f-8fcd-54181fc0842b"
  , pollPack 5 $ getDiskHandle "22501ea5-3289-4a5f-bcda-c0d6edc26713"
  , pollPack 1 $ getFancyTimeHandle "%A %d %b %H:%M:%S"
  ]

