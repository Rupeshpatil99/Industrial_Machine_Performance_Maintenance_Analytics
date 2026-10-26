USE industrial_predictive_maintenance;

CREATE TABLE IF NOT EXISTS machine_data (
                            timestamp DATETIME,
    machine_id              INT,
    machine_type            VARCHAR(50),
    vibration_rms           DECIMAL(10,3),
    temperature_motor       DECIMAL(10,3),
    current_phase_avg       DECIMAL(10,3),
    pressure_level          DECIMAL(10,3),
    rpm                     DECIMAL(10,2),
    operating_mode          VARCHAR(50),
    hours_since_maintenance DECIMAL(10,2),
    ambient_temp            DECIMAL(10,3),
    rul_hours               DECIMAL(10,2),
    failure_within_24h      INT,
    failure_type            VARCHAR(50),
    estimated_repair_cost   DECIMAL(12,2)
);

DESCRIBE machine_data;

