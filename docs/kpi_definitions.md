# KPI definitions

One definition per metric, so every chart and table uses the same numbers.

| KPI | Definition | Notes |
|---|---|---|
| Official punctuality | Share of non-cancelled planned stops reached less than 6 minutes late (delay of 5:59 or less) | Mirrors DB's "betriebliche Pünktlichkeit". Cancelled stops are left out, as DB does. |
| Honest punctuality | Share of all planned stops reached less than 6 minutes late, counting a cancelled stop as not on time | The project's own metric: shows what the official number hides. |
| Cancellation rate | Share of planned stops where the arrival was cancelled | |
| Average delay | Mean arrival delay in minutes, non-cancelled stops only | Sensitive to a few very late trains; check the median too. |

**Segments:** long distance = ICE, IC, EC. Regional = all other rail. Buses are excluded.

**Grain:** one row per train per stop (`stg_stops`). One journey (one train run on one day) = `journey_id`.

**Journey types** (long distance):
- *Ran fully* — no stop cancelled.
- *Cut short* — every stop after a certain point cancelled (e.g. turned back early).
- *Skipped stops mid-route* — some stops cancelled, later stops still served.
- *Fully cancelled* — every stop cancelled.
