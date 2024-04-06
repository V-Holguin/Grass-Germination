CREATE TABLE sky_counts AS
SELECT 
    DAYOFYEAR(date) as day_of_year,
    time_period,
    SUM(most_common_sky = 'clear') as clear,
    SUM(most_common_sky = 'shaded') as shaded,
    SUM(most_common_sky = 'lt_precip') as lt_precip,
    SUM(most_common_sky = 'med_precip') as med_precip,
    SUM(most_common_sky = 'hvy_precip') as hvy_precip
FROM 
    day_night
GROUP BY 
    day_of_year, 
    time_period;

################################################################################

CREATE TABLE sky_data AS
SELECT 
    day_of_year,
    time_period,
    CASE
        WHEN clear = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'clear'
        WHEN shaded = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'shaded'
        WHEN lt_precip = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'lt_precip'
        WHEN med_precip = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'med_precip'
        WHEN hvy_precip = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'hvy_precip'
    END AS most_frequent_sky,
    GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) AS cnt_mfs,
    (
        SELECT sky
        FROM (
            SELECT 'clear' AS sky, clear AS count
            UNION ALL
            SELECT 'shaded', shaded
            UNION ALL
            SELECT 'lt_precip', lt_precip
            UNION ALL
            SELECT 'med_precip', med_precip
            UNION ALL
            SELECT 'hvy_precip', hvy_precip
        ) AS subquery
        WHERE count > 0
        ORDER BY count ASC, sky ASC
        LIMIT 1
    ) AS least_frequent_sky,
    (
        SELECT count
        FROM (
            SELECT clear AS count
            UNION ALL
            SELECT shaded
            UNION ALL
            SELECT lt_precip
            UNION ALL
            SELECT med_precip
            UNION ALL
            SELECT hvy_precip
        ) AS subquery
        WHERE count > 0
        ORDER BY count ASC
        LIMIT 1
    ) AS cnt_lfs
FROM 
    sky_counts;

################################################################################

UPDATE sky_data
SET least_frequent_sky = CASE WHEN cnt_mfs = cnt_lfs THEN 'none' ELSE least_frequent_sky END;

################################################################################

ALTER TABLE sky_data
DROP COLUMN cnt_mfs,
DROP COLUMN cnt_lfs;

