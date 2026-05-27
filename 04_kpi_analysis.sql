USE eclerx_operations;

-- Main KPIs
SELECT
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_status = 'Within SLA' THEN 1 ELSE 0 END) AS within_sla_tickets,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breached_tickets,
    SUM(CASE WHEN sla_status = 'Not Resolved' THEN 1 ELSE 0 END) AS not_resolved_tickets,
    ROUND(SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS sla_breach_rate,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours,
    ROUND(AVG(csat_score), 2) AS avg_csat_score,
    ROUND(SUM(CASE WHEN reopened = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS reopen_rate
FROM support_tickets_sla;

-- SLA status distribution
SELECT
    sla_status,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY sla_status
ORDER BY total_tickets DESC;

-- Monthly ticket volume
SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY month;

-- Tickets by product area
SELECT
    product_area,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY product_area
ORDER BY total_tickets DESC;

-- Tickets by channel
SELECT
    channel,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY channel
ORDER BY total_tickets DESC;

-- SLA breach rate by product area
SELECT
    product_area,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breached_tickets,
    ROUND(SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS breach_rate
FROM support_tickets_sla
GROUP BY product_area
ORDER BY breach_rate DESC;

-- Reopen rate by channel
SELECT
    channel,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN reopened = 1 THEN 1 ELSE 0 END) AS reopened_tickets,
    ROUND(SUM(CASE WHEN reopened = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS reopen_rate
FROM support_tickets_sla
GROUP BY channel
ORDER BY reopen_rate DESC;

-- CSAT by sentiment
SELECT
    customer_sentiment,
    COUNT(*) AS total_tickets,
    ROUND(AVG(csat_score), 2) AS avg_csat
FROM support_tickets_sla
GROUP BY customer_sentiment
ORDER BY avg_csat ASC;

-- Average resolution time by priority
SELECT
    priority,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours
FROM support_tickets_sla
WHERE resolution_time_hours IS NOT NULL
GROUP BY priority
ORDER BY avg_resolution_hours DESC;

-- High-risk unresolved tickets
SELECT
    ticket_id,
    created_at,
    customer_segment,
    channel,
    product_area,
    issue_type,
    priority,
    sla_plan,
    customer_sentiment,
    csat_score,
    region
FROM support_tickets_sla
WHERE sla_status = 'Not Resolved'
  AND priority IN ('urgent', 'high')
ORDER BY created_at ASC
LIMIT 20;