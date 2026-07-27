from PIL import Image, ImageFilter
from collections import deque
import os
from pathlib import Path

# Paths are resolved from this file, not the shell's working directory, so the
# script can be run from anywhere: `python tool/icons/process_icon.py`
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

SRC = HERE / "icon_source_raw.png"

im = Image.open(SRC).convert("RGBA")
w, h = im.size
px = im.load()


def is_bg(r, g, b):
    return r < 20 and g < 20 and b < 20


visited = bytearray(w * h)
q = deque()


def seed(x, y):
    idx = y * w + x
    if visited[idx]:
        return
    r, g, b, a = px[x, y]
    if is_bg(r, g, b):
        visited[idx] = 1
        q.append((x, y))


for x in range(w):
    seed(x, 0)
    seed(x, h - 1)
for y in range(h):
    seed(0, y)
    seed(w - 1, y)

while q:
    x, y = q.popleft()
    for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        nx, ny = x + dx, y + dy
        if 0 <= nx < w and 0 <= ny < h:
            idx = ny * w + nx
            if not visited[idx]:
                r, g, b, a = px[nx, ny]
                if is_bg(r, g, b):
                    visited[idx] = 1
                    q.append((nx, ny))

# Purple fill color, sampled from a flat area of the source.
PURPLE = (212, 165, 237, 255)

full = Image.new("RGBA", (w, h), (0, 0, 0, 0))  # purple square + art, as-is
fpx = full.load()
fg = Image.new("RGBA", (w, h), (0, 0, 0, 0))  # art only, transparent elsewhere
gpx = fg.load()
art_mask = Image.new("L", (w, h), 0)  # 255 where the isolated black art is
mpx = art_mask.load()

for y in range(h):
    for x in range(w):
        idx = y * w + x
        if visited[idx]:
            continue  # outer background -> stays transparent everywhere
        r, g, b, a = px[x, y]
        fpx[x, y] = (r, g, b, a)
        if is_bg(r, g, b):
            gpx[x, y] = (0, 0, 0, 255)
            mpx[x, y] = 255

# Dilate the art mask a few pixels so the anti-aliased edge fringe around the
# original glyphs (semi-transparent blend between black and purple) is also
# covered when we erase the art below — otherwise a faint ghost outline of
# the original (off-center) art remains visible.
art_mask = art_mask.filter(ImageFilter.MaxFilter(7))

square_only = Image.new("RGBA", (w, h), (0, 0, 0, 0))  # purple square, art erased
spx = square_only.load()
for y in range(h):
    for x in range(w):
        idx = y * w + x
        if visited[idx]:
            continue
        r, g, b, a = px[x, y]
        spx[x, y] = PURPLE if art_mask.getpixel((x, y)) else (r, g, b, a)

bbox = full.getbbox()
full_cropped = full.crop(bbox)
square_only_cropped = square_only.crop(bbox)
fg_bbox = fg.getbbox()
fg_cropped = fg.crop(fg_bbox)

print("square size:", full_cropped.size, "art size:", fg_cropped.size)

# Re-center the art within the square with equal margins on every side
# (keeps things safe even if the source composition isn't perfectly
# symmetric — matters a lot once a launcher masks the icon to a circle).
sq_w, sq_h = square_only_cropped.size
art_w, art_h = fg_cropped.size
target_ratio = 0.52  # art's largest dimension as a fraction of the square
scale = min(target_ratio * sq_w / art_w, target_ratio * sq_h / art_h)
new_w, new_h = round(art_w * scale), round(art_h * scale)
art_resized = fg_cropped.resize((new_w, new_h), Image.LANCZOS)

recentered = square_only_cropped.copy()
x = (sq_w - new_w) // 2
y = (sq_h - new_h) // 2
recentered.alpha_composite(art_resized, (x, y))
# icon.png is shipped with the app (declared in pubspec.yaml); the foreground
# art is only an input for generate_launcher_icons.py, so it stays in tool/.
recentered.save(ROOT / "assets/icon.png")

fg_cropped.save(HERE / "icon_foreground_art.png")
print("recentered icon saved:", recentered.size, "art placed at", (x, y), (new_w, new_h))
