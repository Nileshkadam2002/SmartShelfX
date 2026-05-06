CREATE DATABASE bike_db;
use bike_db;
SELECT count(*) from bike_sales; 
/* PROJECT: Revenue Optimization & Market Penetration (Indian Bike Sales)
AUTHOR: Nilesh Kadam
DESCRIPTION: Analysis of bike segments (CC, Brand, City) to identify growth opportunities.
*/

-- Q1: Write a query to display all records from the dataset.
SELECT * FROM bike_sales;

-- Q2: Select only the following columns: city, brand, engine_cc, price.
SELECT state,brand,`Engine Capacity (cc)`,`Price (INR)` FROM bike_sales ;

-- Q3: Find all bikes sold in a specific state .
SELECT brand,state FROM bike_sales
WHERE state="Maharashtra";

SELECT brand,state FROM bike_sales
WHERE state="Maharashtra"
GROUP BY brand;

-- Q4: List all unique bike brands available in the dataset.
SELECT distinct(brand) FROM bike_sales;

-- Q5: Find the total number of records (rows) in the dataset.
SELECT COUNT(*) FROM bike_sales;

-- Q6: Show all bikes where engine capacity is less than 150cc.
SELECT brand,model,`Engine Capacity (cc)` FROM bike_sales
WHERE `Engine Capacity (cc)`<150;


-- Q7: Find bikes with price greater than 1,00,000.
SELECT brand,Model,`Price (INR)` FROM bike_sales
WHERE `Price (INR)`>100000;

-- Q8: Sort all bikes by price in descending order.
SELECT 
    brand, 
    `Price (INR)` AS `Price(INR)` 
FROM bike_sales
ORDER BY `Price(INR)` DESC;

-- Q9: Display top 10 most expensive bikes.
SELECT brand,`Price (INR)` FROM bike_sales
ORDER BY `Price (INR)` DESC LIMIT 10;

-- Find all bikes where Fuel Type is Petrol.
SELECT brand,model,`Fuel Type` FROM bike_sales
WHERE `Fuel Type`='Petrol';

SELECT brand,model,`Fuel Type` FROM bike_sales
WHERE `Fuel Type`='Electric' ;

-- Get all bikes manufactured after 2018.
SELECT brand,model,`Year of Manufacture` FROM bike_sales
WHERE `Year of Manufacture`>2018; 

-- Find bikes with Mileage (km/l) greater than 50.
SELECT brand,model,`Mileage (km/l)` FROM bike_sales
WHERE `Mileage (km/l)`>50;

-- List distinct bike brands.
SELECT distinct(brand) FROM bike_sales;

-- Count total number of records.
SELECT count(*) FROM bike_sales;

-- Find the minimum and maximum Price (INR).
SELECT MAX(`Price (INR)`)as Maximum_price,MIN(`Price (INR)`) as minmum_price FROM bike_sales; 

-- Find bikes from a specific state (e.g., Karnataka).
SELECT * FROM bike_sales
where state='Karnataka';
---------------------------------------------------------
-- AGGREGATION
---------------------------------------------------------

-- Count number of bikes per Brand.
SELECT brand,count(*) FROM bike_sales
GROUP BY brand; 
-- Find average price of bikes for each brand.
SELECT brand,ROUND(avg(`Price (INR)`)) as avg_price_per_brand FROM bike_sales
GROUP BY brand;

-- Get total resale value grouped by State.
SELECT state,ROUND(SUM(`Resale Price (INR)`)) as TOTAL_revenue FROM bike_sales
GROUP BY state;

-- Count bikes based on Fuel Type.
SELECT `Fuel Type`,count(Brand) FROM bike_sales
GROUP BY `Fuel Type`;

-- Find average mileage per Engine Capacity (cc).
SELECT 
    `Engine Capacity (cc)`, 
    AVG(`Mileage (km/l)`) AS avg_mileage
FROM bike_sales
GROUP BY `Engine Capacity (cc)`
ORDER BY `Engine Capacity (cc)`;
-- Get number of bikes per City Tier.
select `City Tier`,count(Brand) FROM bike_sales
GROUP BY `City Tier`;


