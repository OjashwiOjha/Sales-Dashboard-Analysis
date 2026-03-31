CREATE DATABASE Sales_Project;
USE Sales_Project;
CREATE TABLE Sales_Data (
Row_ID INT,
Order_ID varchar(50),
Order_Date DATE,
Ship_Date Date,
Ship_Mode varchar(50),
Customer_ID varchar(50),
Customer_name varchar(50),
Segment varchar(50),
Country Varchar(50),
City varchar(50),
State varbinary(50),
Postal_Code varchar(20),
Region varchar(50), 
Product_ID varchar(50),
Category varchar(50),
Sub_Category varchar(50),
Product_Name TEXT,
Sales Decimal(10,2)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_final.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Row_ID, @Order_ID, @Order_Date, @Ship_Date, @Ship_Mode, @Customer_ID, @Customer_Name, @Segment, @Country, @City, @State, @Postal_Code, @Region, @Product_ID, @Category, @Sub_Category, @Product_Name, @Sales)
SET 
Row_ID = @Row_ID,
Order_ID = @Order_ID,
Order_Date = STR_TO_DATE(@Order_Date, '%d/%m/%Y'),
Ship_Date = STR_TO_DATE(@Ship_Date, '%d/%m/%Y'),
Ship_Mode = @Ship_Mode,
Customer_ID = @Customer_ID,
Customer_Name = @Customer_Name,
Segment = @Segment,
Country = @Country,
City = @City,
State = @State,
Postal_Code = @Postal_Code,
Region = @Region,
Product_ID = @Product_ID,
Category = @Category,
Sub_Category = @Sub_Category,
Product_Name = @Product_Name,
Sales = @Sales;
ALTER TABLE sales_data 
MODIFY Sales DECIMAL(10,4);
ALTER TABLE sales_data 
MODIFY State VARCHAR(50);
-- TOTAL SALES
SELECT SUM(Sales) AS Total_Sales 
FROM sales_data;
-- TOTAL ORDERS
SELECT COUNT(DISTINCT Order_ID) AS Total_Orders
FROM sales_data;
-- TOTAL CUSTOMERS
SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM sales_data;
-- SALES BY REGION
SELECT Region, ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;
-- Top 10 PRODUCTS
SELECT Product_Name, ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_data
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;
-- SALES BY CATEGORY
SELECT Category, ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_data
GROUP BY Category;
-- MONTHLY SALES
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    ROUND(SUM(Sales),2) AS Monthly_Sales
FROM sales_data
GROUP BY Month
ORDER BY Month;
-- TOP STATES
SELECT State, ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_data
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;
-- SEGMENT ANALYSIS
SELECT Segment, ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_data
GROUP BY Segment;
-- AVERAGE ORDER VALUE
SELECT 
    ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value
FROM sales_data;