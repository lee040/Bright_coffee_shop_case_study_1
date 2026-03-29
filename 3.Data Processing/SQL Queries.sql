--- View table columns 
SELECT *
FROM default.coffee_shop;

--- Date Range for the Data collection ----
SELECT MIN(transaction_date) AS Start_date,
       MAX(transaction_date) AS End_date
FROM default.coffee_shop;
--- Start date = 2023-01-10   End date = 2023-06-30


------ Store loction names and number of stores-----
SELECT COUNT(DISTINCT store_id) AS Number_of_stores,
       store_location AS Location
FROM default.coffee_shop
GROUP BY store_location;
---- Number of stores = 3 , location = Lower manhattan,Hell's kitchen,Astoria

------------ Product sold and category------------
SELECT DISTINCT(product_detail) AS Product
FROM default.coffee_shop;

SELECT DISTINCT(product_category) AS Category
FROM default.coffee_shop;

SELECT DISTINCT(product_type) AS Type
FROM default.coffee_shop;

SELECT DISTINCT(product_category) AS Category,
       product_detail AS Product,
       product_type AS Type
FROM default.coffee_shop;

------ Product prices -------
SELECT DISTINCT(unit_price) AS Price
FROM default.coffee_shop
ORDER BY Price DESC;

SELECT MIN(unit_price) AS Cheapest,
       MAX(unit_price) AS Expensive
FROM default.coffee_shop;

--- cheapest = 0.8 --- expensive = 45

 -----Top selling product per location-----
  SELECT store_location,
         product_detail,
         SUM(transaction_qty) AS Total_units_sold,
         SUM(transaction_qty*unit_price) AS Total_revenue
FROM default.coffee_shop
GROUP BY store_Location,
         product_detail
ORDER BY Total_units_sold DESC;


----------Overview of the Dataset's size ---------------
SELECT COUNT(*) AS Number_of_rows,
       COUNT(DISTINCT store_id) AS Number_of_stores,
       COUNT(DISTINCT product_id) AS Number_of_products,
       COUNT(DISTINCT transaction_id) AS Number_of_transaction
FROM default.coffee_shop;

---- Total revenue per location ----
SELECT store_location AS Location,
       SUM(transaction_qty*unit_price) AS Total_Revenue,
       COUNT(*) AS transaction_count
FROM default.coffee_shop
GROUP BY store_location
ORDER BY Total_Revenue DESC;

---- Overall total revenue ----
SELECT SUM(transaction_qty*unit_price) AS Total_Revenue
FROM default.coffee_shop;

---------Sales trends and profitability per product-----------------
SELECT product_category AS category,
       SUM(transaction_qty*unit_price) AS Total_Revenue,
       SUM(transaction_qty) AS Product_sold,
       AVG(unit_price) AS Average_price
FROM default.coffee_shop
GROUP BY product_category
ORDER BY Total_Revenue DESC;

---- CASE statement to group price range----
SELECT product_detail,
       AVG(unit_price) AS Average_price,
       CASE WHEN AVG(unit_price)> 25 THEN 'Expensive'
            WHEN AVG(unit_price) BETWEEN 12 AND 25 THEN 'Affordable'
            ELSE 'Cheap'
            END AS Price_range
  FROM default.coffee_shop
  GROUP BY product_detail
  ORDER BY average_price DESC;

---Daily sales summary 
SELECT transaction_date,
       DAYNAME(transaction_date) AS Day_name,
       MONTHNAME(transaction_date) AS Month_name,
       COUNT(DISTINCT transaction_id) AS Number_of_sales,
       SUM(transaction_qty*unit_price) AS Revenue_per_day
FROM default.coffee_shop
GROUP BY transaction_date;

--- Product summary
SELECT product_category AS Cartegory,
       product_detail AS Product,
       MIN(unit_price) AS Lower_price,
       MAX(unit_price) AS Higher_price,
       SUM(transaction_qty) AS Total_sold,
       SUM(transaction_qty*unit_price) AS Total_revenue
FROM default.coffee_shop
GROUP BY product_category,
         product_detail
ORDER BY product_category;

---- Combined SQL queries ----
SELECT COUNT(transaction_id) AS Number_of_transactions,
       COUNT(DISTINCT product_id) AS Products_sold,
       SUM(transaction_qty) AS Total_units_sold,
       SUM(transaction_qty*unit_price) AS Revenue,
       store_location,
       product_id,
       product_category,
       product_detail,
       product_type,
       unit_price,
       TO_CHAR(TO_DATE(transaction_date),'yyyymm') AS Month,
       MONTHNAME(TO_DATE(transaction_date)) AS Month_name,
       DAYNAME(TO_DATE(transaction_date)) AS Day_name,
       CASE
       WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
       WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
       WHEN HOUR(transaction_time) BETWEEN 17 AND 19 THEN 'Evining'
       ELSE 'Night'
       END AS Time_of_day,
       CASE
       WHEN unit_price < 10 THEN 'Cheap'
       WHEN unit_price < 20 THEN 'Affordable'
       WHEN unit_price < 30 THEN 'Expensive'
       ELSE 'Luxury'
       END AS Price_range
FROM default.coffee_shop
GROUP BY store_location,
         product_id,
         product_category,
         product_detail,
         product_type,
         unit_price,
         transaction_date,
         transaction_time
ORDER BY revenue DESC;


 
