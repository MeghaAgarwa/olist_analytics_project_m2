# Analytics Reporting Layer & Dashboard Project

## Overview

This project builds an analytics-ready reporting layer on top of the Olist e-commerce dataset and delivers business insights through Power BI dashboards. The solution follows a dimensional modeling approach with curated Gold-layer tables, standardized business metrics, and persona-driven reporting.

---

# Target Personas

## Persona 1: Executive Leadership (COO)

### Goals

* Monitor overall business performance
* Track revenue growth and sales trends
* Identify top-performing products and regions
* Assess operational risks
* Support strategic planning

### Key Questions

* How is revenue trending over time?
* Which product categories drive revenue?
* Which regions contribute the most revenue?
* How are current results performing versus previous periods?
* What does short-term revenue forecasting indicate?

---

## Persona 2: Business Data Analyst

### Goals

* Analyze customer and operational performance
* Investigate drivers behind business trends
* Identify logistics inefficiencies
* Support root-cause analysis

### Key Questions

* How does customer retention perform?
* Which states experience delivery challenges?
* How do freight costs vary by region?
* What payment behaviors are most common?
* Where should operational improvements be prioritized?

---

# Metric Definitions

| Metric                    | Definition                                                       |
| ------------------------- | ---------------------------------------------------------------- |
| Total Revenue             | Sum of product price and freight value for completed sales       |
| Total Orders              | Distinct count of order_id                                       |
| Total Customers           | Distinct count of customer_unique_id                             |
| Average Order Value (AOV) | Total Revenue / Total Orders                                     |
| Revenue MoM %             | Month-over-Month percentage change in revenue                    |
| Orders MoM %              | Month-over-Month percentage change in orders                     |
| Repeat Customers          | Customers with more than one distinct order                      |
| Repeat Customer Rate      | Repeat Customers / Total Customers                               |
| Late Delivery Rate        | Percentage of orders delivered after the estimated delivery date |
| Average Delivery Days     | Average days between purchase date and delivery date             |
| Average Freight Cost      | Average freight value per order                                  |

---
# Semantic Model
See docs/semantic_model.md for semantic layer definitions and metric governance.

# Dashboard Walkthrough

## Dashboard 1: Executive Sales Overview

Purpose: Provide leadership with a high-level view of business performance and future outlook.

### Visuals

* KPI Cards

  * Total Revenue
  * Total Orders
  * Total Customers
  * Average Order Value
  * Revenue MoM %
  * Orders MoM %
  * Repeat Customer Rate
  * Late Delivery Rate

* Monthly Revenue Trend & Forecast

* Top 10 Product Categories by Revenue

* Top 10 Customer States by Revenue

### Key Insights

* Revenue demonstrates consistent growth across the reporting period.
* Revenue is concentrated within a small number of product categories.
* São Paulo is the largest revenue-generating state.
* Forecast indicates stable short-term business performance.

---

## Dashboard 2: Customer & Operations Insights

Purpose: Support operational analysis and customer behavior investigation.

### Visuals

* KPI Cards

  * Total Customers
  * Total Orders
  * Repeat Customers
  * Repeat Customer Rate
  * Average Order Value
  * Late Delivery Rate

* Revenue by Customer State

* Average Delivery Days by State

* Average Freight Cost by State

* Orders by Payment Installments

### Key Insights

* Customer retention is relatively low, with most customers making a single purchase.
* Delivery performance varies significantly across states.
* Freight costs differ by region and may contribute to operational inefficiencies.
* Customers primarily use low installment payment plans.

---

# Assumptions

* Revenue is calculated as Product Price + Freight Value.
* Customer analysis uses customer_unique_id to avoid duplicate customer records.
* Repeat customers are defined as customers with more than one completed order.
* Late deliveries are determined by comparing actual delivery date with estimated delivery date.
* Forecasting is based on Power BI's built-in forecasting functionality using monthly revenue trends.

---

# Known Data Limitations & Risks

* Dataset covers approximately September 2016 through September 2018 and does not represent current business performance.
* Customer Lifetime Value (CLV) was not implemented due to limited customer history.
* Some months contain incomplete data, which may affect trend interpretation.
* Freight cost analysis identifies correlations but does not establish causation.
* Customer demographic information is unavailable.
* Product profitability cannot be calculated due to missing cost data.
* Year-over-Year (YoY) comparisons were evaluated but not prominently used in dashboards because the dataset contains only two years of history and 2016 includes a partial year. This can produce misleading growth percentages and reduce interpretability.

# Stretch Goals Coverage

✅ Time comparison: Revenue MoM %, Orders MoM %
✅ Derived metric: Repeat Customer Rate
✅ Forecast: Monthly Revenue Forecast
✅ Anomaly identification: Revenue trend analysis highlighting significant spikes and seasonal fluctuations