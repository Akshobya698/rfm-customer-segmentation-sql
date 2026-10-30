-- Milestone 4 scoring + segmentation (paid orders only, analysis_date 2026-06-15).
-- R: NTILE(5) over recency ASC  (stalest fifth = 1, freshest = 5).
-- M: NTILE(5) over monetary ASC (smallest = 1, largest = 5).
-- F: custom 5-scale because 55% of customers have frequency = 1 and
--    quantile bins collapse: 1 order -> 1, 2-3 -> 2, 4-6 -> 3, 7-12 -> 4, 13+ -> 5.
-- NOTE: the notebook scores exact quintiles with pandas qcut and is
-- authoritative; NTILE below is the SQL mirror (edges can differ by a row
-- on ties). Segment rules are identical in both.
WITH base AS (
  SELECT o.customer_id,
         (DATE '2026-06-15' - MAX(o.created_at)::DATE) AS recency,
         COUNT(*) AS frequency,
         SUM(o.total) AS monetary
  FROM ecom.orders AS o
  WHERE o.payment_status = 'paid'
  GROUP BY o.customer_id
),
scored AS (
  SELECT customer_id, recency, frequency, monetary,
         NTILE(5) OVER (ORDER BY recency ASC) AS r_score,
         CASE WHEN frequency = 1 THEN 1
              WHEN frequency <= 3 THEN 2
              WHEN frequency <= 6 THEN 3
              WHEN frequency <= 12 THEN 4
              ELSE 5 END AS f_score,
         NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
  FROM base
)
SELECT customer_id, recency, frequency, monetary,
       r_score, f_score, m_score,
       (r_score::TEXT || '-' || f_score::TEXT || '-' || m_score::TEXT) AS rfm,
       CASE WHEN r_score >= 4 AND f_score >= 4 AND m_score = 5 THEN 'Champions'
            WHEN f_score >= 4 THEN 'Loyal Heavy Repeaters'
            WHEN f_score = 1 AND r_score <= 2 THEN 'At-Risk One-Timers'
            WHEN f_score = 1 THEN 'Recent One-Timers'
            ELSE 'Growing Repeaters' END AS segment
FROM scored;
