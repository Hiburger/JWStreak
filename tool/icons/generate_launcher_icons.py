from PIL import Image
import os
from pathlib import Path

# Paths are resolved from this file, not the shell's working directory, so the
# script can be run from anywhere: `python tool/icons/generate_launcher_icons.py`
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

RES = str(ROOT / "android/app/src/main/res")

# icon.png is a shipped asset (see pubspec.yaml); the foreground art is an
# intermediate produced by process_icon.py and lives next to this script.
full = Image.open(ROOT / "assets/icon.png").convert("RGBA")
fg_art = Image.open(HERE / "icon_foreground_art.png").convert("RGBA")

# Legacy launcher icon sizes (square, includes the rounded purple shape).
legacy_sizes = {
    "mdpi": 48,
    "hdpi": 72,
    "xhdpi": 96,
    "xxhdpi": 144,
    "xxxhdpi": 192,
}

# Adaptive icon canvas sizes (108dp safe-zone canvas, same ratio as legacy).
adaptive_sizes = {
    "mdpi": 108,
    "hdpi": 162,
    "xhdpi": 216,
    "xxhdpi": 324,
    "xxxhdpi": 432,
}

for density, size in legacy_sizes.items():
    out_dir = os.path.join(RES, f"mipmap-{density}")
    os.makedirs(out_dir, exist_ok=True)
    resized = full.resize((size, size), Image.LANCZOS)
    resized.save(os.path.join(out_dir, "ic_launcher.png"))
    print("legacy", density, size)

# Foreground art centered within ~62% of the adaptive canvas (safe zone).
art_w, art_h = fg_art.size
scale_ratio = 0.50
for density, canvas_size in adaptive_sizes.items():
    out_dir = os.path.join(RES, f"mipmap-{density}")
    os.makedirs(out_dir, exist_ok=True)
    target_max = canvas_size * scale_ratio
    scale = min(target_max / art_w, target_max / art_h)
    new_w, new_h = round(art_w * scale), round(art_h * scale)
    art_resized = fg_art.resize((new_w, new_h), Image.LANCZOS)
    canvas = Image.new("RGBA", (canvas_size, canvas_size), (0, 0, 0, 0))
    x = (canvas_size - new_w) // 2
    y = (canvas_size - new_h) // 2
    canvas.alpha_composite(art_resized, (x, y))
    canvas.save(os.path.join(out_dir, "ic_launcher_foreground.png"))
    print("adaptive fg", density, canvas_size, "-> art", new_w, new_h)
