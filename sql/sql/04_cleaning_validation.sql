-- ============================================================
-- 04_cleaning_validation.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Validate the cleaned dataset
-- ============================================================


-- ============================================================
-- 1. Check Remaining Missing Item Values
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNTIF(`Item` IS NULL) AS remaining_item_nulls
FROM `first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`;
