

| Metric                | Definition                             | Formula                               | Grain   |
| --------------------- | -------------------------------------- | ------------------------------------- | ------- |
| Total Revenue         | Total sales including freight          | SUM(price + freight_value)            | Daily   |
| Total Orders          | Number of unique orders                | COUNT(DISTINCT order_id)              | Daily   |
| Average Order Value   | Average revenue per order              | Revenue / Orders                      | Daily   |
| Delivery Time         | Average days from purchase to delivery | AVG(delivery_days)                    | Daily   |
| Delayed Delivery Rate | Percentage of delayed orders           | Delayed Orders / Delivered Orders     | Daily   |
| Cancellation Rate     | Percentage of cancelled orders         | Cancelled Orders / Total Orders       | Monthly |
| Repeat Customer Rate  | Percentage of returning customers      | Returning Customers / Total Customers | Monthly |
| Revenue Growth %      | Period-over-period growth              | (Current - Previous) / Previous       | Monthly |
| Average Freight Cost  | Average freight cost per order item    | AVG(freight_value)                    | Daily   |


Metric to Model Mapping

| Metric        | Source Table     | Dimensions             |
| ------------- | ---------------- | ---------------------- |
| Revenue       | fact_order_items | Date, Category, Seller |
| Orders        | fact_orders      | Date, State            |
| Delivery Time | fact_orders      | Seller, State          |
| Freight Cost  | fact_order_items | Category, State        |
