-- Total number of rows in each table
SELECT COUNT(*) AS total_rows_202004 FROM divvy_202004;
SELECT COUNT(*) AS total_rows_202104 FROM divvy_202104;

-- Distinct values in member_casual
SELECT DISTINCT member_casual FROM divvy_202004;
SELECT DISTINCT member_casual FROM divvy_202104;

-- Maximum, minimum, and mean ride duration (assuming started_at and ended_at are timestamps)
SELECT 
    MAX(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS max_duration_minutes,
    MIN(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS min_duration_minutes,
    AVG(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS avg_duration_minutes
FROM divvy_202004;

SELECT 
    MAX(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS max_duration_minutes,
    MIN(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS min_duration_minutes,
    AVG(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS avg_duration_minutes
FROM divvy_202104;

-- Combine tables for analysis
CREATE TABLE combined_divvy AS
SELECT * FROM divvy_202004
UNION ALL
SELECT * FROM divvy_202104;

-- Summary statistics for combined data
SELECT 
    member_casual,
    COUNT(*) AS total_rides,
    AVG(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS avg_duration_minutes,
    MIN(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS min_duration_minutes,
    MAX(JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 AS max_duration_minutes
FROM combined_divvy
GROUP BY member_casual;

-- Find the top 5 start stations by number of rides
CREATE TABLE top_start_stations AS
SELECT 
    start_station_name,
    COUNT(*) AS ride_count
FROM combined_divvy
GROUP BY start_station_name
ORDER BY ride_count DESC
LIMIT 5;

-- View the saved table
SELECT * FROM top_start_stations;
