import os
import subprocess
from typing import List

from libqtile.config import hook
from libqtile.dgroups import simple_key_binder

from bar import init_screens, init_widgets
from keys import init_keys, init_mouse
from layouts import init_floating_layout, init_groups, init_layouts


MOD = "mod4"
ALT = "mod1"
TERMINAL = "alacritty"
WALLPAPER = "~/.config/qtile/Fast-Autocamp-4k-Dp-Wallpaper-scaled.jpg"

# Catpuccin theme
BG = "#1e1e2e"
FG = "#cdd6f4"
BLACK = "#585b70"
RED = "#f38ba8"
GREEN = "#a6e3a1"
YELLOW = "#f9e2af"
BLUE = "#89b4fa"
MAGENTA = "#f5c2e7"
CYAN = "#94e2d5"
WHITE = "#bac2de"

FONT = "SauceCodePro Nerd Font"
FONTSIZE = 12
PADDING = 8

LAYOUT_MARGIN = 4
LAYOUT_BORDER_WIDTH = 2
LAYOUT_BORDER_NORMAL = BLACK
LAYOUT_BORDER_FOCUS = CYAN

FLOATING_WM_CLASSES = [
    "confirmreset",
    "floating",
    "gnome-screenshot",
    "lxappearance",
    "Xephyr",
]
FLOATING_TITLES = [
    "branchdialog",
    "File Operation Progress",
    "Open File",
    "pinentry",
]

# Layout configs
focus_on_window_activation = "smart"
auto_fullscreen = True
auto_minimize = False
layouts = init_layouts(
    margin=LAYOUT_MARGIN,
    border_width=LAYOUT_BORDER_WIDTH,
    border_normal=LAYOUT_BORDER_NORMAL,
    border_focus=LAYOUT_BORDER_FOCUS,
)
floating_layout = init_floating_layout(
    border_width=LAYOUT_BORDER_WIDTH,
    border_normal=LAYOUT_BORDER_NORMAL,
    border_focus=LAYOUT_BORDER_FOCUS,
    floating_wm_classes=FLOATING_WM_CLASSES,
    floating_titles=FLOATING_TITLES,
)
# LG3D is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Mouse
cursor_warp = False
bring_front_click = True
follow_mouse_focus = False
mouse = init_mouse(mod=MOD)

# Keys
wl_input_rules = None
keys = init_keys(mod=MOD, terminal=TERMINAL)

# Groups
groups = init_groups()
dgroups_key_binder = simple_key_binder(MOD)
dgroups_app_rules = []  # type: List

# Bar
widget_defaults = {
    "font": FONT,
    "fontsize": FONTSIZE,
    "background": BG,
    "foreground": FG,
    "padding": PADDING,
}
extension_defaults = widget_defaults.copy()
widget_list = init_widgets(
    separator=BLACK,
    inactive_group=BLACK,
    active_screen=CYAN,
    inactive_screen=YELLOW,
    systray=True,
)

# Screens
reconfigure_screens = True
screens = init_screens(
    wallpaper=WALLPAPER,
    separator=BLACK,
    inactive_group=BLACK,
    active_screen=CYAN,
    inactive_screen=YELLOW,
)

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])
