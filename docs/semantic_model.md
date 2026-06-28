# DAX Measures Documentation



### Total Revenue

```DAX
Total Revenue = SUM('olist_analytics_gold fct_sales'[Gross Revenue])
```
Business Definition:
Total sales revenue including product price and freight charges.

---

### Revenue Previous Month

```DAX
Revenue Previous Month = CALCULATE([Total Revenue],DATEADD('olist_analytics_gold dim_date'[date_key],-1,MONTH))
```

---

### Revenue MoM %

```DAX
Revenue MOM % = DIVIDE([Total Revenue]-[Revenue Previous Month],[Revenue Previous Month])
```

---


### Average Order Value

```DAX
Average Order Value = DIVIDE([Total Revenue],[Total Orders])
```

---

### Total Orders

```DAX
Total Orders = DISTINCTCOUNT('olist_analytics_gold fct_sales'[Order ID])
```

---

### Orders Previous Month

```DAX
Orders Previous Month = CALCULATE([Total Orders],DATEADD('olist_analytics_gold dim_date'[date_key],-1,MONTH))
```

---

### Orders MoM %

```DAX
Orders MoM % = DIVIDE([Total Orders]-[Orders Previous Month],[Orders Previous Month])
```

---

### Total Orders

```DAX
Total Orders = DISTINCTCOUNT('olist_analytics_gold fct_sales'[Order ID])
```

---


### Total Customers

```DAX
Total Customers = DISTINCTCOUNT('olist_analytics_gold fct_sales'[Customer UID])
```

---

### Repeat Customers

```DAX
Repeat Customers = 
COUNTROWS(
    FILTER(
        VALUES('olist_analytics_gold fct_sales'[Customer UID]),
        CALCULATE(
            DISTINCTCOUNT('olist_analytics_gold fct_sales'[Order ID])
        ) > 1
    )
)
```

---

### Repeat Customer Rate

```DAX
Repeat Customer Rate = DIVIDE([Repeat Customers],[Total Customers])
```

---



### Average Freight Cost

```DAX
Average Freight Cost =
AVERAGE('fct_sales'[freight_value])
```

---



### Late Deliveries

```DAX
Late Deliveries = CALCULATE(COUNTROWS('olist_analytics_gold fct_sales'),'olist_analytics_gold fct_sales'[Late Delivery]=TRUE())
```

---

### Late Delivery Rate

```DAX
Late Delivery Rate = DIVIDE([Late Deliveries],COUNTROWS('olist_analytics_gold fct_sales'))
```

---

### Average Delivery Days

```DAX
Average Delivery Days = AVERAGE('olist_analytics_gold fct_sales'[Delivery Days])
```

---

### Avg Review Rating

```DAX
Avg Review Rating = 
AVERAGE('olist_analytics_gold fct_sales'[Average Review Score])
```

---