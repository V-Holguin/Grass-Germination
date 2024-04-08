-- Create a new table 'sky_counts' with counts of each sky condition
CREATE TABLE sky_counts AS
SELECT 
    -- Extract the day of the year from the 'date' column
    DAYOFYEAR(date) as day_of_year,
    -- Include the 'time_period' column
    time_period,
    -- Count the occurrences of each sky condition
    SUM(most_common_sky = 'clear') as clear,
    SUM(most_common_sky = 'shaded') as shaded,
    SUM(most_common_sky = 'lt_precip') as lt_precip,
    SUM(most_common_sky = 'med_precip') as med_precip,
    SUM(most_common_sky = 'hvy_precip') as hvy_precip
FROM 
    day_night
-- Group by 'day_of_year' and 'time_period' to get separate records for each day of the year and time period
GROUP BY 
    day_of_year, 
    time_period;

----------------------------------------------------------------------------------------------------------------------------

-- Create a new table 'sky_data' with the most and least frequent sky conditions
CREATE TABLE sky_data AS
SELECT 
    -- Include the 'day_of_year' and 'time_period' columns
    day_of_year,
    time_period,
    -- Determine the most frequent sky condition
    CASE
        WHEN clear = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'clear'
        WHEN shaded = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'shaded'
        WHEN lt_precip = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'lt_precip'
        WHEN med_precip = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'med_precip'
        WHEN hvy_precip = GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) THEN 'hvy_precip'
    END AS most_frequent_sky,
    -- Get the count of the most frequent sky condition
    GREATEST(clear, shaded, lt_precip, med_precip, hvy_precip) AS cnt_mfs,
    -- Subquery to find the least frequent sky condition
    (
        SELECT sky
        FROM (
            -- Create a union of all sky conditions and their counts
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
        -- Filter out sky conditions with a count of 0
        WHERE count > 0
        -- Order by count in ascending order and sky in ascending order to get the least frequent sky condition
        ORDER BY count ASC, sky ASC
        -- Limit to 1 to get only the least frequent sky condition
        LIMIT 1
    ) AS least_frequent_sky,
    -- Subquery to find the count of the least frequent sky condition
    (
        SELECT count
        FROM (
            -- Create a union of all counts
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
        -- Filter out counts of 0
        WHERE count > 0
        -- Order by count in ascending order to get the smallest count
        ORDER BY count ASC
        -- Limit to 1 to get only the smallest count
        LIMIT 1
    ) AS cnt_lfs
FROM 
    sky_counts;

----------------------------------------------------------------------------------------------------------------------------

-- Update the 'least_frequent_sky' column in the 'sky_data' table
UPDATE sky_data
SET least_frequent_sky = CASE WHEN cnt_mfs = cnt_lfs THEN 'none' ELSE least_frequent_sky END;

----------------------------------------------------------------------------------------------------------------------------

-- Drop the 'cnt_mfs' and 'cnt_lfs' columns from the 'sky_data' table
ALTER TABLE sky_data
DROP COLUMN cnt_mfs,
DROP COLUMN cnt_lfs;
