import pandas as pd
import numpy as np

np.random.seed(42)

print("SaaS Data Generation Started...")

# =========================================================
# 1. CUSTOMERS
# =========================================================

num_customers = 2000

customer_ids = [f"CUST{i:05d}" for i in range(1, num_customers + 1)]

countries = ["India", "USA", "UK", "Canada", "Australia", "Germany", "Singapore"]
cities = {
    "India": ["Chennai", "Bangalore", "Mumbai", "Delhi", "Hyderabad"],
    "USA": ["New York", "Chicago", "Austin", "Seattle", "Boston"],
    "UK": ["London", "Manchester", "Birmingham"],
    "Canada": ["Toronto", "Vancouver", "Montreal"],
    "Australia": ["Sydney", "Melbourne", "Brisbane"],
    "Germany": ["Berlin", "Munich", "Hamburg"],
    "Singapore": ["Singapore"]
}

customer_country = np.random.choice(
    countries,
    size=num_customers,
    p=[0.35, 0.20, 0.12, 0.10, 0.08, 0.08, 0.07]
)

customer_city = [
    np.random.choice(cities[country])
    for country in customer_country
]

customers = pd.DataFrame({
    "Customer_ID": customer_ids,
    "Customer_Name": [f"Customer_{i:05d}" for i in range(1, num_customers + 1)],
    "Customer_Type": np.random.choice(
        ["Individual", "Small Business", "Enterprise"],
        size=num_customers,
        p=[0.50, 0.35, 0.15]
    ),
    "Country": customer_country,
    "City": customer_city,
    "Signup_Date": pd.to_datetime(
        np.random.choice(
            pd.date_range("2023-01-01", "2026-06-30"),
            size=num_customers
        )
    )
})

# =========================================================
# 2. PLANS
# =========================================================

plans = pd.DataFrame({
    "Plan_ID": ["P001", "P002", "P003", "P004", "P005"],
    "Plan_Name": ["Free", "Basic", "Standard", "Premium", "Enterprise"],
    "Billing_Cycle": ["Monthly", "Monthly", "Monthly", "Annual", "Annual"],
    "Price_INR": [0, 499, 999, 4999, 14999],
    "Storage_Limit_GB": [5, 50, 200, 1000, 5000],
    "Max_Users": [1, 3, 10, 25, 100]
})

# =========================================================
# 3. SUBSCRIPTIONS
# =========================================================

num_subscriptions = 3000

subscription_ids = [
    f"SUB{i:05d}" for i in range(1, num_subscriptions + 1)
]

subscription_customer = np.random.choice(
    customer_ids,
    size=num_subscriptions
)

subscription_plan = np.random.choice(
    plans["Plan_ID"],
    size=num_subscriptions,
    p=[0.15, 0.30, 0.30, 0.18, 0.07]
)

start_dates = pd.to_datetime(
    np.random.choice(
        pd.date_range("2024-01-01", "2026-06-30"),
        size=num_subscriptions
    )
)

statuses = np.random.choice(
    ["Active", "Churned", "Paused"],
    size=num_subscriptions,
    p=[0.70, 0.20, 0.10]
)

end_dates = []

for status, start in zip(statuses, start_dates):

    if status == "Active":
        end_dates.append(pd.NaT)

    else:
        days = np.random.randint(30, 500)
        end_date = start + pd.Timedelta(days=days)

        if end_date > pd.Timestamp("2026-09-30"):
            end_date = pd.Timestamp("2026-09-30")

        end_dates.append(end_date)

subscriptions = pd.DataFrame({
    "Subscription_ID": subscription_ids,
    "Customer_ID": subscription_customer,
    "Plan_ID": subscription_plan,
    "Start_Date": start_dates,
    "End_Date": end_dates,
    "Status": statuses,
    "Auto_Renewal": np.random.choice(
        ["Yes", "No"],
        size=num_subscriptions,
        p=[0.75, 0.25]
    )
})

# =========================================================
# 4. PAYMENTS
# =========================================================

payment_ids = [
    f"PAY{i:06d}" for i in range(1, num_subscriptions + 1)
]

payment_dates = subscriptions["Start_Date"] + pd.to_timedelta(
    np.random.randint(0, 30, size=num_subscriptions),
    unit="D"
)

payment_methods = np.random.choice(
    ["UPI", "Credit Card", "Debit Card", "Net Banking", "PayPal"],
    size=num_subscriptions,
    p=[0.35, 0.25, 0.15, 0.15, 0.10]
)

payment_status = np.random.choice(
    ["Paid", "Failed", "Refunded"],
    size=num_subscriptions,
    p=[0.90, 0.07, 0.03]
)

