-- Create a new table named 'day_summary_numerical'
CREATE TABLE day_summary_numerical AS
SELECT 
    -- Extract the day of the year from the 'date' column
    DAYOFYEAR(date) AS day_of_year,
    -- Include the 'time_period' column
    time_period,
    -- Calculate the maximum, minimum, and average of my old columns to create new ones
    MAX(avg_tmpf) AS max_tmpf,
    MIN(avg_tmpf) AS min_tmpf,
    AVG(avg_tmpf) AS avg_tmpf,

    MAX(avg_dwpf) AS max_dwpf,
    MIN(avg_dwpf) AS min_dwpf,
    AVG(avg_dwpf) AS avg_dwpf,

    MAX(avg_relh) AS max_relh,
    MIN(avg_relh) AS min_relh,
    AVG(avg_relh) AS avg_relh,

    MAX(avg_wind_knt) AS max_wind_knt,
    MIN(avg_wind_knt) AS min_wind_knt,
    AVG(avg_wind_knt) AS avg_wind_knt
FROM 
    day_night
-- Group by 'day_of_year' and 'time_period' to get separate records for each day of the year and time period
GROUP BY 
    day_of_year, time_period;
