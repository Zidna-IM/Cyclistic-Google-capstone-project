
-- checking the data types of all columns

SELECT
    column_name,
    data_type
FROM
    `coursera-461904.2024_Cyclistic.INFORMATION_SCHEMA.COLUMNS`
WHERE
    table_name = 'combined_data';

-- checking for number of null values in all columns

SELECT
  COUNTIF(ride_id IS NULL) AS null_ride_id,
  COUNTIF(rideable_type IS NULL) AS null_rideable_type,
  COUNTIF(started_at IS NULL) AS null_started_at,
  COUNTIF(ended_at IS NULL) AS null_ended_at,
  COUNTIF(start_station_name IS NULL) AS null_start_station_name,
  COUNTIF(start_station_id IS NULL) AS null_start_station_id,
  COUNTIF(end_station_name IS NULL) AS null_end_station_name,
  COUNTIF(end_station_id IS NULL) AS null_end_station_id,
  COUNTIF(start_lat IS NULL) AS null_start_lat,
  COUNTIF(start_lng IS NULL) AS null_start_lng,
  COUNTIF(end_lat IS NULL) AS null_end_lat,
  COUNTIF(end_lng IS NULL) AS null_end_lng,
  COUNTIF(member_casual IS NULL) AS null_member_casual
FROM
  `coursera-461904.2024_Cyclistic.combined_data`;


-- checking for duplicate rows in ride_id

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM `coursera-461904.2024_Cyclistic.combined_data`;


-- check length of ride_id --> all rows have length of 16

----- First, checking no of rows which are 5860568 
SELECT COUNT(*)
FROM `coursera-461904.2024_Cyclistic.combined_data`;

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM `coursera-461904.2024_Cyclistic.combined_data`
GROUP BY length_ride_id;


-- Identify rideable_type ---> 3 unique types of bikes

SELECT DISTINCT rideable_type, COUNT(rideable_type) AS total_trips
FROM `coursera-461904.2024_Cyclistic.combined_data`
GROUP BY rideable_type;

--MANAGE started_at & ended_at  

----Check DATETIME format --> YYYY-MM-DD hh:mm:ss UTC
SELECT started_at, ended_at
FROM `coursera-461904.2024_Cyclistic.combined_data`
LIMIT 10;

----Group data by the duration: longer_than_a_day & less_than_a_minute
SELECT COUNT(*) AS longer_than_a_day
FROM `coursera-461904.2024_Cyclistic.combined_data`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) >= 1440;   -- longer than a day = 7596 rows

SELECT COUNT(*) AS less_than_a_minute
FROM `coursera-461904.2024_Cyclistic.combined_data`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) <= 1;      -- less than a minute = 132644 rows

-- identify rows with missing start station name and id  
----> total 1073951 rows with both start station name & id missing

SELECT DISTINCT start_station_name
FROM `coursera-461904.2024_Cyclistic.combined_data`
ORDER BY start_station_name;

SELECT COUNT(ride_id) AS null_start_station          -- return 1073951 rows
FROM `coursera-461904.2024_Cyclistic.combined_data`
WHERE start_station_name IS NULL OR start_station_id IS NULL;

-- identify rows with missing end_station_name, end_station_id 
----> total 1104653 rows with both end station name and id missing

SELECT DISTINCT end_station_name
FROM `coursera-461904.2024_Cyclistic.combined_data`
ORDER BY end_station_name;

SELECT COUNT(ride_id) AS null_end_station          -- return 1104653 rows
FROM `coursera-461904.2024_Cyclistic.combined_data`
WHERE end_station_name IS NULL OR end_station_id IS NULL;

-- identify rows with missing end_lat, end_lng 
---> total 5858 rows with both missing

SELECT COUNT(ride_id) AS rows_with_null_end_loc
FROM `coursera-461904.2024_Cyclistic.combined_data`
WHERE end_lat IS NULL OR end_lng IS NULL;

-- Calculate each type of member riders 
----> Return: 2151658 member and 3708910 casual riders

SELECT DISTINCT member_casual, COUNT(member_casual) AS no_of_trips
FROM `coursera-461904.2024_Cyclistic.combined_data` 
GROUP BY member_casual;
