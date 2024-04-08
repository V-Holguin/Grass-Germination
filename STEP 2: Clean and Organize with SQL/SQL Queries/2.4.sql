-- Create a new table 'weather_data' by joining 'sky_data' and 'day_summary_numerical'
CREATE TABLE weather_data AS
SELECT 
    -- Include the 'day_of_year' and 'time_period' columns from 'sky_data'
    sky_data.day_of_year, 
    sky_data.time_period, 
    -- Include the 'most_frequent_sky' and 'least_frequent_sky' columns from 'sky_data'
    sky_data.most_frequent_sky, 
    sky_data.least_frequent_sky,
    -- Include the weather summary columns from 'day_summary_numerical'
    day_summary_numerical.max_tmpf, 
    day_summary_numerical.min_tmpf, 
    day_summary_numerical.avg_tmpf, 
    day_summary_numerical.max_dwpf, 
    day_summary_numerical.min_dwpf, 
    day_summary_numerical.avg_dwpf, 
    day_summary_numerical.max_relh, 
    day_summary_numerical.min_relh, 
    day_summary_numerical.avg_relh, 
    day_summary_numerical.max_wind_knt, 
    day_summary_numerical.min_wind_knt, 
    day_summary_numerical.avg_wind_knt
FROM sky_data
-- Join 'sky_data' and 'day_summary_numerical' on 'day_of_year' and 'time_period'
LEFT JOIN day_summary_numerical
ON sky_data.day_of_year = day_summary_numerical.day_of_year
AND sky_data.time_period = day_summary_numerical.time_period
-- Union with the right join of 'sky_data' and 'day_summary_numerical' to include all records from both tables
UNION
SELECT 
    sky_data.day_of_year, 
    sky_data.time_period, 
    sky_data.most_frequent_sky, 
    sky_data.least_frequent_sky,
    day_summary_numerical.max_tmpf, 
    day_summary_numerical.min_tmpf, 
    day_summary_numerical.avg_tmpf, 
    day_summary_numerical.max_dwpf, 
    day_summary_numerical.min_dwpf, 
    day_summary_numerical.avg_dwpf, 
    day_summary_numerical.max_relh, 
    day_summary_numerical.min_relh, 
    day_summary_numerical.avg_relh, 
    day_summary_numerical.max_wind_knt, 
    day_summary_numerical.min_wind_knt, 
    day_summary_numerical.avg_wind_knt
FROM sky_data
RIGHT JOIN day_summary_numerical
ON sky_data.day_of_year = day_summary_numerical.day_of_year
AND sky_data.time_period = day_summary_numerical.time_period;

-------------------------------------------------------------------------------------------------

-- Add a new column 'date_format' to the 'weather_data' table
ALTER TABLE weather_data
ADD COLUMN date_format DATE;

-- Update the 'date_format' column with the date corresponding to the 'day_of_year'
UPDATE weather_data
SET date_format = DATE_ADD('2020-01-01', INTERVAL day_of_year - 1 DAY);

-- Drop the 'day_of_year' column from the 'weather_data' table
ALTER TABLE weather_data
DROP COLUMN day_of_year;

-- Rename the 'date_format' column to 'day_of_year'
ALTER TABLE weather_data
CHANGE date_format day_of_year DATE;

-------------------------------------------------------------------------------------------------

-- Create a new table 'temp_name' with the same structure as 'weather_data'
CREATE TABLE temp_name AS
SELECT day_of_year,
	time_period,
    max_tmpf,
    min_tmpf,
    avg_tmpf,
    max_dwpf,
    min_dwpf,
    avg_dwpf,
    max_relh,
    min_relh,
    avg_relh,
    max_wind_knt,
    min_wind_knt,
    avg_wind_knt,
    most_frequent_sky,
    least_frequent_sky
FROM weather_data;

-- Drop the 'weather_data' table
DROP TABLE weather_data;

-- Rename the 'temp_name' table to 'weather_data'
ALTER TABLE temp_name
RENAME TO weather_data;
