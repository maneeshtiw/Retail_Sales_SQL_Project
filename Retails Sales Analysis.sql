CREATE DATABASE ANALYSIS;
USE ANALYSIS;
-- Retails Sales Analysis (Project Based On SQL)
CREATE TABLE Retails_Data(Transactions_id INT
                            PRIMARY KEY, Sale_date DATE, Sale_time TIME, Customer_id INT, Gender VARCHAR(225), Age INT, Category VARCHAR(225),
                            Quantiy INT, Price_per_unit INT, Cogs INT, Total_sale INT);

SELECT * FROM Retails_Data;

-- Record count : Determine the total number of records in the dataset.
SELECT COUNT(*) AS Total_Count FROM Retails_Data;

-- Customer count : find out how many unique customer.
SELECT COUNT(DISTINCT Customer_id) AS UNIQUE_CUSTOMER FROM Retails_Data;

-- Category count : identify all unique product category.
SELECT DISTINCT(Category) FROM Retails_Data;

-- Null value check : check for any null value in dataset and delete records with missing data.
SELECT * FROM Retails_Data
WHERE Transactions_id IS NULL OR
                                   Sale_date IS NULL OR Sale_time IS NULL OR 
                                   Customer_id IS NULL OR Gender IS NULL OR 
								   Age IS NULL OR Category IS NULL OR
                                   Quantiy IS NULL OR Price_per_unit IS NULL OR
								   Cogs IS NULL OR Total_sale IS NULL;

-- DATA ANALYSIS AND FINDINGS:
-- The following sql queries were developed to answer specific business questions.

-- Q1 Write a sql queries to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM Retails_Data 
WHERE Sale_date = '2022-11-05';

-- Q2 -- Q2 write a sql query to retrieve all transactions where the category is 'clothing' and 
     -- the quantity sold is more than 4 in the month of nov-22:
SELECT *
FROM Retails_Data
WHERE Category = 'Clothing'
  AND Quantiy > 4
  AND Sale_date BETWEEN '2022-11-01' AND '2022-11-30';
  
-- Q3 Write a sql query to calculate the total sales (total_sale) for each category:
SELECT Category, 
       SUM(Total_sale) AS Total_Sale
FROM Retails_Data 
GROUP BY Category;

-- -- Q4 Write a sql query to find the average age of customer who purchased items from
-- the beauty category;
SELECT 
	 Category, 
      ROUND(AVG(Age),2) AS Average_Age 
FROM Retails_Data 
WHERE Category = 'Beauty'
GROUP BY Category;

-- Q5 Write a sql query to find all transactions where the total_sale > 1000;
SELECT * FROM Retails_Data WHERE Total_sale > 1000;

-- Q6 Write a sql query to find the total no. of transactions (transaction_id) made by each 
-- gender in each category;
SELECT  
       DISTINCT Category,
       Gender, 
       COUNT(*) AS Total_Number 
FROM Retails_Data 
GROUP BY Gender, Category 
ORDER BY Category ASC;

-- Q7 Write a sql query to calculate the average sale for each month. find out best selling
-- month in each year;
WITH CTE AS (
SELECT 
       YEAR(Sale_date) AS YEARS,
       MONTH(Sale_date) AS MONTHS,
       SUM(Total_sale) AS Total_Sales,
       DENSE_RANK() OVER(PARTITION BY YEAR(Sale_date) ORDER BY SUM(Total_sale) DESC) AS Sales_Rank
FROM Retails_Data
 GROUP BY YEAR(Sale_date), MONTH(Sale_date) ORDER BY YEARS, MONTHS DESC)
SELECT * FROM CTE WHERE Sales_Rank = 1;

-- Q8 Write a sql query to find the top 5 customer based on the highest total sales;
SELECT 
      Customer_id, 
      SUM(Total_sale) AS Highest_Sale 
FROM Retails_Data 
GROUP BY Customer_id
ORDER BY 2 DESC LIMIT 5;


-- Q9 write a sql query to find the number of unique customer who purchased item from
-- each category
SELECT 
      Category, 
      COUNT(DISTINCT Customer_id) AS Unique_Customer 
FROM Retails_Data 
GROUP BY Category
ORDER BY 2 ASC;


/* Q10 write a sql query to create each shift and number of orders ( eg morning<12, 
afternoon between 12 and 17, evening>17).*/
SELECT 
       CASE 
       WHEN HOUR (sale_time) < 12 THEN 'MORNING'
       WHEN HOUR (sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
       ELSE 'EVENING' END AS SHIFT,
COUNT(*) AS num_of_orders
	                         FROM Retails_Data
							GROUP BY Shift;
                            
/* Findings
1. customer demographics:
the list shows all kinds of people, young and old, buying things like shirts, dresses and
makeup.

2. high value transactions:
a few people spent lot of money, over 1000 on fancy stuff

3. sales trends:
sales change every month, sometimes they are high, and sometimes they are low this shows
us which months are super busy for shopping

4. customer insight:
we found out who spends the most money and which products are the most popular

Report( what we made to show the info,)
. sale summary:
we made a report that shows how much stuff was sold, who bought it and which items sold
sold the best

. trends analysis:
we made a report to see how sale go up and down each month and spot any patterns
*/
       
SELECT * FROM Retails_Data;





