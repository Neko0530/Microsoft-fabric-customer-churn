# Bank customer churn analysis (Microsoft Fabric)

## Goal
Find which customers leave the bank, and what they have in common.

## Tools
Microsoft Fabric (Lakehouse, SQL analytics endpoint, Power BI), T-SQL, DAX

## Data
Kaggle "Bank Customer Churn" dataset, 10,000 customers.

## Steps
1. Loaded the CSV into a Fabric Lakehouse as a Delta table.
2. Analysed it with T-SQL: aggregations, CASE, CTEs, LAG and LEAD.
3. Built a semantic model and a Power BI report with a DAX churn-rate measure.

## Key findings
- Overall churn rate: 20.37% (2,037 of 10,000 customers)
- Germany has the highest churn at 32.44%, versus Spain 16.67% and France 16.15%
- Churn by products held: 1 product 27.71%, 2 products 7.58%, 3 products 82.71%, 4 products 100% (only 60 customers)
- Customers with 2 products are the most loyal group

## Dashboard
Screenshot coming soon.

## Files
- queries.sql: all SQL queries
