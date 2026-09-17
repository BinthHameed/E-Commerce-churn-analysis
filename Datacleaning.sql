USE ecomm;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(WarehouseToHome IS NULL) AS Missing_WarehouseToHome,
    SUM(HourSpendOnApp IS NULL) AS Missing_HourSpendOnApp,
    SUM(OrderAmountHikeFromlastYear IS NULL) AS Missing_OrderAmountHike,
    SUM(DaySinceLastOrder IS NULL) AS Missing_DaySinceLastOrder,
    SUM(Tenure IS NULL) AS Missing_Tenure,
    SUM(CouponUsed IS NULL) AS Missing_CouponUsed,
    SUM(OrderCount IS NULL) AS Missing_OrderCount
FROM customer_churn;

SELECT *
FROM customer_churn
WHERE WarehouseToHome > 100;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM customer_churn
WHERE WarehouseToHome > 100;

SET SQL_SAFE_UPDATES = 1;

SELECT
    ROUND(AVG(WarehouseToHome)) AS Avg_WarehouseToHome,
    ROUND(AVG(HourSpendOnApp)) AS Avg_HourSpendOnApp,
    ROUND(AVG(OrderAmountHikeFromlastYear)) AS Avg_OrderAmountHike,
    ROUND(AVG(DaySinceLastOrder)) AS Avg_DaySinceLastOrder
FROM customer_churn;

UPDATE customer_churn
SET WarehouseToHome = (
    SELECT avg_value
    FROM (
        SELECT ROUND(AVG(WarehouseToHome)) AS avg_value
        FROM customer_churn
    ) AS temp
)
WHERE WarehouseToHome IS NULL;

UPDATE customer_churn
SET HourSpendOnApp = (
    SELECT avg_value
    FROM (
        SELECT ROUND(AVG(HourSpendOnApp)) AS avg_value
        FROM customer_churn
    ) AS temp
)
WHERE HourSpendOnApp IS NULL;

UPDATE customer_churn
SET OrderAmountHikeFromlastYear = (
    SELECT avg_value
    FROM (
        SELECT ROUND(AVG(OrderAmountHikeFromlastYear)) AS avg_value
        FROM customer_churn
    ) AS temp
)
WHERE OrderAmountHikeFromlastYear IS NULL;

UPDATE customer_churn
SET DaySinceLastOrder = (
    SELECT avg_value
    FROM (
        SELECT ROUND(AVG(DaySinceLastOrder)) AS avg_value
        FROM customer_churn
    ) AS temp
)
WHERE DaySinceLastOrder IS NULL;

SELECT Tenure, COUNT(*) AS Frequency
FROM customer_churn
WHERE Tenure IS NOT NULL
GROUP BY Tenure
ORDER BY Frequency DESC
LIMIT 1;

SELECT CouponUsed, COUNT(*) AS Frequency
FROM customer_churn
WHERE CouponUsed IS NOT NULL
GROUP BY CouponUsed
ORDER BY Frequency DESC
LIMIT 1;

SELECT OrderCount, COUNT(*) AS Frequency
FROM customer_churn
WHERE OrderCount IS NOT NULL
GROUP BY OrderCount
ORDER BY Frequency DESC
LIMIT 1;

UPDATE customer_churn
SET Tenure = 1
WHERE Tenure IS NULL;
UPDATE customer_churn
SET CouponUsed = 1
WHERE CouponUsed IS NULL;
UPDATE customer_churn
SET OrderCount = 2
WHERE OrderCount IS NULL;

SELECT
    SUM(Tenure IS NULL) AS Missing_Tenure,
    SUM(WarehouseToHome IS NULL) AS Missing_WarehouseToHome,
    SUM(HourSpendOnApp IS NULL) AS Missing_HourSpendOnApp,
    SUM(OrderAmountHikeFromlastYear IS NULL) AS Missing_OrderAmountHike,
    SUM(CouponUsed IS NULL) AS Missing_CouponUsed,
    SUM(OrderCount IS NULL) AS Missing_OrderCount,
    SUM(DaySinceLastOrder IS NULL) AS Missing_DaySinceLastOrder
FROM customer_churn;

UPDATE customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';

UPDATE customer_churn
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';

UPDATE customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';

SELECT PreferredPaymentMode, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY PreferredPaymentMode;