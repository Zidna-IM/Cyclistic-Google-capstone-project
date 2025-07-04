-- creating new table with clean data
 
CREATE TABLE IF NOT EXISTS `coursera-461904.2024_Cyclistic.cleaned_combined_data` AS (
  SELECT 
    n.ride_id, rideable_type, started_at, ended_at, 
    ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at) --- Extract & convert day & month 
      WHEN 1 THEN 'SUN'                      ---- Then, add day_of_week & month as a new collumn
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
  FROM `coursera-461904.2024_Cyclistic.combined_data` p   --- Create new collumn: ride_length
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_length
    FROM `coursera-461904.2024_Cyclistic.combined_data`
  ) n 
  ON p.ride_id = n.ride_id
  WHERE                                 --- Filtering the Data
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 1 AND ride_length < 1440
);

ALTER TABLE `coursera-461904.2024_Cyclistic.cleaned_combined_data`     -- set ride_id as primary key
ADD PRIMARY KEY(ride_id) NOT ENFORCED;

-- Verifying the Row Count
SELECT COUNT(ride_id) AS total_rows       -- returned 4,168,157 rows, so 1.692.411 rows removed
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data` ;
