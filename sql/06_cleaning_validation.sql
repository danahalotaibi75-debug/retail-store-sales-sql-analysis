-- ============================================================
-- 06_cleaning_validation.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Validate the final cleaned dataset
-- ============================================================


-- ============================================================
-- 1. Check Row Count and Remaining NULL Values
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Transaction ID`) AS unique_transactions,

    COUNTIF(`Transaction ID` IS NULL) AS transaction_id_nulls,
    COUNTIF(`Customer ID` IS NULL) AS customer_id_nulls,
    COUNTIF(`Category` IS NULL) AS category_nulls,
    COUNTIF(`Item` IS NULL) AS item_nulls,
    COUNTIF(`Price Per Unit` IS NULL) AS price_nulls,
    COUNTIF(`Quantity` IS NULL) AS quantity_nulls,
    COUNTIF(`Total Spent` IS NULL) AS total_spent_nulls,
    COUNTIF(`Payment Method` IS NULL) AS payment_method_nulls,
    COUNTIF(`Location` IS NULL) AS location_nulls,
    COUNTIF(`Transaction Date` IS NULL) AS date_nulls,
    COUNTIF(`Discount Applied` IS NULL) AS discount_nulls

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`;


-- ============================================================
-- 2. Check for Duplicate Transaction IDs
-- ============================================================

SELECT
    `Transaction ID`,
    COUNT(*) AS duplicate_count

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

GROUP BY
    `Transaction ID`

HAVING COUNT(*) > 1

ORDER BY
    duplicate_count DESC;


-- ============================================================
-- 3. Validate Total Spent Calculation
--
-- Expected:
-- Price Per Unit × Quantity = Total Spent
-- ============================================================

SELECT
    COUNT(*) AS complete_rows,

    COUNTIF(
        ROUND(`Price Per Unit` * `Quantity`, 2)
        = ROUND(`Total Spent`, 2)
    ) AS matching_rows,

    COUNTIF(
        ROUND(`Price Per Unit` * `Quantity`, 2)
        != ROUND(`Total Spent`, 2)
    ) AS mismatched_rows

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Price Per Unit` IS NOT NULL
    AND `Quantity` IS NOT NULL
    AND `Total Spent` IS NOT NULL;


-- ============================================================
-- 4. Check for Invalid Numeric Values
-- ============================================================

SELECT
    COUNTIF(`Price Per Unit` <= 0) AS invalid_price,
    COUNTIF(`Quantity` <= 0) AS invalid_quantity,
    COUNTIF(`Total Spent` <= 0) AS invalid_total_spent,

    COUNTIF(
        `Quantity` IS NOT NULL
        AND `Quantity` != CAST(`Quantity` AS INT64)
    ) AS fractional_quantity

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`;
