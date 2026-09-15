# Retail Store Sales — Data Cleaning, SQL Analysis & Power BI

## 📌 Project Overview

This portfolio project demonstrates an end-to-end retail sales analysis workflow using Google BigQuery and Power BI. It covers data profiling, quality checks, evidence-based recovery of missing values, validation, business analysis, and dashboard development.

**Workflow:** Data Profiling → Quality Checks → Data Cleaning → Validation → SQL Analysis → Power BI Dashboard

---

## 🎯 Objectives

- Identify missing values, duplicates, and numerical inconsistencies.
- Recover missing values only when a reliable relationship exists.
- Preserve records when missing values cannot be reconstructed safely.
- Validate the cleaned dataset and transaction calculations.
- Analyze category, product, location, payment, customer, and time performance.
- Present the results in an interactive Power BI dashboard.

---

## 🛠️ Tools & Technologies

- SQL (GoogleSQL / BigQuery Standard SQL)
- Google BigQuery
- Power BI
- GitHub

---

## 📊 Dataset Overview

The dataset contains **12,575 retail transaction records** covering **January 1, 2022 through January 18, 2025**.

| Metric | Value |
|---|---:|
| Total Records | 12,575 |
| Unique Transaction IDs | 12,575 |
| Transactions with Recorded Sales | 11,971 |
| Unique Customers | 25 |
| Categories | 8 |
| Date Range | 2022-01-01 → 2025-01-18 |
| Total Recorded Sales | 1,552,071 |

### Main Columns

- Transaction ID
- Customer ID
- Category
- Item
- Price Per Unit
- Quantity
- Total Spent
- Payment Method
- Location
- Transaction Date
- Discount Applied

---

## 🧹 Data Cleaning

The initial quality assessment identified the following missing values:

| Column | Initial Missing Values |
|---|---:|
| Item | 1,213 |
| Price Per Unit | 609 |
| Quantity | 604 |
| Total Spent | 604 |
| Discount Applied | 4,199 |

No transactions were deleted solely because they contained missing data. A value was recovered only when the dataset provided a reliable rule.

### Item

Missing and blank `Item` values were recovered using:

**Category + Price Per Unit → Item**

Only combinations associated with exactly one known item were used. The remaining 609 blank values were successfully recovered in the final table.

**Result: 1,213 missing/blank values → 0**

### Price Per Unit

Missing `Price Per Unit` values were investigated using:

**Total Spent ÷ Quantity → Price Per Unit**

Calculated values were validated against known category and item prices before recovery.

**Result: 609 missing values → 0**

### Quantity

The relationship **Total Spent ÷ Price Per Unit → Quantity** was tested for 604 missing values. None could be recovered reliably as valid integer quantities, so they were retained as `NULL`.

**Result: 604 NULL retained**

### Total Spent

The same 604 records lacked the quantity needed to calculate **Price Per Unit × Quantity**, so their `Total Spent` values were retained as `NULL`.

**Result: 604 NULL retained**

### Discount Applied

The data provided no reliable rule for determining whether 4,199 unknown discount values represented `TRUE` or `FALSE`, so they were retained as `NULL`.

**Result: 4,199 NULL retained**

### Final Table

Because BigQuery Sandbox does not allow DML statements such as `UPDATE`, the corrected result was written with `CREATE OR REPLACE TABLE ... AS SELECT` to:

`first-project-506607.retail_store_salses_1.retail_store_sales_final_v2`

---

## 🔎 Data Validation

| Validation Check | Result |
|---|---:|
| Total Records | 12,575 |
| Unique Transaction IDs | 12,575 |
| Duplicate Transactions | 0 |
| Transaction ID NULL | 0 |
| Customer ID NULL | 0 |
| Category NULL | 0 |
| Item NULL/Blank | 0 |
| Price Per Unit NULL | 0 |
| Payment Method NULL | 0 |
| Location NULL | 0 |
| Transaction Date NULL | 0 |
| Quantity NULL | 604 |
| Total Spent NULL | 604 |
| Discount Applied NULL | 4,199 |

Additional validation confirmed:

