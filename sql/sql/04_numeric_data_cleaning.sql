-- ============================================================
-- 04_numeric_data_cleaning.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Recover missing Price Per Unit values
--          using Total Spent ÷ Quantity
-- ============================================================

CREATE OR REPLACE TABLE
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned` AS

SELECT
    `Transaction ID`,
    `Customer ID`,
    `Category`,
    `Item`,

    CASE
        WHEN `Price Per Unit` IS NULL
             AND `Quantity` IS NOT NULL
             AND `Quantity` != 0
             AND `Total Spent` IS NOT NULL
        THEN ROUND(`Total Spent` / `Quantity`, 2)

        ELSE `Price Per Unit`
    END AS `Price Per Unit`,

    `Quantity`,
    `Total Spent`,
    `Payment Method`,
    `Location`,
    `Transaction Date`,
    `Discount Applied`

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`;
