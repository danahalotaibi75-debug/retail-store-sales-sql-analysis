-- ============================================================
-- 05_quantity_total_cleaning.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Validate whether missing Quantity and Total Spent
--          values can be reliably recovered
-- ============================================================


-- ============================================================
-- 1. Identify Recoverable Quantity Values
--
-- Quantity can only be recovered when:
-- Price Per Unit and Total Spent are available
-- and the resulting quantity is a valid integer.
-- ============================================================

SELECT
    COUNT(*) AS missing_quantity_rows,

    COUNTIF(
        `Price Per Unit` IS NOT NULL
        AND `Price Per Unit` != 0
        AND `Total Spent` IS NOT NULL
    ) AS calculable_quantity_rows,

    COUNTIF(
        `Price Per Unit` IS NOT NULL
        AND `Price Per Unit` != 0
        AND `Total Spent` IS NOT NULL
        AND `Total Spent` / `Price Per Unit`
            = CAST(`Total Spent` / `Price Per Unit` AS INT64)
    ) AS valid_integer_quantity_rows

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Quantity` IS NULL;


-- ============================================================
-- 2. Identify Recoverable Total Spent Values
--
-- Total Spent can only be recovered when:
-- Price Per Unit and Quantity are available.
-- ============================================================

SELECT
    COUNT(*) AS missing_total_spent_rows,

    COUNTIF(
        `Price Per Unit` IS NOT NULL
        AND `Quantity` IS NOT NULL
    ) AS calculable_total_spent_rows

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NULL;