- No invalid numerical values.
- No mismatches between `Price Per Unit × Quantity` and `Total Spent` among complete records.
- No duplicate transaction IDs.

---

## 📈 Business Analysis

### Total Sales

**1,552,071**, calculated from the **11,971 transactions with recorded `Total Spent` values**.

### Sales by Category

| Category | Total Sales |
|---|---:|
| Butchers | **208,118** |
| Electric household essentials | 203,813.5 |
| Beverages | 197,047.5 |
| Furniture | 195,310 |
| Food | 194,812 |
| Computers and electric accessories | 190,692.5 |
| Patisserie | 182,165.5 |
| Milk Products | 180,112 |

### Top-Selling Product

`Item_25_FUR` was the top-selling product with **25,256** in recorded sales.

### Sales by Location

| Location | Total Sales |
|---|---:|
| Online | **791,401** |
| In-store | 760,670 |

Online sales were approximately **4.04% higher** than in-store sales.

### Sales by Payment Method

| Payment Method | Total Sales |
|---|---:|
| Cash | **537,710** |
| Digital Wallet | 507,279 |
| Credit Card | 507,082 |

### Yearly Sales

| Year | Total Sales |
|---|---:|
| 2022 | 510,329.5 |
| 2023 | 491,312 |
| **2024** | **524,881** |
| 2025* | 25,548.5 |

**2024 recorded the highest sales among the complete years.**

\*2025 contains partial data through January 18 and should not be compared directly with complete years.

### Top Customer

`CUST_24` was the highest-spending customer:

| Metric | Value |
|---|---:|
| Total Spending | 68,452 |
| Transactions | 519 |
| Average Transaction Value | 131.89 |

### Calendar-Month Analysis

When the same calendar month was aggregated across all years, January recorded the highest sales (**174,421**) and the most recorded-sales transactions (**1,295**). The Power BI dashboard uses a chronological Year–Month axis instead, so trends from 2022 through January 2025 are not mixed across years.

### Discount Analysis

Among transactions with a known discount status:

| Discount Applied | Transactions | Percentage |
|---|---:|---:|
| TRUE | 4,219 | 50.37% |
| FALSE | 4,157 | 49.63% |

The 4,199 `NULL` values were excluded because their discount status was unknown.

---

## 💡 Key Business Insights

- Butchers was the highest-performing category with **208,118** in total sales.
- `Item_25_FUR` was the top-selling product with **25,256** in sales.
- Online sales exceeded in-store sales by approximately **4.04%**.
- Cash generated the highest sales among the payment methods.
- 2024 was the strongest complete year with **524,881** in sales.
- `CUST_24` was the highest-spending customer with **68,452**.
- Discounted and non-discounted transactions were almost evenly distributed among records with known discount status.

---

## 📊 Power BI Dashboard

The final dashboard includes:

- Total Sales
- Recorded Sales Transactions
- Unique Customers
- Sales by Category
- Online vs In-store Sales
- Monthly Sales Trend using a chronological Year–Month axis
- Sales by Payment Method
- Top 10 Products by Sales
- Top 10 Customers by Spending

January 2025 is clearly identified as partial data through January 18.

![Retail Sales Dashboard](dashboard/retail_sales_dashboard.png)

---

## 📂 Project Structure

```text
retail-store-sales-sql-analysis/
├── README.md
├── sql/
│   ├── 01_data_quality.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_numeric_data_cleaning.sql
│   ├── 05_quantity_total_cleaning.sql
│   ├── 06_cleaning_validation.sql
│   ├── 07_sales_analysis.sql
│   └── 08_final_item_recovery.sql
├── dashboard/
│   └── retail_sales_dashboard.png
└── screenshots/
    ├── 01_bigquery_schema.png
    ├── 02_data_quality.png
    ├── 03_data_cleaning.png
    ├── 04_numeric_cleaning.png
    ├── 05_quantity_total_cleaning.png
    ├── 06_validation.png
    └── 07_business_analysis.png
```

---

## Data Integrity Principle

Unknown values were preserved when they could not be recovered from a validated relationship. This avoids introducing unsupported assumptions into the analysis.
