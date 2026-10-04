USE saas_analytics;

-- 1. Total Support Tickets
SELECT COUNT(*) AS Total_Support_Tickets
FROM support_tickets;

-- 2. Tickets by Status
SELECT Status,
       COUNT(*) AS Total_Tickets
FROM support_tickets
GROUP BY Status
ORDER BY Total_Tickets DESC;

-- 3. Tickets by Category
SELECT Category,
       COUNT(*) AS Total_Tickets
FROM support_tickets
GROUP BY Category
ORDER BY Total_Tickets DESC;

-- 4. Tickets by Priority
SELECT Priority,
       COUNT(*) AS Total_Tickets
FROM support_tickets
GROUP BY Priority
ORDER BY Total_Tickets DESC;

-- 5. Tickets by Month
SELECT YEAR(Created_Date) AS Ticket_Year,
       MONTH(Created_Date) AS Ticket_Month,
       COUNT(*) AS Total_Tickets
FROM support_tickets
GROUP BY YEAR(Created_Date), MONTH(Created_Date)
ORDER BY Ticket_Year, Ticket_Month;