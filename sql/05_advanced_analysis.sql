-- : Advanced machine_data analysis
SELECT *
 FROM machine_data;
 
-- 29. Find the top three machines with the highest failure rate, considering each machine's total readings.
   SELECT
    machine_id,
    COUNT(*) AS total_readings,
    SUM(failure_within_24h) AS failure_readings,
    ROUND(
        SUM(failure_within_24h) * 100.0 / COUNT(*),
        2
    ) AS failure_rate_percentage
FROM machine_data
GROUP BY machine_id
ORDER BY failure_rate_percentage DESC
LIMIT 3;

-- 30. Rank machine types by failure rate using a window function.
WITH machine_stats AS (
    SELECT
        machine_type,
        COUNT(*) AS total_readings,
        SUM(failure_within_24h) AS failure_readings,
        SUM(failure_within_24h) * 100.0 / COUNT(*) AS failure_rate
    FROM machine_data
    GROUP BY machine_type
)
SELECT
    machine_type,
    total_readings,
    failure_readings,
    ROUND(failure_rate, 2) AS failure_rate_percentage,
    RANK() OVER (ORDER BY failure_rate DESC) AS failure_rank
FROM machine_stats;

-- 31. Find the machine with the highest average temperature within each machine type.
WITH machine_stats AS (
    SELECT
        machine_type,
        machine_id,
        AVG(temperature_motor) AS avg_temperature
    FROM machine_data
    GROUP BY machine_type, machine_id
),
ranked_machines AS (
    SELECT
        machine_type,
        machine_id,
        avg_temperature,
        ROW_NUMBER() OVER (
            PARTITION BY machine_type
            ORDER BY avg_temperature DESC
        ) AS rn
    FROM machine_stats
)
SELECT
    machine_type,
    machine_id,
    ROUND(avg_temperature, 2) AS avg_temperature
FROM ranked_machines
WHERE rn = 1;

-- 32. Calculate daily failure readings using the timestamp column.
SELECT
    DATE(timestamp) AS failure_date,
    COUNT(*) AS failure_readings
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY DATE(timestamp)
ORDER BY failure_date;

-- 33. Calculate the seven-day moving average of failure readings.
WITH daily_failures AS (
    SELECT
        DATE(timestamp) AS failure_date,
        COUNT(*) AS failure_readings
    FROM machine_data
    WHERE failure_within_24h = 1
    GROUP BY DATE(timestamp)
)
SELECT
    failure_date,
    failure_readings,
    ROUND(
        AVG(failure_readings) OVER (
            ORDER BY failure_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS seven_day_moving_avg
FROM daily_failures
ORDER BY failure_date;

-- 34. Find machines where average vibration is above the overall average and failure readings are greater than zero.
SELECT
    machine_id,
    ROUND(AVG(vibration_rms), 3) AS avg_vibration,
    SUM(failure_within_24h) AS failure_readings
FROM machine_data
GROUP BY machine_id
HAVING AVG(vibration_rms) > (
    SELECT AVG(vibration_rms)
    FROM machine_data
)
AND SUM(failure_within_24h) > 0
ORDER BY avg_vibration DESC;

-- 35. Find the percentage contribution of each failure type to all failure readings.
SELECT
    failure_type,
    COUNT(*) AS failure_readings,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT COUNT(*)
            FROM machine_data
            WHERE failure_within_24h = 1
        ),
        2
    ) AS percentage_contribution
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY failure_type
ORDER BY percentage_contribution DESC;


-- 36. Compare average repair cost across operating modes.
SELECT
    operating_mode,
    COUNT(*) AS total_readings,
    ROUND(AVG(estimated_repair_cost), 2) AS avg_repair_cost
FROM machine_data
GROUP BY operating_mode
ORDER BY avg_repair_cost DESC;


-- 37. Find machine types with a failure rate greater than the overall failure rate.
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
HAVING
    SUM(failure_within_24h) * 1.0 / COUNT(*) > (
        SELECT AVG(failure_within_24h)
        FROM machine_data
    )
ORDER BY failure_rate_percentage DESC;

-- 38. Identify the top five machines by total estimated repair cost.
SELECT
    machine_id,
    ROUND(SUM(estimated_repair_cost), 2) AS total_estimated_repair_cost
FROM machine_data
GROUP BY machine_id
ORDER BY total_estimated_repair_cost DESC
LIMIT 5;

-- 39. Find machines with high average temperature, high average vibration, and at least one failure reading.
SELECT
    machine_id,
    ROUND(AVG(temperature_motor), 2) AS avg_temperature,
    ROUND(AVG(vibration_rms), 3) AS avg_vibration,
    SUM(failure_within_24h) AS failure_readings
FROM machine_data
GROUP BY machine_id
HAVING AVG(temperature_motor) > (
    SELECT AVG(temperature_motor)
    FROM machine_data
)
AND AVG(vibration_rms) > (
    SELECT AVG(vibration_rms)
    FROM machine_data
)
AND SUM(failure_within_24h) > 0
ORDER BY avg_temperature DESC, avg_vibration DESC;


-- 40. Create a summary showing machine type, total readings, failure readings, failure rate, average temperature, average vibration, and average RUL.
SELECT
    machine_type,
    COUNT(*) AS total_readings,
    SUM(failure_within_24h) AS failure_readings,
    ROUND(
        SUM(failure_within_24h) * 100.0 / COUNT(*),
        2
    ) AS failure_rate_percentage,
    ROUND(AVG(temperature_motor), 2) AS avg_temperature,
    ROUND(AVG(vibration_rms), 3) AS avg_vibration,
    ROUND(AVG(rul_hours), 2) AS avg_rul_hours
FROM machine_data
GROUP BY machine_type
ORDER BY failure_rate_percentage DESC;