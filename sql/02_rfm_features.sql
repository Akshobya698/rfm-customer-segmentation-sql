-- RFM features for Milestone 3 (one row per customer, paid orders only).
-- analysis_date = DATE '2026-06-15', the day after the latest paid order
-- (MAX(created_at) = 2026-06-14 23:28 UTC). Pinned so Recency stays
-- comparable across Milestones 3-5.
-- Filters: payment_status = 'paid' (excludes 2,178 cancelled/failed orders).
-- Fulfilment status is NOT filtered (delivered/shipped/packed/paid/placed
-- plus case variants all count once paid); normalise with LOWER(status)
-- before any funnel work.
SELECT
  o.customer_id,
  (DATE '2026-06-15' - MAX(o.created_at)::DATE) AS recency,
  COUNT(*) AS frequency,
  SUM(o.total) AS monetary
FROM ecom.orders AS o
WHERE o.payment_status = 'paid'
GROUP BY o.customer_id;
