USE saas_analytics;

-- 1. Total Payments
SELECT COUNT(*) AS Total_Payments
FROM payments;

-- 2. Payments by Status
SELECT Payment_Status,
       COUNT(*) AS Total_Payments
FROM payments
GROUP BY Payment_Status
ORDER BY Total_Payments DESC;

-- 3. Payments by Method
SELECT Payment_Method,
       COUNT(*) AS Total_Payments
FROM payments
GROUP BY Payment_Method
ORDER BY Total_Payments DESC;

-- 4. Total Amount Paid
SELECT SUM(Amount_Paid_INR) AS Total_Amount_Paid
FROM payments
WHERE Payment_Status = 'Paid';

-- 5. Total Refunded Amount
SELECT SUM(Amount_Paid_INR) AS Total_Refunded_Amount
FROM payments
WHERE Payment_Status = 'Refunded';

-- 6. Average Payment Amount
SELECT AVG(Amount_Paid_INR) AS Average_Payment_Amount
FROM payments
WHERE Payment_Status = 'Paid';

-- 7. Revenue by Payment Method
SELECT Payment_Method,
       SUM(Amount_Paid_INR) AS Total_Revenue
FROM payments
WHERE Payment_Status = 'Paid'
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- 8. Payments by Month
SELECT YEAR(Payment_Date) AS Payment_Year,
       MONTH(Payment_Date) AS Payment_Month,
       COUNT(*) AS Total_Payments,
       SUM(Amount_Paid_INR) AS Total_Amount
FROM payments
GROUP BY YEAR(Payment_Date), MONTH(Payment_Date)
ORDER BY Payment_Year, Payment_Month;