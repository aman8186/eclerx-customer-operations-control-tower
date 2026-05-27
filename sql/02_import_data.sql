USE eclerx_operations;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'D:/eclerx-customer-operations-control-tower/data/raw/synthetic_it_support_tickets.csv'
INTO TABLE support_tickets_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ticket_id, created_at, customer_id, customer_segment, channel, product_area,
 issue_type, priority, status, sla_plan, initial_message, agent_first_reply,
 resolution_summary, resolution_time_hours, reopened, customer_sentiment,
 csat_score, has_attachment, platform, region);

SELECT COUNT(*) AS total_tickets
FROM support_tickets_raw;
