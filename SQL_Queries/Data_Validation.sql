use saas_analytics;
SELECT COUNT(*) AS Total_Customers
FROM customers;
SELECT COUNT(*) AS Total_Subscriptions
FROM subscriptions;
SELECT COUNT(*) AS Total_Payments
FROM payments;
SELECT COUNT(*) AS Total_Usage_Records
FROM `usage_data`;
SELECT COUNT(*) AS Total_churn_Records
FROM `churn`;
SELECT COUNT(*) AS Total_Support_Tickets
FROM `support_tickets`;
SELECT COUNT(*) AS Total_Plans
FROM `plans`;
SELECT Status, COUNT(*) AS Total
FROM subscriptions
GROUP BY Status;
SELECT Payment_Status, COUNT(*) AS Total
FROM payments
GROUP BY Payment_Status;
-- Customer Type Validation
SELECT Customer_Type, COUNT(*) AS Total
FROM customers
GROUP BY Customer_Type;

-- Subscription Status Validation
SELECT Status, COUNT(*) AS Total
FROM subscriptions
GROUP BY Status;

-- Payment Status Validation
SELECT Payment_Status, COUNT(*) AS Total
FROM payments
GROUP BY Payment_Status;

-- Usage Record Validation
SELECT COUNT(*) AS Total_Usage_Records
FROM usage_data;

-- Churn Record Validation
SELECT COUNT(*) AS Total_Churn_Records
FROM churn;

-- Support Ticket Validation
SELECT Status, COUNT(*) AS Total
FROM support_tickets
GROUP BY Status;