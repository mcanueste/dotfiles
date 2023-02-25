from typing import List

from libqtile import layout
from libqtile.config import Group, Match


def init_layouts(
    margin: int,
    border_width: int,
    border_normal: str,
    border_focus: str,
    single_margin: int = 0,
    single_border_width: int = 0,
    fullscreen_border_width: int = 0,
    maximized_border_width: int = 0,
    change_ratio: float = 0.02,
    min_ratio: float = 0.30,
    max_ratio: float = 0.70,
):
    default_args = {
        "border_width": border_width,
        "border_normal": border_normal,
        "border_focus": border_focus,
    }
    monad_args = {
        "change_ratio": change_ratio,
        "min_ratio": min_ratio,
        "max_ratio": max_ratio,
        "margin": margin,
        "single_margin": single_margin,
        "single_border_width": single_border_width,
    }
    return [
        layout.MonadTall(
            **default_args,
            **monad_args,
        ),
        layout.MonadWide(
            **default_args,
            **monad_args,
        ),
        layout.Matrix(
            **default_args,
            margin=margin,
            columns=2,
        ),
        layout.Floating(
            **default_args,
            fullscreen_border_width=fullscreen_border_width,
            max_border_width=maximized_border_width,
        ),
    ]


def init_floating_layout(
    border_width: int,
    border_normal: str,
    border_focus: str,
    floating_wm_classes: List[str],
    floating_titles: List[str],
    fullscreen_border_width: int = 0,
    maximized_border_width: int = 0,
):
    return layout.Floating(
        border_width=border_width,
        border_normal=border_normal,
        border_focus=border_focus,
        fullscreen_border_width=fullscreen_border_width,
        max_border_width=maximized_border_width,
        float_rules=[
            *layout.Floating.default_float_rules,
            Match(
                wm_class=floating_wm_classes,
                title=floating_titles,
            ),
        ],
    )


def init_groups(default_layout: str = "monadtall"):
    return [
        Group(f"{str(idx%10)}", layout="floating" if idx == 10 else default_layout)
        for idx in range(1, 11)
    ]
