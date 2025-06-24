
-- Combining multiple data
--- Combining all the 12 months data tables into a single table containing data from Jan 2024 to Dec 2024

CREATE TABLE IF NOT EXISTS `coursera-461904.2024_Cyclistic.combined_data` AS (
  SELECT * FROM `coursera-461904.2024_Cyclistic.202401_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202402_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202403_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202404_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202405_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202406_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202407_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202408_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202409_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202410_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202411_trip`
  UNION ALL
  SELECT * FROM `coursera-461904.2024_Cyclistic.202412_trip`
);
