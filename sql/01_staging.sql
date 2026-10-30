-- Staging: one row per train per stop, cleaned and labelled.
-- Long-distance (Fernverkehr) = ICE, IC, EC; everything else on rail = regional.
CREATE OR REPLACE TABLE stg_stops AS
SELECT
    id                                   AS stop_id,
    regexp_replace(id, '-[0-9]+$', '')   AS journey_id,   -- one train run on one day
    train_line_ride_id                   AS ride_id,      -- same for every run of a line pattern
    train_line_station_num               AS stop_seq,
    eva                                  AS station_id,
    station_name,
    train_type,
    line_number,
    train_number,
    final_destination_station,
    CASE WHEN train_type IN ('ICE', 'IC', 'EC') THEN 'long_distance'
         WHEN train_type = 'Bus'                THEN 'bus'
         ELSE 'regional' END             AS segment,
    arrival_planned_time                 AS planned_arrival,
    arrival_change_time                  AS actual_arrival,
    delay_in_min,
    arrival_is_canceled                  AS is_cancelled,
    is_additional_stop,
    date_trunc('month', arrival_planned_time)::DATE AS month,
    hour(arrival_planned_time)           AS hour_of_day,
    dayname(arrival_planned_time)        AS weekday
FROM read_parquet(getvariable('raw_glob'))
WHERE arrival_planned_time IS NOT NULL      -- first stop has no arrival
  AND has_plan_record                       -- drop unplanned extras
  AND train_type <> 'Bus';                  -- rail only
