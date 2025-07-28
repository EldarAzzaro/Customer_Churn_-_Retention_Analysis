 
 -- Validate the customers_raw table
 
 SELECT
  CustomerID,
  Gender,
  SeniorCitizen,
  Partner,
  Dependents,
  Tenure,
  PhoneService,
  MultipleLines,
  InternetService,
  OnlineSecurity,
  OnlineBackup,
  DeviceProtection,
  TechSupport,
  StreamingTV,
  StreamingMovies,
  Contract,
  PaperlessBilling,
  PaymentMethod,
  MonthlyCharges,
  TotalCharges,
  Churn,
  IsChurn
FROM customers_raw; 




SELECT
gender,
 COUNT(IsChurn)
FROM customers_raw
GROUP BY gender
ORDER BY gender;




-- Check for null and zero values in TotalCharges

SELECT
  COUNT(*) FILTER (WHERE TotalCharges IS NULL) AS null_count,
  COUNT(*) FILTER (WHERE TotalCharges = 0)      AS zero_count
FROM customers_raw;

-- Update TotalCharges to 0 where it is NULL
-- This is necessary to ensure that all records have a valid TotalCharges value

UPDATE customers_raw
SET TotalCharges = 0
WHERE TotalCharges IS NULL;


-- Check for negative values in Tenure, MonthlyCharges, and TotalCharges

SELECT
  MIN(Tenure)        AS min_tenure,
  MAX(Tenure)        AS max_tenure,
  MIN(MonthlyCharges) AS min_charge,
  MAX(MonthlyCharges) AS max_charge,
  MIN(totalcharges) AS min_totalCharge,
  MAX(totalcharges) AS max_totalCharge
FROM customers_raw;


SELECT *
FROM customers_raw
WHERE Tenure < 0
   OR MonthlyCharges < 0 OR TotalCharges < 0
   OR MonthlyCharges IS NULL
   OR TotalCharges IS NULL;



-- Check for duplicate CustomerID values

SELECT 
  CustomerID, COUNT(*)
FROM customers_raw

GROUP BY CustomerID

HAVING COUNT(*) > 1;







