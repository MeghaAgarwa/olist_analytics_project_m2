# DAX Measures Documentation

## Revenue Metrics

### Total Revenue

```DAX
Total Revenue =
SUM('fct_sales'[revenue])
```

Business Definition:
Total sales revenue including product price and freight charges.

---

### Revenue Previous Month

```DAX
Revenue Previous Month =
CALCULATE(
    [Total Revenue],
    DATEADD('dim_date'[date_key], -1, MONTH)
)
```

---

### Revenue MoM %

```DAX
Revenue MoM % =
DIVIDE(
    [Total Revenue] - [Revenue Previous Month],
    [Revenue Previous Month]
)
```

---

## Order Metrics

### Total Orders

```DAX
Total Orders =
DISTINCTCOUNT('fct_sales'[order_id])
```

---

### Orders Previous Month

```DAX
Orders Previous Month =
CALCULATE(
    [Total Orders],
    DATEADD('dim_date'[date_key], -1, MONTH)
)
```

---

### Orders MoM %

```DAX
Orders MoM % =
DIVIDE(
    [Total Orders] - [Orders Previous Month],
    [Orders Previous Month]
)
```

---

## Customer Metrics

### Total Customers

```DAX
Total Customers =
DISTINCTCOUNT('fct_sales'[customer_unique_id])
```

---

### Repeat Customers

```DAX
Repeat Customers =
COUNTROWS(
    FILTER(
        VALUES('fct_sales'[customer_unique_id]),
        CALCULATE(DISTINCTCOUNT('fct_sales'[order_id])) > 1
    )
)
```

---

### Repeat Customer Rate

```DAX
Repeat Customer Rate =
DIVIDE(
    [Repeat Customers],
    [Total Customers]
)
```

---

## Financial Metrics

### Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Orders]
)
```

---

### Average Freight Cost

```DAX
Average Freight Cost =
AVERAGE('fct_sales'[freight_value])
```

---

## Operations Metrics

### Late Orders

```DAX
Late Orders =
CALCULATE(
    [Total Orders],
    'fct_sales'[late_delivery_flag] = 1
)
```

---

### Late Delivery Rate

```DAX
Late Delivery Rate =
DIVIDE(
    [Late Orders],
    [Total Orders]
)
```

---

### Average Delivery Days

```DAX
Average Delivery Days =
AVERAGE('fct_sales'[delivery_days])
```

---

## Forecasting

Revenue Forecast is implemented using Power BI's built-in forecasting functionality applied to the Monthly Revenue Trend visual.
