from PIL import Image
import json
from pathlib import Path

# Paths are resolved from this file, not the shell's working directory, so the
# script can be run from anywhere: `python tool/icons/generate_ios_icons.py`
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

APPICON = ROOT / "ios/Runner/Assets.xcassets/AppIcon.appiconset"

# #D4A5ED, the same value as ic_launcher_background in android's colors.xml —
# the iOS icon is deliberately the Android adaptive icon's twin.
BACKGROUND = (212, 165, 237)

# How much of the canvas the glyph spans. Larger than the Android adaptive
# icon's 0.50 because that canvas budgets for a mask that can crop a third of
# it away; iOS only rounds the corners, so the art can sit much closer to the
# edge without risking a clip.
GLYPH_SCALE = 0.66

# Composed from the isolated glyph on a flat field rather than resized from
# assets/icon.png: that file draws its own rounded square with a white outline
# and transparent corners, and iOS — which bans alpha and applies its own
# squircle — would slice through that outline and leave white shards in the
# corners.
art = Image.open(HERE / "icon_foreground_art.png").convert("RGBA")

# Driving the sizes off Contents.json (rather than a list copied into this
# script) means Xcode and this generator can't disagree about what's needed.
contents = json.loads((APPICON / "Contents.json").read_text())

wanted: dict[str, int] = {}
for image in contents["images"]:
    filename = image.get("filename")
    if not filename:
        continue
    points = float(image["size"].split("x")[0])
    scale = int(image["scale"].rstrip("x"))
    wanted[filename] = round(points * scale)

for filename, pixels in sorted(wanted.items(), key=lambda kv: kv[1]):
    target = pixels * GLYPH_SCALE
    scale = min(target / art.width, target / art.height)
    glyph = art.resize(
        (max(1, round(art.width * scale)), max(1, round(art.height * scale))),
        Image.LANCZOS,
    )
    # Mode "RGB" is what keeps the alpha channel out of the saved file; iOS
    # rejects app icons that carry one.
    canvas = Image.new("RGB", (pixels, pixels), BACKGROUND)
    canvas.paste(
        glyph,
        ((pixels - glyph.width) // 2, (pixels - glyph.height) // 2),
        glyph,  # third arg = use the glyph's own alpha as the paste mask
    )
    canvas.save(APPICON / filename)
    print("ios icon", filename, f"{pixels}x{pixels}")

print(f"done: {len(wanted)} icons")
