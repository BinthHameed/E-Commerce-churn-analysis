USE ecomm;

SELECT
    ChurnStatus,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY ChurnStatus;

SELECT
    ROUND(AVG(Tenure), 2) AS Average_Tenure,
    SUM(CashbackAmount) AS Total_Cashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT
    ROUND(
        100.0 * SUM(ComplaintReceived = 'Yes') / COUNT(*),
        2
    ) AS Complaint_Percentage
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT
    CityTier,
    COUNT(*) AS Customer_Count
FROM customer_churn
WHERE ChurnStatus = 'Churned'
  AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Customer_Count DESC;

SELECT
    PreferredPaymentMode,
    COUNT(*) AS Customer_Count
FROM customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY Customer_Count DESC;

SELECT
    SUM(OrderAmountHikeFromlastYear) AS Total_OrderAmount_Hike
FROM customer_churn
WHERE MaritalStatus = 'Single'
  AND PreferredOrderCat = 'Mobile Phone';
  
  SELECT
    ROUND(AVG(NumberOfDeviceRegistered), 2) AS Average_Devices
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';

SELECT
    CityTier,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY CityTier
ORDER BY Customer_Count DESC;

SELECT
    Gender,
    SUM(CouponUsed) AS Total_Coupons
FROM customer_churn
GROUP BY Gender
ORDER BY Total_Coupons DESC;

SELECT
    PreferredOrderCat,
    COUNT(*) AS Customer_Count,
    MAX(HoursSpentOnApp) AS Maximum_Hours_Spent
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY PreferredOrderCat;

SELECT
    SUM(OrderCount) AS Total_Order_Count
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
  AND SatisfactionScore = (
      SELECT MAX(SatisfactionScore)
      FROM customer_churn
  );
  
SELECT
    ROUND(AVG(SatisfactionScore), 2) AS Average_Satisfaction_Score
FROM customer_churn
WHERE ComplaintReceived = 'Yes';

SELECT
    PreferredOrderCat,
    COUNT(*) AS Customer_Count
FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY Customer_Count DESC;

SELECT
    PreferredOrderCat,
    ROUND(AVG(CashbackAmount), 2) AS Average_Cashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Average_Cashback DESC
LIMIT 3;

SELECT
    PreferredPaymentMode,
    Tenure,
    OrderCount
FROM customer_churn
WHERE Tenure = 10
  AND OrderCount > 500;
  
ALTER TABLE customer_churn
ADD COLUMN DistanceCategory VARCHAR(30);
UPDATE customer_churn
SET DistanceCategory =
    CASE
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END;
    
SELECT
    DistanceCategory,
    ChurnStatus,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY DistanceCategory, ChurnStatus
ORDER BY
    CASE DistanceCategory
        WHEN 'Very Close Distance' THEN 1
        WHEN 'Close Distance' THEN 2
        WHEN 'Moderate Distance' THEN 3
        WHEN 'Far Distance' THEN 4
    END,
    ChurnStatus;
    
SELECT
    AVG(OrderCount) AS Average_Order_Count
FROM customer_churn;

SELECT *
FROM customer_churn
WHERE MaritalStatus = 'Married'
  AND CityTier = 1
  AND OrderCount > (
      SELECT AVG(OrderCount)
      FROM customer_churn
  );
  
  
  CREATE TABLE customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount INT,
    FOREIGN KEY (CustomerID)
        REFERENCES customer_churn(CustomerID)
);
INSERT INTO customer_returns
(ReturnID, CustomerID, ReturnDate, RefundAmount)
VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);

SELECT
    r.ReturnID,
    r.CustomerID,
    r.ReturnDate,
    r.RefundAmount,
    c.ChurnStatus,
    c.ComplaintReceived,
    c.Tenure,
    c.PreferredLoginDevice,
    c.CityTier,
    c.WarehouseToHome,
    c.PreferredPaymentMode,
    c.Gender,
    c.HoursSpentOnApp,
    c.NumberOfDeviceRegistered,
    c.PreferredOrderCat,
    c.SatisfactionScore,
    c.MaritalStatus,
    c.NumberOfAddress,
    c.OrderAmountHikeFromlastYear,
    c.CouponUsed,
    c.OrderCount,
    c.DaySinceLastOrder,
    c.CashbackAmount
FROM customer_returns r
JOIN customer_churn c
    ON r.CustomerID = c.CustomerID
WHERE c.ChurnStatus = 'Churned'
  AND c.ComplaintReceived = 'Yes';