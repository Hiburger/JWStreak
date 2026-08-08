from PIL import Image
import os
from pathlib import Path

# Paths are resolved from this file, not the shell's working directory, so the
# script can be run from anywhere: `python tool/icons/generate_notification_icon.py`
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

RES = str(ROOT / "android/app/src/main/res")

# The status bar only ever renders this icon's alpha channel — Android fills
# it flat white (light theme) or applies the notification tint (dark theme,
# newer OS versions), discarding any color in the source. Feeding it the
# full-color launcher icon (as the default @mipmap/ic_launcher fallback does)
# makes every pixel inside its bounding shape opaque, which is why it shows
# up as a plain filled circle instead of the app's glyph. Recoloring the
# already-isolated foreground art to solid white keeps only the glyph's
# silhouette, which is what the guidelines call for regardless: white,
# transparent background, no color.
# https://developer.android.com/develop/ui/views/notifications/custom-notification#SmallIcon
art = Image.open(HERE / "icon_foreground_art.png").convert("RGBA")

# The shared foreground art is the "JWS" lettering stacked above the flower,
# which is right for the launcher icon but wrong here: fitted into a 24dp
# status bar icon the lettering is far too small to read, so it lands as a
# smudge above the glyph and steals room the flower could have used. That is
# especially visible in Android 16's Live Update chip, which is mostly just
# this icon. Android's own guidance is a single simple silhouette, so keep
# only the flower — the distinctive half of the mark, and legible at 24dp.
#
# Found rather than hardcoded so re-exporting the art can shift it: the two
# halves are separated by a band of fully transparent rows, and the flower is
# whatever sits below the widest such band.
def _flower_only(source: Image.Image) -> Image.Image:
    width, height = source.size
    source_alpha = source.split()[3]
    empty_rows = [
        y
        for y in range(height)
        if not source_alpha.crop((0, y, width, y + 1)).getbbox()
    ]
    widest_band: list[int] = []
    current: list[int] = []
    for y in empty_rows:
        if current and y == current[-1] + 1:
            current.append(y)
        else:
            current = [y]
        if len(current) > len(widest_band):
            widest_band = list(current)
    # A band touching the top or bottom edge is just margin, not a separator,
    # and art with no separator at all is presumably already a lone glyph.
    if not widest_band or widest_band[0] == 0 or widest_band[-1] == height - 1:
        return source
    below = source.crop((0, widest_band[-1] + 1, width, height))
    # Trim to the glyph itself so the scaling below sees no stray margin.
    return below.crop(below.split()[3].getbbox())


art = _flower_only(art)
alpha = art.split()[3]
white_art = Image.new("RGBA", art.size, (255, 255, 255, 0))
white_art.putalpha(alpha)

# Status bar icon sizes per density, per Android's guidelines (24dp base).
sizes = {
    "mdpi": 24,
    "hdpi": 36,
    "xhdpi": 48,
    "xxhdpi": 72,
    "xxxhdpi": 96,
}

for density, canvas_size in sizes.items():
    out_dir = os.path.join(RES, f"drawable-{density}")
    os.makedirs(out_dir, exist_ok=True)
    # Fit the glyph within ~75% of the canvas, centered — matches the safe
    # margin every stock Android status bar icon uses.
    target_max = canvas_size * 0.75
    scale = min(target_max / art.width, target_max / art.height)
    new_w, new_h = round(art.width * scale), round(art.height * scale)
    resized = white_art.resize((new_w, new_h), Image.LANCZOS)
    canvas = Image.new("RGBA", (canvas_size, canvas_size), (0, 0, 0, 0))
    x = (canvas_size - new_w) // 2
    y = (canvas_size - new_h) // 2
    canvas.alpha_composite(resized, (x, y))
    canvas.save(os.path.join(out_dir, "ic_stat_notify.png"))
    print("notification icon", density, canvas_size, "-> glyph", new_w, new_h)
