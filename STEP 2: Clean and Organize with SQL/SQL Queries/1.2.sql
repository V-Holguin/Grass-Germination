ALTER TABLE weather
RENAME COLUMN valid TO date_time,
RENAME COLUMN sknt TO wind_knt,
RENAME COLUMN wxcodes TO sky;
