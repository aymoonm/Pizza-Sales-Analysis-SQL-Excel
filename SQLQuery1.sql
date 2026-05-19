Select * From pizza_sales;

-- Kpi Requirement
Select Sum(total_price) As Total_Revenue  From pizza_sales;

Select Sum(total_price) / Count(Distinct order_id) AS Avg_Order_Value From pizza_sales;

Select Sum(quantity) AS Total_Pizza_Sold From pizza_sales;

Select Count(Distinct order_id) num_of_orders From pizza_sales;

Select CAST(Cast(Sum(quantity) AS Decimal (10,2)) 
/Cast (Count(Distinct order_id) As Decimal) AS DECIMAL (10,2))
AS Avg_Pizzas_Per_Order From pizza_sales;
----------------------------------------------

-- Daily Trend
Select DATENAME(Dw, order_date) as order_day, Count(distinct order_id) as Total_orders
From pizza_sales
Group by DATENAME (Dw, order_date);

-- Hourly Trend
Select Datepart (Hour, order_time) as order_hour, Count(distinct order_id) as Total_orders
From pizza_sales
group by Datepart(Hour, order_time)
order by Datepart(Hour, order_time);


-- Pertcentage of Sales by pizza Category
SELECT pizza_category, 
       SUM(total_price) AS Total_Sales,
       SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;


-- Pertcentage of Sales by pizza Size
Select pizza_size,CAST(SUM(total_price)as decimal (10,2)) AS Total_Sales, CAST (sum(total_price) * 100 /
(select sum(total_price) from pizza_sales where datepart(QUARTER, order_date) = 1) as decimal (10,2))  as PCT
from pizza_sales
where datepart(QUARTER, order_date) = 1
Group by pizza_size
order by PCT desc

--  Quantity (Categroy)
Select pizza_category, SUM(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_category

--  Quantity (Name Frist Five)
Select  top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
From pizza_sales
group by pizza_name
order by Total_Pizzas_Sold desc

--  Quantity (Name Last Five)
Select  top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
From pizza_sales
group by pizza_name
order by Total_Pizzas_Sold asc