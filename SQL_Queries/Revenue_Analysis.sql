USE saas_analytics;

-- 1. Total Revenue
SELECT SUM(Amount_Paid_INR) AS Total_Revenue
FROM payments
WHERE Payment_Status = 'Paid';

-- 2. Revenue by Payment Status
SELECT Payment_Status,
       SUM(Amount_Paid_INR) AS Total_Amount
FROM payments
GROUP BY Payment_Status
ORDER BY Total_Amount DESC;

-- 3. Revenue by Payment Method
SELECT Payment_Method,
       SUM(Amount_Paid_INR) AS Total_Revenue
FROM payments
WHERE Payment_Status = 'Paid'
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- 4. Revenue by Plan
SELECT p.Plan_Name,
       SUM(pay.Amount_Paid_INR) AS Total_Revenue
FROM payments pay
JOIN plans p
    ON pay.Plan_ID = p.Plan_ID
WHERE pay.Payment_Status = 'Paid'
GROUP BY p.Plan_Name
ORDER BY Total_Revenue DESC;

-- 5. Average Paid Transaction
SELECT AVG(Amount_Paid_INR) AS Average_Paid_Transaction
FROM payments
WHERE Payment_Status = 'Paid';

-- 6. Refunded Amount
SELECT SUM(Amount_Paid_INR) AS Refunded_Amount
FROM payments
WHERE Payment_Status = 'Refunded';

-- 7. Paid Transactions
SELECT COUNT(*) AS Paid_Transactions
FROM payments
WHERE Payment_Status = 'Paid';

-- 8. Revenue by Payment Date
SELECT DATE(Payment_Date) AS Payment_Date,
       SUM(Amount_Paid_INR) AS Daily_Revenue
FROM payments
WHERE Payment_Status = 'Paid'
GROUP BY DATE(Payment_Date)
ORDER BY Payment_Date;
