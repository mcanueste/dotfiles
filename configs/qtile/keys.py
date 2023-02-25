from libqtile.config import Click, Drag, Key
from libqtile.lazy import lazy


def init_keys(mod: str, terminal: str):
    return [
        Key(
            [mod],
            "Return",
            lazy.spawn(terminal),
            desc="Launch terminal",
        ),
        Key(
            [mod],
            "d",
            lazy.spawn("rofi -mode drun -show drun"),
            desc="Launcher",
        ),
        Key(
            [mod],
            "r",
            lazy.spawn("rofi -mode run -show run"),
            desc="Launcher",
        ),
        Key(
            [mod],
            "w",
            lazy.spawn("rofi -mode window -show window"),
            desc="Launcher",
        ),
        Key([mod], "q", lazy.window.kill(), desc="Kill active window"),
        Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
        Key([mod], "g", lazy.window.toggle_floating(), desc="Toggle floating"),
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle layouts"),
        Key([mod], "m", lazy.next_screen(), desc="Move focus to next monitor"),
        Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
        Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        # Key(
        #     [mod, "shift"], ",", lazy.layout.shrink(), desc="Shrink window"
        # ),
        # Key([mod, "shift"], ".", lazy.layout.grow(), desc="Grow window"),
        Key(
            [mod, "shift"],
            "n",
            lazy.layout.normalize(),
            desc="Normalize windows",
        ),
        Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 5%+")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
        Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioStop", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    ]


def init_mouse(mod: str):
    return [
        # Left click
        Drag(
            [mod],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        # Right click
        Drag(
            [mod],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        # Scroll wheel
        Click(
            [mod],
            "Button2",
            lazy.window.bring_to_front(),
        ),
    ]
