-- Retail Store Sales: final Item recovery
-- BigQuery Standard SQL
--
-- BigQuery Sandbox does not allow DML statements such as UPDATE.
-- This query rebuilds the final table and recovers only Item values that have
-- a unique Category + Price Per Unit mapping in the cleaned dataset.

CREATE OR REPLACE TABLE
    `first-project-506607.retail_store_salses_1.retail_store_sales_final_v2`
AS

WITH item_reference AS (
    SELECT
        `Category`,
        `Price Per Unit`,
        ARRAY_AGG(
            DISTINCT TRIM(`Item`)
            IGNORE NULLS
            ORDER BY TRIM(`Item`)
            LIMIT 1
        )[SAFE_OFFSET(0)] AS recovered_item
    FROM
        `first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`
    WHERE
        NULLIF(TRIM(`Item`), '') IS NOT NULL
    GROUP BY
        `Category`,
        `Price Per Unit`
    HAVING
        COUNT(DISTINCT NULLIF(TRIM(`Item`), '')) = 1
)

SELECT
    t.* REPLACE (
        CASE
            WHEN NULLIF(TRIM(t.`Item`), '') IS NULL
                THEN r.recovered_item
            ELSE TRIM(t.`Item`)
        END AS `Item`
    )
FROM
    `first-project-506607.retail_store_salses_1.retail_store_sales_cleaned` AS t
LEFT JOIN
    item_reference AS r
ON
    t.`Category` = r.`Category`
    AND t.`Price Per Unit` = r.`Price Per Unit`;

-- Final verification: expected result = 12,575 | 12,575 | 0
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Transaction ID`) AS unique_transactions,
    COUNTIF(NULLIF(TRIM(`Item`), '') IS NULL) AS remaining_missing_items
FROM
    `first-project-506607.retail_store_salses_1.retail_store_sales_final_v2`;
