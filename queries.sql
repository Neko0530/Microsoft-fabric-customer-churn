-- Bank customer churn analysis: Microsoft Fabric SQL analytics endpoint
-- Table: churn_modelling

-- 1. Look at the data
SELECT TOP 10 * FROM churn_modelling;
SELECT COUNT(*) AS total_rows FROM churn_modelling;

-- 2. Overall churn rate
SELECT COUNT(*) AS total_customers,
       SUM(Exited) AS churned,
       ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate_pct
FROM churn_modelling;

-- 3. Churn by country
SELECT Geography,
       COUNT(*) AS customers,
       SUM(Exited) AS churned,
       ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate_pct
FROM churn_modelling
GROUP BY Geography
ORDER BY churn_rate_pct DESC;

-- 4. Churn by number of products
SELECT NumOfProducts,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate_pct
FROM churn_modelling
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- 5. High-value customers at risk (still here, but inactive with big balances)
SELECT TOP 10 CustomerId, Geography, Age, Balance
FROM churn_modelling
WHERE Exited = 0 AND IsActiveMember = 0 AND Balance > 100000
ORDER BY Balance DESC;

-- 6. Churn rate by tenure
SELECT Tenure,
       ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate_pct
FROM churn_modelling
GROUP BY Tenure
ORDER BY Tenure;

-- 7. LAG: compare each tenure year with the previous year
WITH by_tenure AS (
    SELECT Tenure,
           ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate_pct
    FROM churn_modelling
    GROUP BY Tenure
)
SELECT Tenure,
       churn_rate_pct,
       LAG(churn_rate_pct) OVER (ORDER BY Tenure) AS previous_year_rate
FROM by_tenure
ORDER BY Tenure;

-- 8. LEAD: compare each tenure year with the next year
WITH by_tenure AS (
    SELECT Tenure,
           ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate_pct
    FROM churn_modelling
    GROUP BY Tenure
)
SELECT Tenure,
       churn_rate_pct,
       LEAD(churn_rate_pct) OVER (ORDER BY Tenure) AS next_year_rate
FROM by_tenure
ORDER BY Tenure;
