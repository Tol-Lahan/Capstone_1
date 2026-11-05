 SELECT * 
 FROM management;
SELECT *
FROM store_sales;
SELECT *
FROM store_locations;
SELECT *
FROM shipper_list;
SELECT *
FROM products;
-- What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers
SELECT SUM(Sale_Amount), MIN(Transaction_Date) as Start_Date, MAX(Transaction_Date) as End_Date
 FROM store_sales
 JOIN store_locations
 ON store_locations.StoreId = store_sales.Store_ID
 WHere State = 'Connecticut';

-- what is the revenue breakdown by year and month for the sales territory?

 SELECT SUM(Sale_Amount) as 'REVENUE',
        YEAR(Transaction_Date) as CONN_YEAR,
        MONTH(Transaction_Date) as CONN_MONTH
 FROM store_sales
 JOIN store_locations
 ON store_locations.StoreId = store_sales.Store_ID
 WHere State = 'Connecticut'
 group by CONN_YEAR, CONN_MONTH
 ORDER BY CONN_YEAR, CONN_MONTH; 

 -- Provide a comparison of total revenue for the specific sales territory and the region it belongs to. 
SELECT 'Connecticut' as TERRITORY_REGION, SUM(Sale_Amount) as total_revenue, Region
FROM store_sales
Join store_locations 
ON store_locations.StoreId = store_sales.Store_ID
JOIN management
     ON store_locations.State = management.State
WHERE store_locations.State ='Connecticut'
Group By Region
Union ALL
SELECT 'East' as Region, SUM(Sale_Amount) as total_revenue, Region
FROm store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreId
JOIN management
      ON management.State = store_locations.State
      Where Region = 'East'
    Group by Region;

-- What is the number of transactions per month and average transaction amount by product category for the sales territory?
