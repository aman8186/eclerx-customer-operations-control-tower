# AI-Driven Customer Operations Control Tower

## Project Overview

This project is an eClerx-inspired customer operations analytics solution. It analyzes 100,000 support tickets to monitor SLA performance, customer satisfaction, reopen rate, ticket backlog, and high-risk unresolved tickets.

The project combines SQL, Python, machine learning, and Power BI to help operations managers identify process issues and prioritize tickets before service quality drops.

## Business Problem

Customer operations teams handle thousands of tickets through email, chat, phone, in-app, and web channels. Some tickets are not resolved within the promised SLA time, which can lead to customer dissatisfaction, reopened cases, escalations, and reduced client trust.

## Solution

The solution acts as a customer operations control tower. It helps managers:

- Track total tickets, SLA breaches, unresolved backlog, CSAT, and reopen rate
- Identify product areas and channels creating operational pressure
- Monitor customer sentiment and satisfaction trends
- Predict unresolved tickets that are likely to breach SLA
- Prioritize high-risk tickets before they become delayed

## Tools Used

- MySQL Workbench
- SQL
- Python
- Pandas
- Scikit-learn
- Google Colab
- Power BI Desktop
- GitHub

## Dataset

Dataset: Synthetic IT Support Tickets  
Rows: 100,000  
Domain: Customer support / SaaS operations  
Source: Kaggle

## Key KPIs

- Total tickets: 100,000
- Within SLA tickets: 46,530
- Breached tickets: 13,583
- Not resolved tickets: 39,887
- SLA breach rate: 13.58%
- Average resolution time: 45.01 hours
- Average CSAT score: 2.24 / 5
- Reopen rate: 5.05%

## Machine Learning Model

A Random Forest Classifier was trained to predict SLA breach risk for unresolved tickets.

### Features Used

- Customer segment
- Channel
- Product area
- Issue type
- Priority
- SLA plan
- Customer sentiment
- Attachment flag
- Platform
- Region
- Created hour

### Model Result

- Accuracy: 78.36%

### Risk Output

The model scored 39,887 unresolved tickets and classified them into:

- Low Risk: 31,446
- Medium Risk: 7,402
- High Risk: 1,039

## Dashboard Pages

1. Executive Overview
2. SLA Performance
3. Customer Experience
4. Risk Prediction Queue

## Business Impact

This dashboard helps operations managers reduce SLA breaches, improve customer satisfaction, reduce reopened tickets, identify process bottlenecks, and prioritize high-risk unresolved tickets.

## Dashboard Preview

### Executive Overview
![Executive Overview](reports/screenshots/executive_overview.png)

### SLA Performance
![SLA Performance](reports/screenshots/sla_performance.png)

### Customer Experience
![Customer Experience](reports/screenshots/customer_experience.png)

### Risk Prediction Queue
![Risk Prediction Queue](reports/screenshots/risk_prediction.png)