# RFM distributions — what each feature says (Milestone 3)

Analysis date: 15 Jun 2026, the day after the latest paid order
(MAX created_at 14 Jun 2026 23:28 UTC). There is no canonical "today" for
a historical snapshot, so I pin the day after the last event: every
customer then has a strictly positive recency, the numbers stay frozen
while later milestones build on them, and the choice is documented in both
the notebook and sql/02_rfm_features.sql. Filters: paid orders only
(8,438 customers; 2,178 cancelled or failed orders excluded).

## Recency: days since last order

Mean 38.8 days, median 34.5, interquartile range 16–62, P90 76, span 1–91.
The shape is a broad hump, not a decay curve: most of the base last bought
two to nine weeks before the snapshot, with thin tails of very recent and
window-edge buyers. Because the window itself is only about 90 days, a
recency of 91 means "present at the very start, absent since" rather than
true long-lapse churn. Recency here therefore measures position inside one
quarter, and any "lost" label in Milestone 4 must be relative to this
short buying cycle, not to multi-year dormancy.

## Frequency: number of orders

Mean 4.48, median 1, P90 9, P99 about 40, max 168. The distribution is a
cliff followed by a long tail: 4,679 customers (55%) ordered exactly once,
then small counts at 2–3, then a heavy-repeat minority of 2,978 (35%) with
4+ orders pulling the mean far above the median. That polarisation is the
business story — retention, not acquisition depth, separates the base. The
one-timer cliff must survive into segmentation as its own cut, or averaging
will pretend a bimodal base is unimodal.

## Monetary: total spend

Mean Rs 33,522, median Rs 12,091, P90 Rs 76,149, P99 Rs 3,15,312, maximum
above Rs 13 lakh. The histogram is a wall at the left with a whisper of a
tail even on a log scale: classic right skew where the mean describes
almost nobody. One-timers contribute only about 12% of the Rs 28.3 crore
total despite being 55% of customers. The practical consequence is that
raw-spend quintiles would cram nearly everyone into the bottom two buckets;
Milestone 4 should transform, cap, or rank monetary rather than cutting it
raw. Watch the line between high spenders and true whales — roughly the
P99 break near Rs 3.1 lakh — because a handful of accounts can swing any
unweighted segment average.
