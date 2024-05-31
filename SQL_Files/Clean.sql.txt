-- Load data into the tables 
CREATE OR REPLACE VIEW `Cyclistic_Bike_datasets.combined_divvy_trips` AS
SELECT 
    CAST(ride_id AS STRING) AS trip_id, 
    rideable_type, 
    started_at AS start_time, 
    ended_at AS end_time, 
    start_station_name AS from_station_name, 
    CAST(start_station_id AS STRING) AS from_station_id, 
    end_station_name AS to_station_name, 
    CAST(end_station_id AS STRING) AS to_station_id, 
    member_casual AS usertype,
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length,
    EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
FROM `Cyclistic_Bike_datasets.Divvy_Trips_2020_Q1`
UNION ALL
SELECT 
    CAST(trip_id AS STRING) AS trip_id, 
    NULL AS rideable_type, 
    start_time, 
    end_time, 
    from_station_name, 
    CAST(from_station_id AS STRING) AS from_station_id, 
    to_station_name, 
    CAST(to_station_id AS STRING) AS to_station_id, 
    usertype,
    TIMESTAMP_DIFF(end_time, start_time, SECOND) AS ride_length,
    EXTRACT(DAYOFWEEK FROM start_time) AS day_of_week
FROM `Cyclistic_Bike_datasets.Divvy_Trips_2019_Q1`;

-- Table created with data type corrected and column name handled

-- checking for missing value
SELECT
    SUM(CASE WHEN trip_id IS NULL THEN 1 ELSE 0 END) AS missing_trip_id,
    SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END) AS missing_start_time,
    SUM(CASE WHEN end_time IS NULL THEN 1 ELSE 0 END) AS missing_end_time,
    SUM(CASE WHEN from_station_name IS NULL THEN 1 ELSE 0 END) AS missing_from_station_name,
    SUM(CASE WHEN from_station_id IS NULL THEN 1 ELSE 0 END) AS missing_from_station_id,
    SUM(CASE WHEN to_station_name IS NULL THEN 1 ELSE 0 END) AS missing_to_station_name,
    SUM(CASE WHEN to_station_id IS NULL THEN 1 ELSE 0 END) AS missing_to_station_id,
    SUM(CASE WHEN usertype IS NULL THEN 1 ELSE 0 END) AS missing_usertype
FROM corded-observer-401417.Cyclistic_Bike_datasets.combined_divvy_trips;
-- Found 1 missing value 

-- check for duplicates
SELECT trip_id, COUNT(*)
FROM combined_divvy_trips
GROUP BY trip_id
HAVING COUNT(*) > 1;
-- None

-- check start time and end time
SELECT trip_id
FROM combined_divvy_trips
WHERE start_time > end_time;
----50 trip_id duplicates, deleted

-- check for negative trip time
SELECT trip_id, ride_length
FROM combined_divvy_trips
WHERE ride_length < 0;
-- 50 entries found, deleted
