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
SELECT CONCAT('$', FORMAT (SUM(Sale_Amount), 2 )) as Total_revenue, MIN(Transaction_Date) as Start_Date, MAX(Transaction_Date) as End_Date, State
 FROM store_sales
 JOIN store_locations
 ON store_locations.StoreId = store_sales.Store_ID
 WHere State = 'Connecticut';
 

-- what is the revenue breakdown by year and month for the sales territory?

 SELECT CONCAT('$', FORMAT (SUM(Sale_Amount), 2)) as 'REVENUE',
        YEAR(Transaction_Date) as CONN_YEAR,
        MONTH(Transaction_Date) as CONN_MONTH
 FROM store_sales
 JOIN store_locations
 ON store_locations.StoreId = store_sales.Store_ID
 WHere State = 'Connecticut'
 group by CONN_YEAR, CONN_MONTH
 ORDER BY CONN_YEAR, CONN_MONTH; 


 -- Provide a comparison of total revenue for the specific sales territory and the region it belongs to. 
SELECT 'Connecticut' as TERRITORY_REGION, CONCAT('$', FORMAT (SUM(Sale_Amount),2)) as total_revenue, Region
FROM store_sales
Join store_locations 
ON store_locations.StoreId = store_sales.Store_ID
JOIN management
     ON store_locations.State = management.State
WHERE store_locations.State ='Connecticut'
Group By Region
Union ALL
SELECT 'East' as Region, CONCAT('$', FORMAT (SUM(Sale_Amount), 2)) as total_revenue, Region
FROm store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreId
JOIN management
      ON management.State = store_locations.State
      Where Region = 'East'
    Group by Region;

-- What is the number of transactions per month and average transaction amount by product category for the sales territory?
SELECT COUNT(*) as transaction_count,
    CONCAT('$', FORMAT (AVG(Sale_Amount), 2)) as "Avg Transaction_Amount",
   MONTH(Transaction_Date) as "transaction_month",
    products.Categoryid, State
    FROM store_sales
    Join store_locations
   ON store_sales.Store_ID = store_locations.StoreId
   JOIN products
    on products.ProdNum = store_sales.Prod_Num
    Where State = 'Connecticut'
     Group by MONTH(Transaction_Date),
        products.Categoryid
    Order By transaction_month;

-- Can you provide a ranking of in-store sales performance by each store in the sales territory, or a ranking of online sales performance by state within an online sales territory?
SELECT CONCAT('$', FORMAT (SUM(SS.Sale_Amount), 2)) as Total_revenue, SS.Store_ID, Rank() Over (Order By SUM(SS.Sale_Amount) DESC) AS Sales_Rank
FROM store_sales as SS
    JOIN store_locations as SL 
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'Connecticut'
Group BY SS.Store_ID
ORDER BY Total_revenue DESC;

-- What is your recommendation for where to focus sales attention in the next quarter?
-- I recommend that Emporium focus on growing sales in Connecticut
-- by prioritizing Technology & Accessories and Textbooks, which
-- generate most of the territory's revenue. The company should
-- also look at what top-performing stores like New London and
-- Bridgeport are doing well and find ways to improve sales at
-- lower-performing locations like Old Saybrook. With revenue
-- increasing significantly in 2025, the company should identify
-- what worked and find ways to keep that momentum going.


