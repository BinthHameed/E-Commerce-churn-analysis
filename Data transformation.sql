USE ecomm;

ALTER TABLE customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;

ALTER TABLE customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;

ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(3);

UPDATE customer_churn
SET ComplaintReceived =
    CASE
        WHEN Complain = 1 THEN 'Yes'
        ELSE 'No'
    END;

SELECT ComplaintReceived, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY ComplaintReceived;

ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);

UPDATE customer_churn
SET ChurnStatus =
    CASE
        WHEN Churn = 1 THEN 'Churned'
        ELSE 'Active'
    END;
    
SELECT ChurnStatus, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY ChurnStatus;

ALTER TABLE customer_churn
DROP COLUMN Churn,
DROP COLUMN Complain;