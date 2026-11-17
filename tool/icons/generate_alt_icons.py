from PIL import Image, ImageDraw
import os
import json
from pathlib import Path

# Generates every launcher variant for every alternate app icon: Android
# legacy + adaptive mipmaps, iOS alternate-icon PNGs, and the in-app preview
# assets. Run from anywhere: python tool/icons/generate_alt_icons.py
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
RES = str(ROOT / "android" / "app" / "src" / "main" / "res")
ASSETS = ROOT / "assets"
IOS_ASSETS = ROOT / "ios" / "Runner" / "Assets.xcassets"
ICONS = [
    {"key": "global_love", "ios_name": "AppIcon-GlobalLove"},
    # preview_scale zooms the glyph inside the in-app picker asset only —
    # the launcher (SOURCE_SCALE / legacy) and iOS (IOS_SCALE) output is
    # untouched unless those constants or "scale" change.
    {"key": "alpine", "ios_name": "AppIcon-Alpine", "preview_scale": 0.96},
    {"key": "minimalist", "ios_name": "AppIcon-Minimalist"},
    {"key": "modern", "ios_name": "AppIcon-Modern"},
    {"key": "small_hand", "ios_name": "AppIcon-SmallHand", "preview_scale": 0.96},
    {"key": "white_lake", "ios_name": "AppIcon-WhiteLake", "preview_scale": 0.96},
]

APP_BG = (212, 165, 237, 255)

legacy_sizes = {
    "mdpi": 48,
    "hdpi": 72,
    "xhdpi": 96,
    "xxhdpi": 144,
    "xxxhdpi": 192,
}
adaptive_sizes = {
    "mdpi": 108,
    "hdpi": 162,
    "xhdpi": 216,
    "xxhdpi": 324,
    "xxxhdpi": 432,
}

# How much of the adaptive canvas an illustration's content spans on the launcher
SOURCE_SCALE = 0.55
PREVIEW_SCALE = 0.68
IOS_SCALE = 0.72


def load_art(key):
    art = Image.open(HERE / f"icon_{key}_art.png").convert("RGBA")
    # center-crop to square
    side = min(art.width, art.height)
    art = art.crop(
        (
            (art.width - side) // 2,
            (art.height - side) // 2,
            (art.width - side) // 2 + side,
            (art.height - side) // 2 + side,
        )
    )
    corners = [
        art.getpixel((0, 0))[3],
        art.getpixel((art.width - 1, 0))[3],
        art.getpixel((0, art.height - 1))[3],
        art.getpixel((art.width - 1, art.height - 1))[3],
    ]
    full_bleed = all(a > 250 for a in corners)
    return art, full_bleed


def scaled(art, size):
    return art.resize((size, size), Image.LANCZOS)


