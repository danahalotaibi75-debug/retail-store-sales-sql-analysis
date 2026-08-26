-- ============================================
-- 01_data_quality.sql
-- Retail Store Sales
-- Data Quality Assessment
-- ============================================

-- 1. Total number of rows
SELECT
  COUNT(*) AS total_rows
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`;


-- 2. Check missing values
SELECT
  COUNTIF(`Transaction ID` IS NULL) AS transaction_id_nulls,
  COUNTIF(`Customer ID` IS NULL) AS customer_id_nulls,
  COUNTIF(`Category` IS NULL) AS category_nulls,
  COUNTIF(`Item` IS NULL) AS item_nulls,
  COUNTIF(`Price Per Unit` IS NULL) AS price_nulls,
  COUNTIF(`Quantity` IS NULL) AS quantity_nulls,
  COUNTIF(`Total Spent` IS NULL) AS total_spent_nulls,
  COUNTIF(`Payment Method` IS NULL) AS payment_method_nulls,
  COUNTIF(`Location` IS NULL) AS location_nulls,
  COUNTIF(`Transaction Date` IS NULL) AS transaction_date_nulls,
  COUNTIF(`Discount Applied` IS NULL) AS discount_nulls
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`;


-- 3. Check duplicate Transaction IDs
SELECT
  `Transaction ID`,
  COUNT(*) AS duplicate_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- 4. Check date range
SELECT
  MIN(`Transaction Date`) AS min_transaction_date,
  MAX(`Transaction Date`) AS max_transaction_date
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`;
