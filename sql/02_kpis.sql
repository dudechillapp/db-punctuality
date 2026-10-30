-- KPIs per month and segment (definitions in docs/kpi_definitions.md).
CREATE OR REPLACE TABLE mart_monthly_kpis AS
SELECT
    month,
    segment,
    count(*)                                                            AS planned_stops,
    round(100 * avg(CASE WHEN NOT is_cancelled THEN (delay_in_min < 6)::INT END), 1)
                                                                        AS official_punctuality_pct,
    round(100 * avg(CASE WHEN is_cancelled THEN 0 ELSE (delay_in_min < 6)::INT END), 1)
                                                                        AS honest_punctuality_pct,
    round(100 * avg(is_cancelled::INT), 1)                              AS cancelled_pct,
    round(avg(CASE WHEN NOT is_cancelled THEN delay_in_min END), 2)     AS avg_delay_min
FROM stg_stops
GROUP BY ALL
HAVING count(*) > 10000;   -- drops stray edge rows from neighbouring months
