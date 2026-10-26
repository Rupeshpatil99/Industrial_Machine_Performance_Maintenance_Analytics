SELECT * FROM MACHINE_DATA;


-- Level 3: Sensor and maintenance analysis

-- 19. Find machines whose average motor temperature is above the overall average motor temperature.
SELECT
    machine_id,
    ROUND(AVG(temperature_motor), 2) AS avg_motor_temperature
FROM machine_data
GROUP BY machine_id
HAVING AVG(temperature_motor) > (
    SELECT AVG(temperature_motor)
    FROM machine_data
)
ORDER BY avg_motor_temperature DESC;

-- 20. Find machines whose average vibration exceeds the overall average vibration.
SELECT
     machine_type,
     ROUND(AVG(vibration_rms),2) AS  avg_vibration_rms
FROM machine_data
GROUP BY machine_type
HAVING AVG(vibration_rms) > (
	SELECT AVG (vibration_rms)
    FROM machine_data
)
ORDER BY avg_vibration_rms DESC;


-- 21. Find records where motor temperature is above 80.

SELECT *
 FROM machine_data
WHERE  temperature_motor > 80;


-- 22. Find records where vibration is above 5.

SELECT * 
FROM  machine_data
WHERE vibration_rms <5;

-- 23. Calculate the average hours_since_maintenance for failure and non-failure readings.
SELECT
    failure_within_24h,
    CASE
        WHEN failure_within_24h = 1 THEN 'Failure'
        ELSE 'Non-Failure'
    END AS reading_status, 
    COUNT(*) AS total_readings,
ROUND(AVG(hours_since_maintenance),2) AS avg_hours_maintenance
FROM machine_data
GROUP BY  failure_within_24h;

-- 24. Find the machine type with the highest average hours_since_maintenance.
SELECT 
     machine_type,
	 ROUND(AVG(hours_since_maintenance),2) AS avg_hr_maintences
 FROM machine_data
GROUP BY machine_type
ORDER BY avg_hr_maintences DESC;

-- 25. Compare average RUL (rul_hours) between failure and non-failure readings.
SELECT
    CASE
        WHEN failure_within_24h = 1 THEN 'Failure'
        ELSE 'Non-Failure'
    END AS reading_status,
    COUNT(*) AS total_readings,
    ROUND(AVG(rul_hours), 2) AS avg_rul_hours
FROM machine_data
GROUP BY failure_within_24h;


-- 26. Find machines with an average RUL below 100 hours.
SELECT
    machine_id,
    ROUND(AVG(rul_hours), 2) AS avg_rul_hours
FROM machine_data
GROUP BY machine_id
HAVING AVG(rul_hours) < 100
ORDER BY avg_rul_hours ASC;

-- 27. Calculate the average estimated repair cost for each failure type.
SELECT
    failure_type,
    COUNT(*) AS total_readings,
    ROUND(AVG(estimated_repair_cost), 2) AS avg_estimated_repair_cost
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY failure_type
ORDER BY avg_estimated_repair_cost DESC;


-- 28. Find the top five most expensive failure types based on average estimated repair cost.
SELECT
    failure_type,
    COUNT(*) AS total_readings,
    ROUND(AVG(estimated_repair_cost), 2) AS avg_estimated_repair_cost
FROM machine_data
WHERE failure_within_24h = 1
GROUP BY failure_type
ORDER BY avg_estimated_repair_cost DESC
LIMIT 5;