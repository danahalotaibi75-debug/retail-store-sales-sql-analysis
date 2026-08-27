-- ============================================================
-- 07_sales_analysis.sql
-- Retail Store Sales Data Cleaning Project
-- Purpose: Analyze sales performance using the cleaned dataset
-- ============================================================


-- ============================================================
-- 1. Overall Sales KPIs
-- ============================================================

SELECT
    SUM(`Total Spent`) AS total_sales,
    COUNTIF(`Total Spent` IS NOT NULL) AS total_transactions,
    COUNT(DISTINCT `Customer ID`) AS unique_customers

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL;


-- ============================================================
-- 2. Sales Performance by Category
-- ============================================================

SELECT
    `Category`,
    COUNT(*) AS transactions,
    SUM(`Total Spent`) AS total_sales,
    AVG(`Total Spent`) AS avg_transaction_value

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL

GROUP BY
    `Category`

ORDER BY
    total_sales DESC;


-- ============================================================
-- 3. Top 10 Items by Sales
-- ============================================================

SELECT
    `Item`,
    `Category`,
    COUNT(*) AS transactions,
    SUM(`Quantity`) AS units_sold,
    SUM(`Total Spent`) AS total_sales

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL
    AND `Quantity` IS NOT NULL
    AND `Item` IS NOT NULL

GROUP BY
    `Item`,
    `Category`

ORDER BY
    total_sales DESC

LIMIT 10;


-- ============================================================
-- 4. Sales Performance by Location
-- ============================================================

SELECT
    `Location`,
    COUNT(*) AS transactions,
    SUM(`Total Spent`) AS total_sales,
    AVG(`Total Spent`) AS avg_transaction_value

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL
    AND `Location` IS NOT NULL

GROUP BY
    `Location`

ORDER BY
    total_sales DESC;


-- ============================================================
-- 5. Sales Performance by Payment Method
-- ============================================================

SELECT
    `Payment Method`,
    COUNT(*) AS transactions,
    SUM(`Total Spent`) AS total_sales,
    AVG(`Total Spent`) AS avg_transaction_value

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL
    AND `Payment Method` IS NOT NULL

GROUP BY
    `Payment Method`

ORDER BY
    total_sales DESC;


-- ============================================================
-- 6. Sales Performance by Year
-- ============================================================

SELECT
    EXTRACT(YEAR FROM `Transaction Date`) AS year,
    COUNT(*) AS transactions,
    SUM(`Total Spent`) AS total_sales,
    AVG(`Total Spent`) AS avg_transaction_value

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL
    AND `Transaction Date` IS NOT NULL

GROUP BY
    year

ORDER BY
    year;


-- ============================================================
-- 7. Top 10 Customers by Total Spending
-- ============================================================

SELECT
    `Customer ID`,
    COUNT(*) AS transactions,
    SUM(`Total Spent`) AS total_spent,
    AVG(`Total Spent`) AS avg_transaction_value

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL
    AND `Customer ID` IS NOT NULL

GROUP BY
    `Customer ID`

ORDER BY
    total_spent DESC

LIMIT 10;


-- ============================================================
-- 8. Monthly Sales Performance
-- ============================================================

SELECT
    EXTRACT(MONTH FROM `Transaction Date`) AS month,
    FORMAT_DATE('%B', `Transaction Date`) AS month_name,
    COUNT(*) AS transactions,
    SUM(`Total Spent`) AS total_sales,
    AVG(`Total Spent`) AS avg_transaction_value

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Total Spent` IS NOT NULL
    AND `Transaction Date` IS NOT NULL

GROUP BY
    month,
    month_name

ORDER BY
    month;


-- ============================================================
-- 9. Discount Distribution
-- ============================================================

SELECT
    `Discount Applied`,
    COUNT(*) AS transactions,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage

FROM
`first-project-506607.retail_store_salses_1.retail_store_sales_cleaned`

WHERE
    `Discount Applied` IS NOT NULL

GROUP BY
    `Discount Applied`

ORDER BY
    transactions DESC;
