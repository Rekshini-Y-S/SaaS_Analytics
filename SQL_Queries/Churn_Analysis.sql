USE saas_analytics;

-- 1. Total Churn Records
SELECT COUNT(*) AS Total_Churn
FROM churn;

-- 2. Churn by Reason
SELECT Churn_Reason,
       COUNT(*) AS Total_Churn
FROM churn
GROUP BY Churn_Reason
ORDER BY Total_Churn DESC;

-- 3. Churn by Year
SELECT YEAR(Churn_Date) AS Churn_Year,
       COUNT(*) AS Total_Churn
FROM churn
GROUP BY YEAR(Churn_Date)
ORDER BY Churn_Year;

