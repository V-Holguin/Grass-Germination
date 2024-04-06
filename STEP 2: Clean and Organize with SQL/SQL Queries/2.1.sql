CREATE TABLE day_night AS
SELECT 
    DATE(date_time) AS date,
    CASE 
        WHEN TIME(date_time) BETWEEN '00:00:00' AND '06:00:00' OR TIME(date_time) BETWEEN '19:00:00' AND '23:59:59' THEN 'Night'
        ELSE 'Day'
    END AS time_period,
    AVG(tmpf) AS avg_tmpf,
    AVG(dwpf) AS avg_dwpf,
    AVG(relh) AS avg_relh,
    AVG(wind_knt) AS avg_wind_knt,
    (SELECT sky FROM (
        SELECT sky, COUNT(*) AS count
        FROM weather
        WHERE DATE(date_time) = date AND 
            ((TIME(date_time) BETWEEN '00:00:00' AND '06:00:00' OR TIME(date_time) BETWEEN '19:00:00' AND '23:59:59' AND time_period = 'Night') OR
            (TIME(date_time) BETWEEN '06:00:01' AND '18:59:59' AND time_period = 'Day'))
        GROUP BY sky
        ORDER BY count DESC
        LIMIT 1
    ) AS subquery) AS most_common_sky
FROM 
    weather
GROUP BY 
    date,
    time_period;
