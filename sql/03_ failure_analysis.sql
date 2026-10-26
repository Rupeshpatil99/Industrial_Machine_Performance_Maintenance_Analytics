SELECT * FROM machine_data;


-- Level 2: Failure analysis
-- 9. Count the total readings where failure_within_24h = 1.
SELECT count(*)  
FROM machine_data 
WHERE failure_within_24h = 1;

-- 10. Calculate the overall failure rate as a percentage.
SELECT
    COUNT(*) AS total_readings,
    SUM(failure_within_24h) AS failure_readings,
    ROUND(
        SUM(failure_within_24h) * 100.0 / COUNT(*),
        2
    ) AS failure_rate_percentage
FROM machine_data;

-- 11. Calculate the failure rate for each machine type and sort from highest to lowest.
SELECT
    machine_type,
    COUNT(*) AS total_readings,
    SUM(failure_within_24h) AS failure_readings,
    ROUND(
        SUM(failure_within_24h) * 100.0 / COUNT(*),
        2
    ) AS failure_rate_percentage
FROM machine_data
GROUP BY machine_type
ORDER BY failure_rate_percentage DESC;

-- 12. Find the number of failure readings for each operating mode.
SELECT
    operating_mode,
    COUNT(*) AS total_failure_readings
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY operating_mode
ORDER BY total_failure_readings DESC;

-- 13. Find the distribution of records by failure_type.
SELECT
    failure_type,
    COUNT(*) AS total_records
FROM machine_data
GROUP BY failure_type
ORDER BY total_records DESC;


-- 14. Find the top 10 machines with the highest number of failure readings.
SELECT
    machine_id,
    COUNT(*) AS total_failure_readings
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY machine_id
ORDER BY total_failure_readings DESC
LIMIT 10;


-- 15. Count the failure readings for each machine type and failure type.
SELECT
    machine_type,
    failure_type,
    COUNT(*) AS total_failure_readings
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY machine_type, failure_type
ORDER BY machine_type, total_failure_readings DESC;

-- 16. Compare failure and non-failure readings by average motor temperature.
SELECT
    failure_within_24h,
    CASE
        WHEN failure_within_24h = 1 THEN 'Failure'
        ELSE 'Non-Failure'
    END AS reading_status,
    ROUND(AVG(temperature_motor), 2) AS avg_motor_temperature
FROM machine_data
GROUP BY failure_within_24h;


-- 17. Compare failure and non-failure readings by average vibration.
SELECT
    failure_within_24h,
    CASE
        WHEN failure_within_24h = 1 THEN 'Failure'
        ELSE 'Non-Failure'
    END AS reading_status,
    ROUND(AVG(vibration_rms), 3) AS avg_vibration
FROM machine_data
GROUP BY failure_within_24h;

-- 18. Find the percentage of failure readings for each machine type relative to all failure readings.
SELECT
    machine_type,
    COUNT(*) AS failure_readings,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM machine_data
         WHERE failure_within_24h = 1),
        2
    ) AS percentage_of_all_failures
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY machine_type
ORDER BY percentage_of_all_failures DESC;