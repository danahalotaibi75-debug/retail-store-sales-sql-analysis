-- ============================================================
-- 04_numeric_data_cleaning.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Recover missing Price Per Unit values
--          using validated Category + Price Per Unit patterns
-- ============================================================


CREATE OR REPLACE TABLE
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned` AS

WITH price_reference AS (
    SELECT DISTINCT
        `Category`,
        `Price Per Unit`,
        `Item`
    FROM
        `first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`
    WHERE
        `Item` IS NOT NULL
        AND `Price Per Unit` IS NOT NULL
)

SELECT
    t.`Transaction ID`,
    t.`Customer ID`,
    t.`Category`,
    t.`Item`,

    CASE
        WHEN t.`Price Per Unit` IS NOT NULL
        THEN t.`Price Per Unit`

        WHEN t.`Quantity` IS NOT NULL
             AND t.`Quantity` != 0
             AND t.`Total Spent` IS NOT NULL
             AND ref.`Price Per Unit` IS NOT NULL
        THEN ref.`Price Per Unit`

        ELSE NULL
    END AS `Price Per Unit`,

    t.`Quantity`,
    t.`Total Spent`,
    t.`Payment Method`,
    t.`Location`,
    t.`Transaction Date`,
    t.`Discount Applied`

FROM
    `first-project-506607.retail_store_salses_1.retail_store_sales_cleaned` AS t

LEFT JOIN price_reference AS ref
    ON t.`Category` = ref.`Category`
    AND ROUND(t.`Total Spent` / t.`Quantity`, 2)
        = ref.`Price Per Unit`

    AND (
        t.`Item` IS NULL
        OR t.`Item` = ref.`Item`
    );
