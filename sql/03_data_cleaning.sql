-- ============================================================
-- 03_data_cleaning.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Create a cleaned version of the raw dataset
-- ============================================================


-- ============================================================
-- 1. Create Cleaned Table
-- Recover missing Item values using Category + Price Per Unit
-- ============================================================

CREATE OR REPLACE TABLE
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned` AS

WITH item_reference AS (
    SELECT
        `Category`,
        `Price Per Unit`,
        ANY_VALUE(`Item`) AS `Item`
    FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
    WHERE `Item` IS NOT NULL
      AND `Category` IS NOT NULL
      AND `Price Per Unit` IS NOT NULL
    GROUP BY
        `Category`,
        `Price Per Unit`
)

SELECT
    t.`Transaction ID`,
    t.`Customer ID`,
    t.`Category`,

    COALESCE(
        t.`Item`,
        r.`Item`
    ) AS `Item`,

    t.`Price Per Unit`,
    t.`Quantity`,
    t.`Total Spent`,
    t.`Payment Method`,
    t.`Location`,
    t.`Transaction Date`,
    t.`Discount Applied`

FROM `first-project-506607.retail_store_salses_1.retail_store_sales` AS t

LEFT JOIN item_reference AS r
    ON t.`Category` = r.`Category`
    AND t.`Price Per Unit` = r.`Price Per Unit`;
