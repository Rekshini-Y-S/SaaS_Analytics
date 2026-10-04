USE saas_analytics;

-- View: Customer Subscription Analysis
CREATE OR REPLACE VIEW customer_subscription_analysis AS
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Type,
    c.Country,
    c.City,
    c.Signup_Date,
    s.Subscription_ID,
    s.Plan_ID,
    s.Start_Date,
    s.End_Date,
    s.Status,
    s.Auto_Renewal,
    p.Plan_Name,
    p.Billing_Cycle,
    p.Price_INR
FROM customers c
JOIN subscriptions s
    ON c.Customer_ID = s.Customer_ID
JOIN plans p
    ON s.Plan_ID = p.Plan_ID;