-- ============================================================
-- 05_quantity_total_cleaning.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Recover missing Quantity and Total Spent values
--          using valid numerical relationships
-- ============================================================


-- ============================================================
-- 1. Recover Missing Quantity and Total Spent
--
-- Quantity can be calculated when:
-- Total Spent and Price Per Unit are available.
--
-- Total Spent can be calculated when:
-- Price Per Unit and Quantity are available.
--
-- Rows where both Quantity and Total Spent are missing
-- cannot be reliably recovered from these fields alone.
-- ============================================================

CREATE OR REPLACE TABLE
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned` AS

SELECT
    `Transaction ID`,
    `Customer ID`,
    `Category`,
    `Item`,
    `Price Per Unit`,

    CASE
        WHEN `Quantity` IS NULL
             AND `Price Per Unit` IS NOT NULL
             AND `Price Per Unit` != 0
             AND `Total Spent` IS NOT NULL
        THEN ROUND(`Total Spent` / `Price Per Unit`, 2)

        ELSE `Quantity`
    END AS `Quantity`,

    CASE
        WHEN `Total Spent` IS NULL
             AND `Price Per Unit` IS NOT NULL
             AND `Quantity` IS NOT NULL
        THEN ROUND(`Price Per Unit` * `Quantity`, 2)

        ELSE `Total Spent`
    END AS `Total Spent`,

    `Payment Method`,
    `Location`,
    `Transaction Date`,
    `Discount Applied`

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`;
