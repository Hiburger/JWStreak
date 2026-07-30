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