-- Get average resale price by Owner Type.
SELECT `Owner Type`,round(AVG(`Resale Price (INR)`)) as  AVG_Resale_price FROM bike_sales
GROUP BY `Owner Type`; 


-- Rank bikes based on Price (INR) within each Brand.
SELECT *,rank() over(order by `Price (INR)`) FROM bike_sales
GROUP BY brand;
SELECT *, 
       RANK() OVER (PARTITION BY Brand ORDER BY `Price (INR)` desc) as Bike_Rank
FROM bike_sales;


-- Find the second highest priced bike.
SELECT * FROM bike_sales
ORDER BY `Price (INR)` DESC LIMIT 1,1;

SELECT * FROM bike_sales
ORDER BY `Price (INR)` DESC LIMIT 10;

-- Get top 3 expensive bikes per State.
WITH RankedBikes AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY `Price (INR)` DESC) as rnk
    FROM bike_sales
)
SELECT * 
FROM RankedBikes 
WHERE rnk <= 3;


-- Calculate price difference between original price and resale price.
SELECT *,ROUND((`Price (INR)`-`Resale Price (INR)`)) price_diffrence FROM bike_sales;


-- Find percentage depreciation for each bike.

SELECT *,ROUND((`Price (INR)`-`Resale Price (INR)`)),ROUND(((`Price (INR)`-`Resale Price (INR)`)/`Price (INR)`)*100) as per_depreciation  FROM bike_sales;

-- Use window function to calculate running average of prices.
SELECT `Price (INR)`,avg(`Price (INR)`) OVER( ORDER BY `Price (INR)` ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS run_avg FROM bike_sales;
SELECT 
    brand,
    `Price (INR)`,
    AVG(`Price (INR)`) OVER(
        PARTITION BY brand
        ORDER BY `Price (INR)`
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ) AS run_avg
FROM bike_sales;
-- Find bikes whose price is above average price.


-- Identify duplicate records based on Model and Year.


-- Find the most common Engine Capacity per brand.

-- Get cumulative resale value by year.



---------------------------------------------------------
-- LEVEL 3: GROUP BY + BUSINESS INSIGHT
---------------------------------------------------------

-- Q21: Find total revenue for each city and brand combination.
-- [Write your query here]

-- Q22: Find total units sold for each engine_cc category.
-- [Write your query here]

-- Q23: Group engine CC into segments: 100-125, 150-200, 200+ and count bikes in each.
-- [Write your query here]

-- Q24: Find average price for each engine CC segment.
-- [Write your query here]

-- Q25: Find top 3 cities by revenue.
-- [Write your query here]

-- Q26: Find bottom 3 cities by revenue.
-- [Write your query here]

-- Q27: Find which brand sells the most (units) in each city.
-- [Write your query here]

-- Q28: Find revenue contribution (%) of each brand to the total revenue.
-- [Write your query here]


---------------------------------------------------------
-- LEVEL 4: UNDERPERFORMANCE DETECTION (RESUME IMPACT)
---------------------------------------------------------

-- Q29: Find revenue for each city + engine_cc segment.
-- [Write your query here]

-- Q30: Calculate total sales per city and compare segment sales within that city.
-- [Write your query here]

-- Q31: Find segments where sales are below the average sales of that segment across all cities.
-- [Write your query here]

-- Q32: Find cities where a particular segment has zero or very low sales.
-- [Write your query here]

-- Q33: Rank brands within each city based on revenue.
-- [Write your query here]

-- Q34: Find the lowest performing brand in each city.
-- [Write your query here]

-- Q35: Calculate market share percentage of each segment within a city.
-- [Write your query here]
ss

---------------------------------------------------------
-- LEVEL 5: ADVANCED (WINDOW FUNCTIONS & ANALYTICS)
---------------------------------------------------------

-- Q36: Use a window function to rank cities by total revenue.
-- [Write your query here]

-- Q37: Find top-performing segment in each city using RANK() or DENSE_RANK().
-- [Write your query here]

-- Q38: Calculate running total of revenue by city.
-- [Write your query here]

-- Q39: Find percentage contribution of each city to total revenue using window functions.
-- [Write your query here]

-- Q40: Identify "high potential but low performance" segments (High avg revenue nationally, low in specific city).
-- [Write your query here]