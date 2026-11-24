
-- =====================================================
-- CARELOOP CLINICS - PART 2: SQL ANALYSIS
-- =====================================================

-- 1. Create and select database
CREATE DATABASE IF NOT EXISTS careloop_clinics;

USE careloop_clinics;


-- 2. Check total records in both tables
SELECT COUNT(*) AS total_appointments
FROM appointments;

SELECT COUNT(*) AS total_clinics
FROM clinics;


-- 3. No-show percentage by clinic
SELECT
    c.clinic_id,
    c.clinic_name,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE
        WHEN LOWER(TRIM(a.status)) = 'no-show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(a.status)) = 'no-show' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(a.appointment_id), 0),
        2
    ) AS no_show_percentage
FROM clinics c
LEFT JOIN appointments a
    ON c.clinic_id = a.clinic_id
GROUP BY c.clinic_id, c.clinic_name
ORDER BY no_show_percentage DESC;


-- 4. Monthly no-show trends
SELECT
    DATE_FORMAT(appt_date, '%Y-%m') AS appointment_month,
    COUNT(*) AS total_appointments,
    SUM(
        CASE
            WHEN LOWER(TRIM(status)) = 'no-show' THEN 1
            ELSE 0
        END
    ) AS no_show_count,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(status)) = 'no-show' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS no_show_percentage
FROM appointments
GROUP BY DATE_FORMAT(appt_date, '%Y-%m')
ORDER BY appointment_month;


-- 5. Booking lead-time analysis
SELECT
    CASE
        WHEN DATEDIFF(appt_date, booked_on) BETWEEN 0 AND 3
            THEN '0-3 days'
        WHEN DATEDIFF(appt_date, booked_on) BETWEEN 4 AND 7
            THEN '4-7 days'
        WHEN DATEDIFF(appt_date, booked_on) BETWEEN 8 AND 14
            THEN '8-14 days'
        WHEN DATEDIFF(appt_date, booked_on) > 14
            THEN 'Above 14 days'
        ELSE 'Invalid lead time'
    END AS lead_time_group,

    COUNT(*) AS total_appointments,

    SUM(
        CASE
            WHEN LOWER(TRIM(status)) = 'no-show' THEN 1
            ELSE 0
        END
    ) AS no_show_count,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(status)) = 'no-show' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS no_show_percentage

FROM appointments
GROUP BY lead_time_group
ORDER BY
    CASE lead_time_group
        WHEN '0-3 days' THEN 1
        WHEN '4-7 days' THEN 2
        WHEN '8-14 days' THEN 3
        WHEN 'Above 14 days' THEN 4
        ELSE 5
    END;


-- 6. Rank clinics within each city
SELECT
    clinic_id,
    clinic_name,
    city,
    total_appointments,
    no_show_count,
    no_show_percentage,
    RANK() OVER (
        PARTITION BY city
        ORDER BY no_show_percentage DESC
    ) AS clinic_rank
FROM (
    SELECT
        c.clinic_id,
        c.clinic_name,
        c.city,
        COUNT(a.appointment_id) AS total_appointments,
        SUM(
            CASE
                WHEN LOWER(TRIM(a.status)) = 'no-show' THEN 1
                ELSE 0
            END
        ) AS no_show_count,
        ROUND(
            100.0 * SUM(
                CASE
                    WHEN LOWER(TRIM(a.status)) = 'no-show' THEN 1
                    ELSE 0
                END
            ) / NULLIF(COUNT(a.appointment_id), 0),
            2
        ) AS no_show_percentage
    FROM clinics c
    LEFT JOIN appointments a
        ON c.clinic_id = a.clinic_id
    GROUP BY c.clinic_id, c.clinic_name, c.city
) AS clinic_summary
ORDER BY city, clinic_rank;


-- 7. Overall appointment summary
SELECT
    COUNT(*) AS total_appointments,
    SUM(
        CASE
            WHEN LOWER(TRIM(status)) = 'no-show' THEN 1
            ELSE 0
        END
    ) AS total_no_shows,
    SUM(
        CASE
            WHEN LOWER(TRIM(status)) = 'attended' THEN 1
            ELSE 0
        END
    ) AS total_attended,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(status)) = 'no-show' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS overall_no_show_percentage
FROM appointments;


-- =====================================================
-- END OF CARELOOP CLINICS SQL ANALYSIS
-- =====================================================

-- Note: If a duplicate-key error occurred during data
-- loading, record the actual error message here as a comment.
