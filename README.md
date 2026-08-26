# Retail Store Sales — Data Cleaning & SQL Analysis

## 📌 Project Overview

This project focuses on cleaning, validating, and analyzing retail store sales data using SQL in Google BigQuery.

The objective is to identify data quality issues, apply appropriate data-cleaning techniques, validate data integrity, and extract meaningful business insights from the cleaned dataset.

---

## 🎯 Objectives

- Identify and assess data quality issues
- Analyze missing values and data inconsistencies
- Clean and validate the dataset using SQL
- Analyze sales and product performance
- Analyze customer spending behavior
- Compare online and in-store sales
- Analyze payment methods and sales trends
- Generate meaningful business insights

---

## 🛠️ Tools & Technologies

- SQL
- Google BigQuery
- GitHub

---

## 📊 Dataset Overview

The dataset contains **12,575 retail transactions** covering the period from **January 1, 2022 to January 18, 2025**.

| Metric | Value |
|---|---:|
| Total Transactions | 12,575 |
| Customers | 25 |
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

# 🧹 Data Cleaning

An initial data quality assessment identified several missing-value issues.

| Column | Initial Missing Values |
|---|---:|
| Item | 1,213 |
| Price Per Unit | 609 |
| Quantity | 604 |
| Total Spent | 604 |
| Discount Applied | 4,199 |

### Cleaning Approach

#### Item

Missing Item values were investigated using relationships between Item, Category, and Price Per Unit.

Where a reliable pattern was identified, missing Item values were restored.

**Result:** `1,213 → 0 NULL`

#### Price Per Unit

Price values were analyzed based on the relationship between Item and its associated price.

Where the value could be reliably determined, it was restored.

**Result:** `609 → 0 NULL`

#### Quantity

604 records contained missing Quantity values.

Because there was no sufficiently reliable rule for determining the original quantity for each record, these values were not artificially imputed.

**Result:** `604 NULL retained`

#### Total Spent

The same 604 records also contained missing Total Spent values.

Since Quantity was unavailable, Total Spent could not be reliably reconstructed using:

`Price Per Unit × Quantity`

Therefore, these values were retained as NULL.

#### Discount Applied

4,199 records contained NULL values for Discount Applied.

Because the available data did not provide a reliable rule for determining whether these records represented TRUE or FALSE, the NULL values were retained.

> Unknown values were not artificially imputed when no reliable business rule was available.

---

# 🔎 Data Validation

After cleaning, the dataset was validated for duplicates, missing values, and data consistency.

| Validation Check | Result |
|---|---:|
| Total Rows | 12,575 |
| Duplicate Transactions | 0 |
| Customer ID NULL | 0 |
| Category NULL | 0 |
| Item NULL | 0 |
| Price Per Unit NULL | 0 |
| Payment Method NULL | 0 |
| Location NULL | 0 |
| Transaction Date NULL | 0 |
| Quantity NULL | 604 |
| Total Spent NULL | 604 |
| Discount Applied NULL | 4,199 |

Financial consistency was also checked by comparing:

`Price Per Unit × Quantity`

with:

`Total Spent`

for records where the required values were available.

---

# 📈 Business Analysis

## 💰 Total Sales

**1,552,071**

This represents the total recorded sales from transactions with available `Total Spent` values.

---

## 🥩 Sales by Category

**Butchers** generated the highest total sales:

**208,118**

While **Milk Products** recorded the lowest:

**180,112**

---

## 🏆 Top-Selling Product

**Item_25_FUR**

- Total Sales: **25,256**
- Units Sold: **616**
- Transactions: **113**

---

## 🛒 Sales Channel

| Location | Total Sales |
|---|---:|
| Online | 791,401 |
| In-store | 760,670 |

Online sales were approximately **4% higher** than in-store sales.

---

## 💳 Payment Methods

**Cash** generated the highest total sales:

**537,710**

followed by Digital Wallet and Credit Card.

---

## 📅 Yearly Sales

**2024** recorded the highest sales among the complete years:

**524,881**

> Note: 2025 contains partial-year data through January 18, 2025 and should not be directly compared with complete years.

---

## 👥 Top Customer

**CUST_24**

- Total Spending: **68,452**
- Transactions: **519**

---

## 📅 Monthly Sales

**January** recorded the highest aggregated monthly sales:

**174,421**

It also had the highest number of transactions:

**1,295**

---

## 🏷️ Discount Analysis

Among transactions with a known discount status:

| Discount Applied | Percentage |
|---|---:|
| TRUE | 50.37% |
| FALSE | 49.63% |

NULL discount values were excluded from this percentage calculation because their status was unknown.

---

# 💡 Key Business Insights

1. **Butchers** was the highest-performing category with **208,118** in total sales.
2. **Item_25_FUR** was the top-selling individual product with **25,256** in sales.
3. **Online** sales slightly exceeded in-store sales by approximately **4%**.
4. **Cash** generated the highest total sales among payment methods.
5. **2024** was the strongest complete year in the dataset.
6. **CUST_24** was the highest-spending customer with **68,452** in total spending.
7. **January** recorded the highest aggregated monthly sales at **174,421**.
8. Discounted and non-discounted transactions were almost evenly distributed among records with known discount status.

---

# 📊 Dashboard

The final dashboard includes:

- Total Sales KPI
- Total Transactions KPI
- Customer Count KPI
- Sales by Category
- Online vs In-store Sales
- Monthly Sales Trend
- Top 10 Products
- Sales by Payment Method

---

# 📂 Project Structure

```text
retail-store-sales-sql-analysis/
│
├── README.md
│
├── sql/
│   ├── 01_data_quality.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_data_validation.sql
│   └── 04_business_analysis.sql
│
├── dashboard/
│   └── retail_sales_dashboard.png
│
└── screenshots/
    ├── 01_bigquery_schema.png
    ├── 02_data_quality.png
    ├── 03_data_cleaning.png
    ├── 04_validation.png
    ├── 05_category_analysis.png
    └── 06_business_analysis.png
```

---

# 🎓 Skills Demonstrated

- SQL
- Data Cleaning
- Data Validation
- Exploratory Data Analysis
- Business Analysis
- Data Quality Assessment
- Missing Value Analysis
- Aggregation & Grouping
- Customer Analysis
- Sales Analysis
- Google BigQuery
