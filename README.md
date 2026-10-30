# Where does the Bahn lose its minutes?

An analysis of Deutsche Bahn punctuality across Germany over 12 months (Oct 2025 to Sep 2026), with a deep-dive on NRW (Nordrhein-Westfalen).

> **Headline findings:** _to be written once the analysis is done. Lead with the result, not the method._

## Questions
1. Can the raw data reproduce DB's official monthly punctuality? If not, why not?
2. How much worse is punctuality once cancelled trains are counted ("honest punctuality")? Are late trains cut short more often, which removes their stops from the official figure?
3. Which stations, lines and hours lose the most time?
4. Where along an ICE route does delay build up?
5. What predicts a late arrival? (logistic regression)

## Data
[piebro/deutsche-bahn-data](https://huggingface.co/datasets/piebro/deutsche-bahn-data) — stop-level schedule, delay and cancellation records collected from DB's public timetable API. Licence: CC BY 4.0 (Deutsche Bahn). About 15 million rows and about 360 MB per month.

## How to run
```bash
pip install -r requirements.txt
python src/download.py 2025-10 2026-09   # about 4 GB
python src/build_db.py                   # builds data/db_punctuality.duckdb
```

## Repo layout
| Folder | Contents |
|---|---|
| `src/` | Download and build scripts |
| `sql/` | Staging and KPI tables (run in order) |
| `notebooks/` | Exploration, validation and regression |
| `docs/` | KPI definitions |
| `dashboard/` | Power BI file and screenshots |
