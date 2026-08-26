-- ============================================================
-- 02_data_quality_checks.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Identify data quality issues before cleaning
-- ============================================================


-- ============================================================
-- 1. Check for Duplicate Transaction IDs
-- ============================================================

SELECT
    `Transaction ID`,
    COUNT(*) AS duplicate_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================
-- 2. Check for Invalid Numeric Values
-- ============================================================

SELECT
    COUNTIF(`Price Per Unit` <= 0) AS invalid_price,
    COUNTIF(`Quantity` <= 0) AS invalid_quantity,
    COUNTIF(`Total Spent` <= 0) AS invalid_total_spent
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`;


-- ============================================================
-- 3. Validate Total Spent Calculation
-- Expected:
-- Price Per Unit × Quantity = Total Spent
-- ============================================================

SELECT
    COUNTIF(
        `Price Per Unit` IS NOT NULL
        AND `Quantity` IS NOT NULL
        AND `Total Spent` IS NOT NULL
        AND ABS(
            `Total Spent` - (`Price Per Unit` * `Quantity`)
        ) > 0.01
    ) AS total_spent_mismatch
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`;


-- ============================================================
-- 4. Check Category Consistency
-- ============================================================

SELECT
    `Category`,
    COUNT(*) AS row_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
GROUP BY `Category`
ORDER BY row_count DESC;


-- ============================================================
-- 5. Check Payment Method Consistency
-- ============================================================

SELECT
    `Payment Method`,
    COUNT(*) AS row_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
GROUP BY `Payment Method`
ORDER BY row_count DESC;


-- ============================================================
-- 6. Check Location Consistency
-- ============================================================

SELECT
    `Location`,
    COUNT(*) AS row_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
GROUP BY `Location`
ORDER BY row_count DESC;


-- ============================================================
-- 7. Check Discount Applied Values
-- ============================================================

SELECT
    `Discount Applied`,
    COUNT(*) AS row_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
GROUP BY `Discount Applied`
ORDER BY row_count DESC;


-- ============================================================
-- 8. Check Item and Price Consistency
-- Identify items associated with multiple prices
-- ============================================================

SELECT
    `Item`,
    COUNT(*) AS row_count,
    COUNT(DISTINCT `Price Per Unit`) AS distinct_prices
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
WHERE `Item` IS NOT NULL
GROUP BY `Item`
ORDER BY row_count DESC;


-- ============================================================
-- 9. Identify Prices Associated with Multiple Items
-- ============================================================

SELECT
    `Price Per Unit`,
    COUNT(DISTINCT `Item`) AS distinct_items,
    COUNT(*) AS row_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
WHERE `Price Per Unit` IS NOT NULL
  AND `Item` IS NOT NULL
GROUP BY `Price Per Unit`
HAVING COUNT(DISTINCT `Item`) > 1
ORDER BY distinct_items DESC;


-- ============================================================
-- 10. Check Category + Price + Item Consistency
-- ============================================================

SELECT
    `Category`,
    `Price Per Unit`,
    COUNT(DISTINCT `Item`) AS distinct_items,
    COUNT(*) AS row_count
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
WHERE `Category` IS NOT NULL
  AND `Price Per Unit` IS NOT NULL
  AND `Item` IS NOT NULL
GROUP BY
    `Category`,
    `Price Per Unit`
HAVING COUNT(DISTINCT `Item`) > 1
ORDER BY
    distinct_items DESC,
    `Category`,
    `Price Per Unit`;


-- ============================================================
-- 11. Identify Recoverable Missing Items
-- An Item can potentially be recovered when:
-- Category and Price Per Unit match an existing record
-- ============================================================

SELECT
    COUNT(*) AS recoverable_items
FROM `first-project-506607.retail_store_salses_1.retail_store_sales` AS t
WHERE t.`Item` IS NULL
  AND t.`Category` IS NOT NULL
  AND t.`Price Per Unit` IS NOT NULL
  AND EXISTS (
      SELECT 1
      FROM `first-project-506607.retail_store_salses_1.retail_store_sales` AS ref
      WHERE ref.`Item` IS NOT NULL
        AND ref.`Category` = t.`Category`
        AND ref.`Price Per Unit` = t.`Price Per Unit`
  );


-- ============================================================
-- 12. Review Items That Can Be Recovered
-- ============================================================

SELECT
    t.`Category`,
    t.`Price Per Unit`,
    ref.`Item` AS inferred_item,
    COUNT(*) AS rows_to_recover
FROM `first-project-506607.retail_store_salses_1.retail_store_sales` AS t
JOIN `first-project-506607.retail_store_salses_1.retail_store_sales` AS ref
    ON t.`Category` = ref.`Category`
    AND t.`Price Per Unit` = ref.`Price Per Unit`
WHERE t.`Item` IS NULL
  AND ref.`Item` IS NOT NULL
GROUP BY
    t.`Category`,
    t.`Price Per Unit`,
    ref.`Item`
ORDER BY rows_to_recover DESC;


-- ============================================================
-- 13. Identify Reliable Category + Price → Item Relationships
-- Only combinations linked to exactly one Item
-- ============================================================

SELECT
    `Category`,
    `Price Per Unit`,
    COUNT(DISTINCT `Item`) AS distinct_items,
    ARRAY_AGG(DISTINCT `Item`) AS items
FROM `first-project-506607.retail_store_salses_1.retail_store_sales`
WHERE `Item` IS NOT NULL
  AND `Category` IS NOT NULL
  AND `Price Per Unit` IS NOT NULL
GROUP BY
    `Category`,
    `Price Per Unit`
HAVING COUNT(DISTINCT `Item`) = 1
ORDER BY
    `Category`,
    `Price Per Unit`;
