-- ARPU (Average Revenue Per User)

SELECT ROUND(AVG(MonthlyCharges), 2) AS ARPU
FROM customers_raw;

-- MRR (Monthly Recurring Revenue)

SELECT ROUND(SUM(MonthlyCharges), 2)  AS MRR
FROM customers_raw;


-- CLV (Customer Lifetime Value) last month 



WITH cr AS (
	
  SELECT churn_rate
  FROM vw_churn_trend
  ORDER BY tenure_month DESC
  LIMIT 1
)
SELECT
  ROUND((SELECT AVG(MonthlyCharges) FROM customers_raw)::numeric(8,2)
  /
  (SELECT churn_rate FROM cr), 2) AS CLV;






