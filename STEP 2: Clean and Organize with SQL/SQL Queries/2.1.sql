-- Create a new table named 'day_night'
CREATE TABLE day_night AS
SELECT 
    -- Extract the date from the 'date_time' column
    DATE(date_time) AS date,
    -- Classify the time into 'Day' or 'Night' based on the time of 'date_time'
    CASE 
        WHEN TIME(date_time) BETWEEN '00:00:00' AND '06:00:00' OR TIME(date_time) BETWEEN '19:00:00' AND '23:59:59' THEN 'Night'
        ELSE 'Day'
    END AS time_period,
    -- Calculate the averages of the columns
    AVG(tmpf) AS avg_tmpf,
    AVG(dwpf) AS avg_dwpf,
    AVG(relh) AS avg_relh,
    AVG(wind_knt) AS avg_wind_knt,
    -- Subquery to find the most common sky condition for each 'date' and 'time_period'
    (SELECT sky FROM (
        SELECT sky, COUNT(*) AS count
        FROM weather
        WHERE DATE(date_time) = date AND 
            -- Match the 'date' and 'time_period' with the outer query
            ((TIME(date_time) BETWEEN '00:00:00' AND '06:00:00' OR TIME(date_time) BETWEEN '19:00:00' AND '23:59:59' AND time_period = 'Night') OR
            (TIME(date_time) BETWEEN '06:00:01' AND '18:59:59' AND time_period = 'Day'))
        -- Group by 'sky' to count the occurrences of each sky condition
        GROUP BY sky
        -- Order by the count in descending order to get the most common sky condition
        ORDER BY count DESC
        -- Limit to 1 to get only the most common sky condition
        LIMIT 1
    ) AS subquery) AS most_common_sky
FROM 
    weather
-- Group by 'date' and 'time_period' to get separate records for each date and time period
GROUP BY 
    date,
    time_period;
