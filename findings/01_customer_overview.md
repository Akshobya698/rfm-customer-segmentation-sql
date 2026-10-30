# Customer overview — who shops here (Milestone 2)

## Who shops here

10,000 registered customers, of whom 8,438 placed at least one paid order:
37,822 paid orders between 16 Mar and 14 Jun 2026 (about 90 days).
1,562 customers have no paid order, and 1,493 touched one of the 2,178
cancelled or failed orders. Acquisition is mostly organic (4,023) and paid
(3,490), with referral (1,192), email (708) and affiliate (587) behind.
Lifecycle splits into active (4,869), at_risk (3,903), new (1,200) and
churned (28). Repeat behaviour is polarised: 4,679 paid customers (55%)
ordered exactly once, while 2,978 (35%) ordered 4+ times, averaging
4.48 orders per paid customer.

## How much they spend

Spending is heavily right-skewed: median Rs 12,091 against a mean of
Rs 33,522, ranging from Rs 176 to Rs 13,35,804. P90 is about Rs 76,149,
P95 about Rs 1,14,464 and P99 about Rs 3,15,312. The "average customer"
at roughly Rs 33.5k therefore describes almost nobody — most customers sit
far below it while a thin tail of whales drags the mean upward. Any
segmentation built on raw monetary alone would collapse into "whales
versus everyone else".

## What I noticed

Two threads carry into Milestone 3. First, the heavy-repeat minority
drives the business despite the one-timer majority, so RFM features must
keep frequency and recency separate from monetary or big spenders will
swallow every segment. Second, hygiene: order status has case variants
(shipped / Shipped / SHIPPED, delivered / DELIVERED) that must be
normalised with LOWER(status) before any funnel work, and the 1,562
zero-purchase customers need an explicit decision — browse-only audience
or failed conversions — rather than silently dropping out of the base.
