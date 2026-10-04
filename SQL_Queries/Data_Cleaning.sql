use saas_analytics;
USE saas_analytics;

-- 1. Check duplicate customers
SELECT Customer_ID, COUNT(*) AS Duplicate_Count
FROM customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- 2. Check duplicate subscriptions
SELECT Subscription_ID, COUNT(*) AS Duplicate_Count
FROM subscriptions
GROUP BY Subscription_ID
HAVING COUNT(*) > 1;

-- 3. Check duplicate payments
SELECT Payment_ID, COUNT(*) AS Duplicate_Count
FROM payments
GROUP BY Payment_ID
HAVING COUNT(*) > 1;

-- 4. Check duplicate usage records
SELECT Usage_ID, COUNT(*) AS Duplicate_Count
FROM usage_data
GROUP BY Usage_ID
HAVING COUNT(*) > 1;

-- 5. Check duplicate support tickets
SELECT Ticket_ID, COUNT(*) AS Duplicate_Count
FROM support_tickets
GROUP BY Ticket_ID
HAVING COUNT(*) > 1;

-- 6. Check missing Customer IDs
SELECT COUNT(*) AS Missing_Customer_ID
FROM customers
WHERE Customer_ID IS NULL;

-- 7. Check missing Subscription IDs
SELECT COUNT(*) AS Missing_Subscription_ID
FROM subscriptions
WHERE Subscription_ID IS NULL;

-- 8. Check missing Payment IDs
SELECT COUNT(*) AS Missing_Payment_ID
FROM payments
WHERE Payment_ID IS NULL;

-- 9. Check invalid subscription dates
SELECT *
FROM subscriptions
WHERE Start_Date IS NULL;

-- 10. Check active subscriptions with zero-date End_Date
SELECT COUNT(*) AS Active_Zero_End_Date
FROM subscriptions
WHERE Status = 'Active'
AND End_Date = '0000-00-00';