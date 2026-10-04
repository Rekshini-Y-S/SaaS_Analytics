USE saas_analytics;

-- 1. Total Customers
SELECT COUNT(*) AS Total_Customers
FROM customers;

-- 2. Customers by Customer Type
SELECT Customer_Type, COUNT(*) AS Total_Customers
FROM customers
GROUP BY Customer_Type
ORDER BY Total_Customers DESC;

-- 3. Customers by Country
SELECT Country, COUNT(*) AS Total_Customers
FROM customers
GROUP BY Country
ORDER BY Total_Customers DESC;

-- 4. Customers by City
SELECT City, COUNT(*) AS Total_Customers
FROM customers
GROUP BY City
ORDER BY Total_Customers DESC;

-- 5. Customer Signups by Year
SELECT YEAR(Signup_Date) AS Signup_Year,
       COUNT(*) AS Total_Signups
FROM customers
GROUP BY YEAR(Signup_Date)
ORDER BY Signup_Year;

-- 6. Customer Type by Country
SELECT Country,
       Customer_Type,
       COUNT(*) AS Total_Customers
FROM customers
GROUP BY Country, Customer_Type
ORDER BY Country, Total_Customers DESC;