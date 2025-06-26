-- A. descriptive analysis

---- 1. Calculate the mean of ride_length 
SELECT ROUND(AVG(ride_length), 2)                  --- Avg ride_length: 16.77 minutes
FROM `coursera-461904`.`2024_Cyclistic`.`cleaned_combined_data`; 
                                                
---- 2. Calculate the max ride_length 
SELECT ROUND(MAX(ride_length),2)                  --- max ride_length : 1439.83 minutes = 23 hours 59 minutes
FROM `coursera-461904`.`2024_Cyclistic`.`cleaned_combined_data`;

---- 3. Calculate the mode of day_of_week
SELECT day_of_week, COUNT(*) AS frequency         --- mode of day_of_week : Saturday with 643749, then Wednesday. And then,Friday.
FROM `coursera-461904`.`2024_Cyclistic`.`cleaned_combined_data`
GROUP BY day_of_week
ORDER BY frequency DESC
LIMIT 3;

---- 4. Calculate the mode of rideable_type 
SELECT rideable_type, COUNT(*) AS frequency   --- mode of rideable_type : classic_bike with 2714476. Then, electric_bike. And then, electric_scooter
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY rideable_type
ORDER BY frequency DESC;

-- B. Data Analysis

---- 1. calculate total trips of each rider with the %
SELECT
  member_casual,
  COUNT(*) AS total_trips,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total_trips
FROM
  `coursera-461904`.`2024_Cyclistic`.`cleaned_combined_data`
GROUP BY
  member_casual
ORDER BY
  total_trips DESC;  

---- 2. bikes types used by each type of riders (member & casual)
SELECT member_casual, rideable_type, COUNT(*) AS total_trips
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips DESC;

-- 3. total trips of each riders per month
SELECT month, member_casual, COUNT(ride_id) AS total_trips
FROM `coursera-461904`.`2024_Cyclistic`.`cleaned_combined_data`
GROUP BY month, member_casual
ORDER BY 
CASE month
    WHEN 'JAN' THEN 1
    WHEN 'FEB' THEN 2
    WHEN 'MAR' THEN 3
    WHEN 'APR' THEN 4
    WHEN 'MAY' THEN 5
    WHEN 'JUN' THEN 6
    WHEN 'JUL' THEN 7
    WHEN 'AUG' THEN 8
    WHEN 'SEP' THEN 9
    WHEN 'OCT' THEN 10
    WHEN 'NOV' THEN 11
    WHEN 'DEC' THEN 12
  END ASC,
  total_trips DESC;

---- 4. total trips of each riders per day of week
SELECT
    member_casual,
    day_of_week,
    COUNT(ride_id) AS total_trips
FROM
    `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY
    member_casual,
    day_of_week
ORDER BY
    member_casual,
    CASE day_of_week
        WHEN 'MON' THEN 1
        WHEN 'TUES' THEN 2
        WHEN 'WED' THEN 3
        WHEN 'THURS' THEN 4
        WHEN 'FRI' THEN 5
        WHEN 'SAT' THEN 6
        WHEN 'SUN' THEN 7
    END ASC;


-- 5. total trips of each rider per hour
SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, COUNT(ride_id) AS total_trips
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data` 
GROUP BY hour_of_day, member_casual
ORDER BY member_casual, hour_of_day;

-- 6. average ride_length per month
SELECT member_casual, month, ROUND(AVG(ride_length),2) AS avg_ride_duration
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY month, member_casual
ORDER BY 
member_casual, 
CASE month
    WHEN 'JAN' THEN 1
    WHEN 'FEB' THEN 2
    WHEN 'MAR' THEN 3
    WHEN 'APR' THEN 4
    WHEN 'MAY' THEN 5
    WHEN 'JUN' THEN 6
    WHEN 'JUL' THEN 7
    WHEN 'AUG' THEN 8
    WHEN 'SEP' THEN 9
    WHEN 'OCT' THEN 10
    WHEN 'NOV' THEN 11
    WHEN 'DEC' THEN 12
  END ASC;

-- average ride_length per day of week
SELECT member_casual, day_of_week, ROUND(AVG(ride_length),2) AS avg_ride_duration
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY day_of_week, member_casual
ORDER BY
    member_casual,
    CASE day_of_week
        WHEN 'MON' THEN 1
        WHEN 'TUES' THEN 2
        WHEN 'WED' THEN 3
        WHEN 'THURS' THEN 4
        WHEN 'FRI' THEN 5
        WHEN 'SAT' THEN 6
        WHEN 'SUN' THEN 7
    END ASC;

-- average ride_length per hour
SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, ROUND(AVG(ride_length),2) AS avg_ride_duration
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY hour_of_day, member_casual
ORDER BY member_casual, hour_of_day;

-- starting station locations
SELECT start_station_name, member_casual,
  AVG(start_lat) AS start_lat, AVG(start_lng) AS start_lng,
  COUNT(ride_id) AS total_trips
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY start_station_name, member_casual;

-- ending station locations

SELECT end_station_name, member_casual,
  AVG(end_lat) AS end_lat, AVG(end_lng) AS end_lng,
  COUNT(ride_id) AS total_trips
FROM `coursera-461904.2024_Cyclistic.cleaned_combined_data`
GROUP BY end_station_name, member_casual;
