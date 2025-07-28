

CREATE TABLE customers_raw (
  CustomerID        VARCHAR(50),   
  Gender            VARCHAR(10),    
  SeniorCitizen     BOOLEAN,       
  Partner           VARCHAR(3),     
  Dependents        VARCHAR(3),     
  Tenure            INT,            
  PhoneService      VARCHAR(3),     
  MultipleLines     VARCHAR(20),    
  InternetService   VARCHAR(20),    
  OnlineSecurity    VARCHAR(3),     
  OnlineBackup      VARCHAR(3),     
  DeviceProtection  VARCHAR(3),     
  TechSupport       VARCHAR(3),     
  StreamingTV       VARCHAR(3),     
  StreamingMovies   VARCHAR(3),    
  Contract          VARCHAR(3),    
  PaperlessBilling  VARCHAR(3),     
  PaymentMethod     VARCHAR(50),    
  MonthlyCharges    DECIMAL(8,2),    
  TotalCharges      DECIMAL(10,2),   
  Churn             VARCHAR(3)      
);

ALTER TABLE public.customers_raw OWNER to postgres;





ALTER TABLE customers_raw
  ALTER COLUMN OnlineSecurity   TYPE VARCHAR(20),
  ALTER COLUMN OnlineBackup     TYPE VARCHAR(20),
  ALTER COLUMN DeviceProtection TYPE VARCHAR(20),
  ALTER COLUMN TechSupport      TYPE VARCHAR(20),
  ALTER COLUMN StreamingTV      TYPE VARCHAR(20),
  ALTER COLUMN StreamingMovies  TYPE VARCHAR(20),
  ALTER COLUMN Contract         TYPE VARCHAR(20);




ALTER TABLE customers_raw

ADD COLUMN IsChurn INT GENERATED ALWAYS AS (CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) STORED;



CREATE TABLE Dim_InternetService AS
  SELECT DISTINCT InternetService
  FROM customers_raw
  WHERE InternetService IS NOT NULL;



CREATE TABLE dim_contract AS
SELECT DISTINCT Contract
FROM customers_raw
WHERE Contract IS NOT NULL
  AND TRIM(Contract) <> '';