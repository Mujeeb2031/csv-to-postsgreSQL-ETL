select * from electricvehicles;

WITH sorted_electric_range AS (
    -- Best to worst make, model by electric_range
    SELECT make, model, electric_range
    FROM electricvehicles
    GROUP BY make, model, electric_range
    HAVING electric_range > 0
    ORDER BY electric_range DESC
),
make_summary AS (
    -- Make, model range statistics
    SELECT make,
           COUNT(*) AS number_of_electric_vehicles,
           MAX(electric_range) AS max_range,
           MIN(electric_range) AS min_range,
           AVG(electric_range) AS avg_range
    FROM sorted_electric_range
    GROUP BY make
),
top_10_makes AS (
    -- Top 10 makes by maximum electric range
    SELECT make, max_range, min_range, avg_range
    FROM make_summary
    ORDER BY max_range DESC
    LIMIT 10
),
bottom_10_makes AS (
    -- Bottom 10 makes by maximum electric range
    SELECT make, max_range, min_range, avg_range
    FROM make_summary
    ORDER BY max_range ASC
    LIMIT 10
),
overall_avg_range AS (
    -- Overall average electric range
    SELECT AVG(electric_range) AS overall_avg
    FROM sorted_electric_range
),
top_10_makes_above_overall_average AS (
    -- Top 10 makes electric_range above overall average
    SELECT ms.make, ms.max_range, ms.min_range, oar.overall_avg AS avg_range
    FROM make_summary ms
    CROSS JOIN overall_avg_range oar
    WHERE ms.max_range > oar.overall_avg
    ORDER BY ms.max_range DESC
    LIMIT 10
),
top_10_makes_below_overall_average AS (
    -- Top 10 makes electric_range below overall average
    SELECT ms.make, ms.max_range, ms.min_range, oar.overall_avg AS avg_range
    FROM make_summary ms
    CROSS JOIN overall_avg_range oar
    WHERE ms.max_range < oar.overall_avg
    ORDER BY ms.max_range DESC
    LIMIT 10
)
-- Final combined output
SELECT 'Make Summary' AS section, make, number_of_electric_vehicles, max_range, min_range, avg_range
FROM make_summary

UNION ALL

SELECT 'Top 10 Makes' AS section, make, NULL, max_range, min_range, avg_range
FROM top_10_makes

UNION ALL

SELECT 'Bottom 10 Makes' AS section, make, NULL, max_range, min_range, avg_range
FROM bottom_10_makes

UNION ALL

SELECT 'Top 10 Makes Above Average' AS section, make, NULL, max_range, min_range, avg_range
FROM top_10_makes_above_overall_average

UNION ALL

SELECT 'Top 10 Makes Below Average' AS section, make, NULL, max_range, min_range, avg_range
FROM top_10_makes_below_overall_average

UNION ALL

SELECT 'Overall Average' AS section, NULL, NULL, NULL, NULL, overall_avg
FROM overall_avg_range;
