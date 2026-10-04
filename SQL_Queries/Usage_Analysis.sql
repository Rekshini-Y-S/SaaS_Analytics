USE saas_analytics;

-- 1. Total Usage Records
SELECT COUNT(*) AS Total_Usage_Records
FROM usage_data;

-- 2. Average Active Devices
SELECT AVG(Active_Devices) AS Average_Active_Devices
FROM usage_data;

-- 3. Average Logins
SELECT AVG(Logins) AS Average_Logins
FROM usage_data;

-- 4. Average Storage Used
SELECT AVG(Storage_Used_GB) AS Average_Storage_GB
FROM usage_data;

-- 5. Average Files Stored
SELECT AVG(Files_Stored) AS Average_Files_Stored
FROM usage_data;

-- 6. Average Shared Files
SELECT AVG(Shared_Files) AS Average_Shared_Files
FROM usage_data;

-- 7. Usage by Month
SELECT Usage_Month,
       COUNT(*) AS Usage_Records
FROM usage_data
GROUP BY Usage_Month
ORDER BY Usage_Month;