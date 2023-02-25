import subprocess

from libqtile import widget as widgets
from libqtile.bar import CALCULATED, Bar
from libqtile.config import Screen


class PAMixerVolume(widgets.Volume):
    def _update_drawer(self):
        icon = ""  # max vol by default
        if self.volume <= 0:
            icon = "婢"
        elif self.volume <= 30:
            icon = ""
        elif self.volume < 80:
            icon = "墳"

        vol = f"{self.volume}%"
        if self.volume == -1:
            vol = "M"

        self.text = f"{icon} {vol}"

    def get_volume(self):
        try:
            get_volume_cmd = "pamixer --get-volume-human"
            mixer_out = subprocess.getoutput(get_volume_cmd)
            if "muted" in mixer_out:
                return -1
            mixer_out = mixer_out.replace("%", "")
            mixer_out = int(mixer_out)
            return mixer_out
        except subprocess.CalledProcessError:
            return -1

    def cmd_increase_vol(self):
        subprocess.call(f"pamixer -i {self.step}", shell=True)

    def cmd_decrease_vol(self):
        subprocess.call(f"pamixer -d {self.step}", shell=True)

    def cmd_mute(self):
        muted = self.get_volume() == -1
        arg = "-u" if muted else "-m"
        subprocess.call(f"pamixer {arg}", shell=True)


class Separator(widgets.TextBox):
    def __init__(self, text="", width=CALCULATED, padding=4, offset=4, **config):
        super().__init__(
            text=text, width=width, padding=padding, offset=offset, **config
        )


def init_systray(separator: str):
    return [
        Separator(foreground=separator),
        widgets.BatteryIcon(
            offset=8,
        ),
        widgets.Systray(),
    ]


def init_widgets(
    separator: str,
    inactive_group: str,
    active_screen: str,
    inactive_screen: str,
    systray: bool = False,
):
    wdgts = [
        widgets.Spacer(length=4),
        widgets.CurrentLayoutIcon(
            scale=0.8,
            padding=0,
        ),
        Separator(foreground=separator),
        widgets.GroupBox(
            hide_unused=True,
            padding=4,
            borderwidth=3,
            inactive=inactive_group,
            this_screen_border=inactive_screen,
            other_screen_border=inactive_screen,
            this_current_screen_border=active_screen,
            other_current_screen_border=active_screen,
        ),
        Separator(foreground=separator),
        widgets.WindowName(),
        widgets.Spacer(),
        PAMixerVolume(
            step=5,
            emoji=True,
            update_interval=0.1,
            volume_app="pavucontrol",
        ),
        widgets.Backlight(
            step=5,
            backlight_name="intel_backlight",
            brightness_file="actual_brightness",
            max_brightness_file="max_brightness",
            format=" {percent:2.0%}",
        ),
        Separator(foreground=separator),
        widgets.Clock(
            format=" %A - %I:%M %p",
        ),
    ]
    if systray:
        wdgts += init_systray(separator=separator)
    wdgts += [widgets.Spacer(length=4)]
    return wdgts


def init_bar(
    separator: str,
    inactive_group: str,
    active_screen: str,
    inactive_screen: str,
    systray: bool = False,
):
    return Bar(
        size=20,
        opacity=1,
        border_width=2,
        widgets=init_widgets(
            separator=separator,
            inactive_group=inactive_group,
            active_screen=active_screen,
            inactive_screen=inactive_screen,
            systray=systray,
        ),
    )


def init_screens(
    wallpaper: str,
    separator: str,
    inactive_group: str,
    active_screen: str,
    inactive_screen: str,
):
    return [
        Screen(
            wallpaper=wallpaper,
            wallpaper_mode="fill",
            top=init_bar(
                separator=separator,
                inactive_group=inactive_group,
                active_screen=active_screen,
                inactive_screen=inactive_screen,
                systray=True,
            ),
        ),
        Screen(
            wallpaper=wallpaper,
            wallpaper_mode="fill",
            top=init_bar(
                separator=separator,
                inactive_group=inactive_group,
                active_screen=active_screen,
                inactive_screen=inactive_screen,
            ),
        ),
    ]
