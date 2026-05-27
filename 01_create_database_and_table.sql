CREATE DATABASE IF NOT EXISTS eclerx_operations;
USE eclerx_operations;

DROP TABLE IF EXISTS support_tickets_raw;

CREATE TABLE support_tickets_raw (
    ticket_id TEXT,
    created_at TEXT,
    customer_id TEXT,
    customer_segment TEXT,
    channel TEXT,
    product_area TEXT,
    issue_type TEXT,
    priority TEXT,
    status TEXT,
    sla_plan TEXT,
    initial_message TEXT,
    agent_first_reply TEXT,
    resolution_summary TEXT,
    resolution_time_hours TEXT,
    reopened TEXT,
    customer_sentiment TEXT,
    csat_score TEXT,
    has_attachment TEXT,
    platform TEXT,
    region TEXT
);