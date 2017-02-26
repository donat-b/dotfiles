import Monky
import Monky.Modules

import Monky.Examples.Battery
import Monky.Examples.CPU
import Monky.Examples.Disk
import Monky.Examples.Memory
import Monky.Examples.Network
import Monky.Examples.Sound.Alsa
import Monky.Examples.Time
import Monky.Examples.Wifi

import Monky.Outputs.I3

import Data.Text (Text)
import Data.List (isPrefixOf)

filterNs :: String -> Bool
filterNs "lo" = False
filterNs str = not ("tun" `isPrefixOf` str)

main :: IO()
main = startLoop (getI3Output)
  [ pollPack 1 $ getDynamicHandle "No Network" filterNs
  -- breaks i3bar
  {-, evtPack    $ getWifiHandle [FormatName, FormatText ":", FormatChannel] "None" "wlan"-}
  , evtPack    $ getVOLHandle "default"
  , pollPack 5 $ getCPUHandle ScalingCur "thermal_zone0"
  , pollPack 3 $ getMemoryHandle
  {-, pollPack 9 $ getDiskHandle "80f3cf1d-36f1-47cc-bd2a-c3ee0b1299dd"-}
  , pollPack 2 $ getBatteryHandle' "AC0"
  , pollPack 1 $ getTimeHandle "%a %d %b %H:%M:%S"
  ]

