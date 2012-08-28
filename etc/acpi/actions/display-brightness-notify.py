#!/usr/bin/env python2

import dbus

def get_lcd_level():
    f = open("/sys/class/backlight/acpi_video0/brightness", "r")
    level = f.read()
    f.close()
    return int(level)

def notify(app_name, last_id, icon, title, body, duration):
    hints = {"urgency": dbus.Byte(0), "desktop-entry": dbus.String("acpi")}

    item = "org.freedesktop.Notifications"
    path = "/org/freedesktop/Notifications"
    interface = "org.freedesktop.Notifications"

    bus = dbus.SessionBus()
    notif = bus.get_object(item, path)
    notify = dbus.Interface(notif, interface)
    return notify.Notify(app_name, last_id, icon, title, body, [], hints, time)

def get_id():
    try:
        f = open("/tmp/acpi-action-lcd-last-id", "r")
        id = f.read()
        if not id:
            id = 0
        f.close()
    except:
        id = 0
    return id

def set_id(id):
    f = open("/tmp/acpi-action-lcd-last-id", "w")
    f.write(str(id))
    f.close()


percent = get_lcd_level() * 100 // 15

app_name = "acpi-action-lcd"
last_id = get_id()
if percent <= 5:
    icon = "notification-display-brightness-off"
elif percent <= 30:
    icon = "notification-display-brightness-low"
elif percent <= 60:
    icon = "notification-display-brightness-medium"
elif percent <= 80:
    icon = "notification-display-brightness-high"
else:
    icon = "notification-display-brightness-full"
title = "LCD brightness"
body = str(percent) + "%"
time = 5000     # in miliseconds

last_id = notify(app_name, last_id, icon, title, body, time)
set_id(last_id)
