



-- Churn analysis by tenure

CREATE VIEW vw_churn_trend AS

SELECT
  tenure AS tenure_month,
  COUNT(*) AS total_customers,
  SUM(ischurn) AS churned_customers,
  ROUND(SUM(ischurn)::numeric / COUNT(*)::numeric, 4) AS churn_rate
FROM customers_raw
GROUP BY tenure
ORDER BY tenure;


-- Churn rate by Internet Service and Contract type 

CREATE VIEW vw_churn_by_segment AS

SELECT
  InternetService,
  Contract,
  COUNT(*) AS customer_count,
  ROUND( AVG(MonthlyCharges), 2 ) AS avg_monthly_charge,
  ROUND( SUM(ischurn)::numeric / COUNT(*)::numeric, 4 ) AS churn_rate,
  SUM(IsChurn) AS ChurnedCustomers
FROM customers_raw
GROUP BY InternetService, Contract
ORDER BY churn_rate DESC;



--  Auxiliary View for Retention by Tenure

CREATE OR REPLACE VIEW vw_retention_by_tenure AS

SELECT
  Tenure AS tenure_month,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN IsChurn = 0 THEN 1 ELSE 0 END) AS retained_customers,
  ROUND((SUM(CASE WHEN IsChurn = 0 THEN 1 ELSE 0 END)::numeric / COUNT(*)::numeric) * 100, 4) AS retention_rate
FROM customers_raw
GROUP BY Tenure
ORDER BY Tenure;




