plan_price_map = dict(
    zip(plans["Plan_ID"], plans["Price_INR"])
)

base_amounts = subscriptions["Plan_ID"].map(plan_price_map)

discounts = np.random.choice(
    [0, 5, 10, 15, 20],
    size=num_subscriptions,
    p=[0.45, 0.20, 0.20, 0.10, 0.05]
)

amount_paid = base_amounts * (1 - discounts / 100)

payments = pd.DataFrame({
    "Payment_ID": payment_ids,
    "Subscription_ID": subscriptions["Subscription_ID"],
    "Payment_Date": payment_dates,
    "Payment_Method": payment_methods,
    "Payment_Status": payment_status,
    "Discount_Percent": discounts,
    "Plan_ID": subscriptions["Plan_ID"],
    "Base_Amount_INR": base_amounts,
    "Amount_Paid_INR": amount_paid.round(2)
})

# =========================================================
# 5. USAGE
# =========================================================

num_usage = 20000

usage_customer = np.random.choice(
    customer_ids,
    size=num_usage
)

usage_dates = pd.to_datetime(
    np.random.choice(
        pd.date_range("2025-01-01", "2026-08-31"),
        size=num_usage
    )
)

usage = pd.DataFrame({
    "Usage_ID": [f"USE{i:06d}" for i in range(1, num_usage + 1)],
    "Customer_ID": usage_customer,
    "Usage_Month": usage_dates,
    "Storage_Used_GB": np.round(
        np.random.gamma(2, 20, num_usage), 2
    ),
    "Files_Stored": np.random.randint(10, 5000, num_usage),
    "Active_Devices": np.random.randint(1, 8, num_usage),
    "Logins": np.random.randint(1, 100, num_usage),
    "Shared_Files": np.random.randint(0, 500, num_usage)
})

# =========================================================
# 6. SUPPORT TICKETS
# =========================================================

num_tickets = 5000

ticket_customer = np.random.choice(
    customer_ids,
    size=num_tickets
)

support_tickets = pd.DataFrame({
    "Ticket_ID": [
        f"TKT{i:06d}" for i in range(1, num_tickets + 1)
    ],
    "Customer_ID": ticket_customer,
    "Created_Date": pd.to_datetime(
        np.random.choice(
            pd.date_range("2025-01-01", "2026-08-31"),
            size=num_tickets
        )
    ),
    "Category": np.random.choice(
        ["Technical", "Billing", "Account", "Storage", "Feature Request"],
        size=num_tickets
    ),
    "Priority": np.random.choice(
        ["Low", "Medium", "High", "Critical"],
        size=num_tickets,
        p=[0.35, 0.40, 0.20, 0.05]
    ),
    "Status": np.random.choice(
        ["Open", "In Progress", "Resolved", "Closed"],
        size=num_tickets,
        p=[0.10, 0.15, 0.45, 0.30]
    ),
    "Resolution_Hours": np.round(
        np.random.uniform(1, 72, num_tickets), 2
    )
})

# =========================================================
# 7. CHURN
# =========================================================

churned = subscriptions[
    subscriptions["Status"] == "Churned"
].copy()

churn = pd.DataFrame({
    "Churn_ID": [
        f"CHN{i:05d}" for i in range(1, len(churned) + 1)
    ],
    "Subscription_ID": churned["Subscription_ID"].values,
    "Customer_ID": churned["Customer_ID"].values,
    "Churn_Date": churned["End_Date"].values,
    "Churn_Reason": np.random.choice(
        [
            "High Price",
            "Low Usage",
            "Poor Support",
            "Missing Features",
            "Competitor",
            "Business Closed"
        ],
        size=len(churned)
    ),
    "Refund_Requested": np.random.choice(
        ["Yes", "No"],
        size=len(churned),
        p=[0.15, 0.85]
    )
})

# =========================================================
# SAVE DATASETS AS CSV
# =========================================================

customers.to_csv("customers.csv", index=False)
plans.to_csv("plans.csv", index=False)
subscriptions.to_csv("subscriptions.csv", index=False)
payments.to_csv("payments.csv", index=False)
usage.to_csv("usage.csv", index=False)
support_tickets.to_csv("support_tickets.csv", index=False)
churn.to_csv("churn.csv", index=False)

# =========================================================
# DISPLAY SUMMARY
# =========================================================

print("\nDATA GENERATION COMPLETED!")
print("--------------------------------")
print("Customers       :", len(customers))
print("Plans           :", len(plans))
print("Subscriptions   :", len(subscriptions))
print("Payments        :", len(payments))
print("Usage           :", len(usage))
print("Support Tickets :", len(support_tickets))
print("Churn           :", len(churn))
print("--------------------------------")

print("\nCSV files created successfully.")