"""Download monthly Deutsche Bahn delay files (piebro/deutsche-bahn-data, CC BY 4.0).

Usage:  python src/download.py 2025-10 2026-09
Files already on disk are skipped, so it is safe to re-run.
"""
import sys
import urllib.request
from pathlib import Path

BASE = ("https://huggingface.co/datasets/piebro/deutsche-bahn-data/"
        "resolve/main/monthly_processed_data/data-{ym}.parquet")
OUT = Path(__file__).resolve().parent.parent / "data" / "raw"


def months(start: str, end: str):
    y, m = map(int, start.split("-"))
    ey, em = map(int, end.split("-"))
    while (y, m) <= (ey, em):
        yield f"{y}-{m:02d}"
        y, m = (y + 1, 1) if m == 12 else (y, m + 1)


def main():
    start, end = (sys.argv[1], sys.argv[2]) if len(sys.argv) == 3 else ("2025-10", "2026-09")
    OUT.mkdir(parents=True, exist_ok=True)
    for ym in months(start, end):
        target = OUT / f"data-{ym}.parquet"
        if target.exists() and target.stat().st_size > 0:
            print(f"skip {ym} (already downloaded)")
            continue
        print(f"downloading {ym} ...", flush=True)
        tmp = target.with_suffix(".part")
        urllib.request.urlretrieve(BASE.format(ym=ym), tmp)
        tmp.replace(target)
        print(f"  done: {target.stat().st_size / 1e6:.0f} MB")


if __name__ == "__main__":
    main()
