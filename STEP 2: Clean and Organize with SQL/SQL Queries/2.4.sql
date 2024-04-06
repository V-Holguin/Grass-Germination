CREATE TABLE weather_data AS

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
LEFT JOIN day_summary_numerical
ON sky_data.day_of_year = day_summary_numerical.day_of_year
AND sky_data.time_period = day_summary_numerical.time_period

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

#############################################################################

ALTER TABLE weather_data
ADD COLUMN date_format DATE;

UPDATE weather_data
SET date_format = DATE_ADD('2020-01-01', INTERVAL day_of_year - 1 DAY);

ALTER TABLE weather_data
DROP COLUMN day_of_year;

ALTER TABLE weather_data
CHANGE date_format day_of_year DATE;

#############################################################################

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

DROP TABLE weather_data;

ALTER TABLE temp_name
RENAME TO weather_data;
