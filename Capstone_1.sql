 USE sample_sales;
-- Emporium Connecticut In store sales

-- What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers
SELECT CONCAT('$', FORMAT (SUM(Sale_Amount), 2 )) as Total_revenue, MIN(Transaction_Date) as Start_Date, MAX(Transaction_Date) as End_Date, State
 FROM store_sales
 JOIN store_locations
 ON store_locations.StoreId = store_sales.Store_ID
 WHere State = 'Connecticut';
 -- Total Revenue = '$2,392,222.44'

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
-- KEY FINDINGS:
-- 2025 had the strongest monthly revenue performance overall.
-- October 2025 was the highest-revenue month at $115,828.46.
-- February 2022 was the lowest-revenue month at $25,563.98.
-- Overall, the monthly results show stronger revenue performance
-- in 2025 compared with the previous three years.

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
-- ANSWER:
-- Connecticut generated $2,392,222.44 in total revenue.
-- The East Region generated $6,723,039.53 in total revenue.
-- Connecticut accounts for approximately 35.6% of the
-- East Region's total revenue.
-- Connecticut is a significant contributor to the East Region.
-- NOTE: Connecticut's revenue is already included in the
-- East Region total.

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
    -- KEY FINDINGS:
-- Technology & Accessories had the highest average transaction
-- amount at $466.00.
-- Stationery and Supplies had the highest number of sales records
-- at 3,719, but the lowest average transaction amount at $9.96.
-- Technology & Accessories generated the highest overall revenue.
--
-- TOTAL SALES RECORDS: 17,378

-- Can you provide a ranking of in-store sales performance by each store in the sales territory, or a ranking of online sales performance by state within an online sales territory?
SELECT CONCAT('$', FORMAT (SUM(SS.Sale_Amount), 2)) as Total_revenue, SS.Store_ID, Rank() Over (Order By SUM(SS.Sale_Amount) DESC) AS Sales_Rank, StoreLocation
FROM store_sales as SS
    JOIN store_locations as SL 
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'Connecticut'
Group BY SS.Store_ID
ORDER BY Total_revenue DESC;
-- KEY FINDINGS:
-- New London was the highest-performing store with
-- $331,116.76 in revenue.
-- Bridgeport ranked second with $322,100.07.
-- Old Saybrook had the lowest revenue at $277,310.18.
--
-- TOTAL CONNECTICUT STORE REVENUE: $2,392,222.44
--
-- The results show differences in sales performance
-- across the eight Connecticut store locations


-- What is your recommendation for where to focus sales attention in the next quarter?
-- 
-- I recommend that Emporium focus on growing sales in Connecticut
-- by prioritizing Technology & Accessories and Textbooks, which
-- generate most of the territory's revenue. The company should
-- also look at what top-performing stores like New London and
-- Bridgeport are doing well and find ways to improve sales at
-- lower-performing locations like Old Saybrook. With revenue
-- increasing significantly in 2025, the company should identify
-- what worked and find ways to keep that momentum going.


