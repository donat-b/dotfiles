#!/usr/bin/env python2
import dbus

# Clementine lives on the Session bus
session_bus = dbus.SessionBus()

# Get Clementine's player object, and then get an interface from that object,
# otherwise we'd have to type out the full interface name on every method call.
player = session_bus.get_object('org.mpris.clementine', '/Player')
iface = dbus.Interface(player, dbus_interface='org.freedesktop.MediaPlayer')

# Call a method on the interface
metadata = iface.GetMetadata()
print(metadata["artist"] +' - ' + metadata["title"])
