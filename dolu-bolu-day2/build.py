"""Build index.html from src/index.tpl.

Scenes are authored in ORIGINAL recording seconds. The footage was cut to
remove pauses (assets/keep.json) and sped up 1.1x, so every time is mapped
onto the edited timeline here:
  {{T:x}}    -> edited time of original second x
  {{D:a:b}}  -> edited duration between original seconds a and b
  /*KEEP*/   -> keep-segment list for the in-page T() helper
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).parent
KEEP = json.loads((ROOT / "assets/keep.json").read_text())
SPEED = 1.05


def T(t):
    acc = 0.0
    for s, e in KEEP:
        if t < s:
            return round(acc / SPEED, 3)
        if t <= e:
            return round((acc + t - s) / SPEED, 3)
        acc += e - s
    return round(acc / SPEED, 3)


src = (ROOT / "src/index.tpl").read_text()
src = re.sub(r"\{\{T:([\d.]+)\}\}", lambda m: str(T(float(m.group(1)))), src)
src = re.sub(r"\{\{D:([\d.]+):([\d.]+)\}\}", lambda m: str(round(T(float(m.group(2))) - T(float(m.group(1))), 3)), src)
src = src.replace("/*KEEP*/", json.dumps(KEEP))
(ROOT / "index.html").write_text(src)
print("built index.html, total", T(92.2), "s")
