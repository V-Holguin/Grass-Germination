SELECT * FROM weather
WHERE time_date IS NULL
	OR tmpf IS NULL
    OR dwpf IS NULL
    OR relh IS NULL
    OR wind_knt IS NULL
    OR sky IS NULL;

SELECT tmpf
FROM weather
WHERE tmpf REGEXP '[^0-9.]';

DELETE FROM weather
WHERE tmpf = 'M' OR dwpf = 'M' OR relh = 'M' OR wind_knt = 'M';

ALTER TABLE weather
MODIFY COLUMN date_time DATETIME;

ALTER TABLE weather
MODIFY COLUMN tmpf DECIMAL(5,2);

ALTER TABLE weather
MODIFY COLUMN dwpf DECIMAL(5,2);

ALTER TABLE weather
MODIFY COLUMN relh DECIMAL(5,2);

ALTER TABLE weather
MODIFY COLUMN wind_knt DECIMAL(5,2);
