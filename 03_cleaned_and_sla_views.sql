USE eclerx_operations;

CREATE OR REPLACE VIEW support_tickets_cleaned AS
SELECT
    ticket_id,
    STR_TO_DATE(created_at, '%Y-%m-%dT%H:%i:%s') AS created_at,
    customer_id,
    customer_segment,
    channel,
    product_area,
    issue_type,
    priority,
    status,
    sla_plan,
    initial_message,
    agent_first_reply,
    resolution_summary,
    CASE
        WHEN resolution_time_hours = '' THEN NULL
        ELSE CAST(resolution_time_hours AS DECIMAL(10,2))
    END AS resolution_time_hours,
    CASE
        WHEN reopened = '' THEN NULL
        ELSE CAST(reopened AS UNSIGNED)
    END AS reopened,
    customer_sentiment,
    CASE
        WHEN csat_score = '' THEN NULL
        ELSE CAST(csat_score AS UNSIGNED)
    END AS csat_score,
    CASE
        WHEN has_attachment = '' THEN NULL
        ELSE CAST(has_attachment AS UNSIGNED)
    END AS has_attachment,
    platform,
    region
FROM support_tickets_raw;

CREATE OR REPLACE VIEW support_tickets_sla AS
SELECT
    *,
    CASE
        WHEN sla_plan = 'platinum' AND priority = 'urgent' THEN 4
        WHEN sla_plan = 'platinum' AND priority = 'high' THEN 8
        WHEN sla_plan = 'platinum' AND priority = 'medium' THEN 24
        WHEN sla_plan = 'platinum' AND priority = 'low' THEN 48
        WHEN sla_plan = 'gold' AND priority = 'urgent' THEN 8
        WHEN sla_plan = 'gold' AND priority = 'high' THEN 16
        WHEN sla_plan = 'gold' AND priority = 'medium' THEN 36
        WHEN sla_plan = 'gold' AND priority = 'low' THEN 72
        WHEN sla_plan = 'standard' AND priority = 'urgent' THEN 12
        WHEN sla_plan = 'standard' AND priority = 'high' THEN 24
        WHEN sla_plan = 'standard' AND priority = 'medium' THEN 48
        WHEN sla_plan = 'standard' AND priority = 'low' THEN 96
        ELSE 72
    END AS sla_target_hours,

    CASE
        WHEN resolution_time_hours IS NULL THEN 'Not Resolved'
        WHEN resolution_time_hours >
            CASE
                WHEN sla_plan = 'platinum' AND priority = 'urgent' THEN 4
                WHEN sla_plan = 'platinum' AND priority = 'high' THEN 8
                WHEN sla_plan = 'platinum' AND priority = 'medium' THEN 24
                WHEN sla_plan = 'platinum' AND priority = 'low' THEN 48
                WHEN sla_plan = 'gold' AND priority = 'urgent' THEN 8
                WHEN sla_plan = 'gold' AND priority = 'high' THEN 16
                WHEN sla_plan = 'gold' AND priority = 'medium' THEN 36
                WHEN sla_plan = 'gold' AND priority = 'low' THEN 72
                WHEN sla_plan = 'standard' AND priority = 'urgent' THEN 12
                WHEN sla_plan = 'standard' AND priority = 'high' THEN 24
                WHEN sla_plan = 'standard' AND priority = 'medium' THEN 48
                WHEN sla_plan = 'standard' AND priority = 'low' THEN 96
                ELSE 72
            END
        THEN 'Breached'
        ELSE 'Within SLA'
    END AS sla_status
FROM support_tickets_cleaned;