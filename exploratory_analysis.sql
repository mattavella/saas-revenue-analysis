/* EDA of the Monthly Revenue */

SELECT *
FROM monthly_revenue;

-- Find date range
SELECT 
	MIN(month) AS start_date,
	MAX(month) AS end_date
FROM monthly_revenue;

-- Customer count
SELECT MAX(total_active_customers)
FROM monthly_revenue;

-- Average new customers
SELECT AVG(new_customers) as AVG_new_customers
FROM monthly_revenue;

-- Net customer by month
SELECT
	month,
	SUM(new_customers - churned_customers) AS net_customers
FROM monthly_revenue
GROUP BY month;

-- What is the Average, Min, and MAX revenue per customer
SELECT 
	AVG(avg_revenue_per_customer),
	MIN(avg_revenue_per_customer),
	MAX(avg_revenue_per_customer)
FROM monthly_revenue;

-- Monthly revenue trend
SELECT
    month,
    SUM(total_mrr) AS monthly_revenue
FROM monthly_revenue
GROUP BY month
ORDER BY month;

-- Monthly churn trend
SELECT 
  month,
  total_active_customers,
  churned_customers,
  monthly_churn_rate_pct
FROM monthly_revenue
ORDER BY month;

-- Churn rate
SELECT
    AVG(monthly_churn_rate_pct) AS avg_churn_rate,
    MAX(monthly_churn_rate_pct) AS max_churn_rate
FROM monthly_revenue;

-- The average, min and max cost of customer acquisition
SELECT 
	MIN(customer_acquisition_cost) as min_cost,
	AVG(customer_acquisition_cost) as avg_cost,
    MAX(customer_acquisition_cost) as max_cost
FROM monthly_revenue;

/* EDA of the Subscriptions */

SELECT *
FROM subscriptions;

-- Number of customers
SELECT COUNT(DISTINCT(customer_id)) AS total_customers
FROM subscriptions;

-- List the aquisition channels
SELECT DISTINCT(acquisition_channel)
FROM subscriptions;

-- List of plans
SELECT DISTINCT(plan)
FROM subscriptions;

-- Industry types
SELECT DISTINCT(industry)
FROM subscriptions;

-- Company size
SELECT 
	MIN(company_size) AS min_size,
    AVG(company_size) AS avg_size,
    MAX(company_size) AS max_size
FROM subscriptions;

-- Customer regions
SELECT DISTINCT(region)
FROM subscriptions;

-- Average monthly revenue 
SELECT AVG(monthly_revenue)
FROM subscriptions;

-- Feature usage vs upgrades
SELECT
    upgraded,
    COUNT(customer_id) AS customers,
    ROUND(AVG(feature_usage_pct),1) AS avg_feature_usage
FROM subscriptions
GROUP BY upgraded;

-- Revenue by region
SELECT
    region,
    COUNT(customer_id) AS customers,
    ROUND(SUM(monthly_revenue),2) AS total_revenue
FROM subscriptions
GROUP BY region
ORDER BY total_revenue DESC;

-- Number of customers who churned or not
SELECT
    churned,
    COUNT(customer_id) AS customers
FROM subscriptions
GROUP BY churned;

-- Average churn rate
SELECT
    ROUND(
        AVG(CASE
                WHEN churned = 'Yes' THEN 1
                ELSE 0
            END) * 100,
        2
    ) AS churn_rate_pct
FROM subscriptions;

-- Number of customers per subscription plan
SELECT
	plan,
    COUNT(customer_id) AS customers
FROM subscriptions
GROUP BY plan
ORDER BY customers DESC;