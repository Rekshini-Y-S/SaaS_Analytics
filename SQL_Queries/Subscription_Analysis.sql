USE saas_analytics;

-- 1. Total Subscriptions
SELECT COUNT(*) AS Total_Subscriptions
FROM subscriptions;

-- 2. Subscriptions by Status
SELECT Status, COUNT(*) AS Total
FROM subscriptions
GROUP BY Status
ORDER BY Total DESC;

-- 3. Subscriptions by Plan
SELECT p.Plan_Name,
       COUNT(*) AS Total_Subscriptions
FROM subscriptions s
JOIN plans p
    ON s.Plan_ID = p.Plan_ID
GROUP BY p.Plan_Name
ORDER BY Total_Subscriptions DESC;

-- 4. Subscriptions by Billing Cycle
SELECT p.Billing_Cycle,
       COUNT(*) AS Total_Subscriptions
FROM subscriptions s
JOIN plans p
    ON s.Plan_ID = p.Plan_ID
GROUP BY p.Billing_Cycle
ORDER BY Total_Subscriptions DESC;

-- 5. Active Subscriptions
SELECT COUNT(*) AS Active_Subscriptions
FROM subscriptions
WHERE Status = 'Active';

-- 6. Auto Renewal Status
SELECT Auto_Renewal,
       COUNT(*) AS Total
FROM subscriptions
GROUP BY Auto_Renewal
ORDER BY Total DESC;

-- 7. Average Subscription Duration
SELECT AVG(
    DATEDIFF(
        COALESCE(NULLIF(End_Date, '0000-00-00'), CURDATE()),
        Start_Date
    )
) AS Average_Subscription_Duration_Days
FROM subscriptions;