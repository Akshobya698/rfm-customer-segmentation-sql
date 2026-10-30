-- Customer-level base for Milestone 2 exploration.
-- One row per customer with paid orders only (excludes cancelled/failed).
-- Reused by notebooks/01_exploration.ipynb.
SELECT
  o.customer_id,
  COUNT(*) AS order_count,
  SUM(o.total) AS total_spend,
  MIN(o.created_at) AS first_order_date,
  MAX(o.created_at) AS last_order_date
FROM ecom.orders AS o
WHERE o.payment_status = 'paid'
GROUP BY o.customer_id;