def glyph_on(canvas_size, scale, art, bg_color, anchor=None):
    canvas = Image.new("RGBA", (canvas_size, canvas_size), bg_color)
    target = canvas_size * scale
    s = min(target / art.width, target / art.height)
    g = art.resize((max(1, round(art.width * s)), max(1, round(art.height * s))), Image.LANCZOS)
    if anchor == "br":
        # A corner motif that must touch the icon's border: the bottom and
        # right margins shrink to a sliver instead of being balanced.
        margin = max(1, round(canvas_size * 0.015))
        pos = (canvas_size - g.width - margin, canvas_size - g.height - margin)
    else:
        pos = ((canvas_size - g.width) // 2, (canvas_size - g.height) // 2)
    canvas.alpha_composite(g, pos)
    return canvas


def bg_fill_color(art):
    """The padding color for a full-bleed illustration.

    Not the exact corner pixel: edge pixels can be a hair darker than the
    mat the logo actually sits on (Small Hand's corner black vs its true
    background). Instead, the most common color along an inset border band —
    the shade that visually surrounds the artwork.
    """
    side = art.width
    inset = max(2, round(side * 0.06))
    band = []
    for x in range(inset, side - inset, 4):
        band.append(art.getpixel((x, inset)))
        band.append(art.getpixel((x, side - 1 - inset)))
    for y in range(inset, side - inset, 4):
        band.append(art.getpixel((inset, y)))
        band.append(art.getpixel((side - 1 - inset, y)))
    counts = {}
    for c in band:
        counts[c] = counts.get(c, 0) + 1
    return max(counts.items(), key=lambda kv: kv[1])[0]


def content_box(art, fill, tol=18):
    """Bounding box of the artwork's actual drawing.

    Sources arrive with varying amounts of their own background around the
    drawing — padding the raw squares would make every icon's emblem read a
    different size at the same scale. Cropping to what's actually drawn
    first makes the scale mean the same thing for every icon, so the picker
    previews and the launcher crop line up across the catalog.
    """
    px = art.load()
    minx, miny = art.width, art.height
    maxx = maxy = 0
    fr, fg, fb, fa = fill
    found = False
    for y in range(0, art.height, 2):
        for x in range(0, art.width, 2):
            r, g, b, a = px[x, y]
            if abs(r - fr) + abs(g - fg) + abs(b - fb) > tol or abs(a - fa) > 16:
                found = True
                if x < minx:
                    minx = x
                if y < miny:
                    miny = y
                if x > maxx:
                    maxx = x
                if y > maxy:
                    maxy = y
    if not found:
        return art
    margin = max(2, round(art.width * 0.01))
    box = (
        max(0, minx - margin),
        max(0, miny - margin),
        min(art.width, maxx + 1 + margin),
        min(art.height, maxy + 1 + margin),
    )
    return art.crop(box)


for spec in ICONS:
    key = spec["key"]
    ios_name = spec["ios_name"]
    scale = spec.get("scale", SOURCE_SCALE)
    anchor = spec.get("anchor")
    art, full_bleed = load_art(key)
    fill = bg_fill_color(art)
    glyph = content_box(art, fill) if full_bleed else art
    print(f"--- {key} (full bleed: {full_bleed}, fill {fill}, scale {scale}, anchor {anchor})")

    # Android legacy: the illustration as shipped.
    for density, size in legacy_sizes.items():
        out_dir = os.path.join(RES, f"mipmap-{density}")
        os.makedirs(out_dir, exist_ok=True)
        scaled(art, size).save(os.path.join(out_dir, f"ic_launcher_{key}.png"))

    # Android adaptive.
    for density, canvas_size in adaptive_sizes.items():
        out_dir = os.path.join(RES, f"mipmap-{density}")
        os.makedirs(out_dir, exist_ok=True)
        if full_bleed:
            bg = glyph_on(canvas_size, scale, glyph, fill, anchor)
        else:
            bg = scaled(art, canvas_size)
        fg = Image.new("RGBA", (canvas_size, canvas_size), (0, 0, 0, 0))
        bg.save(os.path.join(out_dir, f"ic_launcher_{key}_bg.png"))
        fg.save(os.path.join(out_dir, f"ic_launcher_{key}_fg.png"))

    anydpi = os.path.join(RES, "mipmap-anydpi-v26")
    os.makedirs(anydpi, exist_ok=True)
    xml = f"""<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@mipmap/ic_launcher_{key}_bg"/>
    <foreground android:drawable="@mipmap/ic_launcher_{key}_fg"/>
</adaptive-icon>
"""
    with open(os.path.join(anydpi, f"ic_launcher_{key}.xml"), "w") as f:
        f.write(xml)

    # In-app preview: the same padded square the launcher composes, shown
    # square to match the tile frames on the picker. Icons can opt into a
    # larger preview_scale to read bigger in the picker without any change
    # to what the launcher shows.
    preview_scale = spec.get("preview_scale", PREVIEW_SCALE)
    if full_bleed:
        preview = glyph_on(512, preview_scale, glyph, fill, anchor)
    elif preview_scale != PREVIEW_SCALE:
        # Shaped art: crop to what is actually drawn, then re-compose larger
        # on a transparent canvas so the tile keeps its transparency.
        shaped_glyph = content_box(art, (0, 0, 0, 0))
        preview = glyph_on(512, preview_scale, shaped_glyph, (0, 0, 0, 0))
    else:
        # Shaped art keeps its own transparency in the preview tile.
        preview = scaled(art, 512)
    preview.save(str(ASSETS / f"icon_{key}.png"))

    # iOS alternate icons: full squares without alpha, composed the same way.
    ios_dir = IOS_ASSETS / f"{ios_name}.appiconset"
    ios_dir.mkdir(parents=True, exist_ok=True)
    ios_sizes = [
        ("Icon-20@2x.png", 40),
        ("Icon-20@3x.png", 60),
        ("Icon-29@2x.png", 58),
        ("Icon-29@3x.png", 87),
        ("Icon-40@2x.png", 80),
        ("Icon-40@3x.png", 120),
        ("Icon-60@2x.png", 120),
        ("Icon-60@3x.png", 180),
        ("Icon-1024.png", 1024),
    ]
    for filename, pixels in ios_sizes:
        if full_bleed:
            square = glyph_on(pixels, IOS_SCALE, glyph, fill, anchor)
        else:
            square = Image.new("RGBA", (pixels, pixels), APP_BG)
            square.alpha_composite(scaled(art, pixels))
        square.convert("RGB").save(str(ios_dir / filename))
    contents = {
        "images": [
            {
                "filename": "Icon-1024.png",
                "idiom": "universal",
                "platform": "ios",
                "size": "1024x1024",
            }
        ],
        "info": {"author": "xcode", "version": 1},
    }
    with open(ios_dir / "Contents.json", "w") as f:
        json.dump(contents, f, indent=2)
    print(f"done {key}")
