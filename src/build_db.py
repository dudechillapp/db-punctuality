"""Build data/db_punctuality.duckdb from the raw parquet files by running sql/*.sql in order."""
from pathlib import Path
import duckdb

ROOT = Path(__file__).resolve().parent.parent
con = duckdb.connect(str(ROOT / "data" / "db_punctuality.duckdb"))
con.execute(f"SET VARIABLE raw_glob = '{(ROOT / 'data' / 'raw' / 'data-*.parquet').as_posix()}'")
for f in sorted((ROOT / "sql").glob("*.sql")):
    print(f"running {f.name}")
    con.execute(f.read_text(encoding="utf-8"))
for t in ["stg_stops", "mart_monthly_kpis"]:
    print(t, con.execute(f"select count(*) from {t}").fetchall()[0][0], "rows")
print(con.execute("select * from mart_monthly_kpis order by month, segment").df().to_string())
