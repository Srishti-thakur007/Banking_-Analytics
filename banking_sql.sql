CREATE DATABASE BANKING_PROJECT;
USE BANKING_PROJECT;
SELECT*FROM banking_analysis;

# Total Customers
SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM banking_analysis;

# Gender-Wise Customer Distribution
SELECT Gender,
       COUNT(*) AS Total_Customers
FROM banking_analysis
GROUP BY Gender
ORDER BY Total_Customers DESC;

# Top 10 Customers by Account Balance
SELECT `Customer ID`,
       `First Name`,
       `Last Name`,
       `Account Balance`
FROM banking_analysis
ORDER BY `Account Balance` DESC
LIMIT 10;

# City-Wise Customer Count
SELECT `City`,
       COUNT(*) AS Customer_Count
FROM banking_analysis
GROUP BY `City`
ORDER BY Customer_Count DESC;

# Loan Status Analysis
SELECT `Loan Status`,
       COUNT(*) AS Total_Loans,
       ROUND(SUM(`Loan Amount`),2) AS Total_Loan_Amount
FROM banking_analysis
GROUP BY `Loan Status`;

# Loan Type Performance
SELECT `Loan Type`,
       COUNT(*) AS Loan_Count,
       ROUND(AVG(`Loan Amount`),2) AS Avg_Loan
FROM banking_analysis
GROUP BY `Loan Type`;

# Highest Loan Amount Customers
SELECT `Customer ID`,
       `First Name`,
       `Last Name`,
       `Loan Amount`
FROM banking_analysis
ORDER BY `Loan Amount` DESC
LIMIT 10;

# Average Interest Rate by Loan Type
SELECT `Loan Type`,
       ROUND(AVG(`Interest Rate`),2) AS Avg_Interest
FROM banking_analysis
GROUP BY `Loan Type`;

# Deposit vs Withdrawal Analysis
SELECT `Transaction Type`,
       COUNT(*) AS Total_Transactions,
       ROUND(SUM(`Transaction Amount`),2) AS Total_Amount
FROM banking_analysis
GROUP BY `Transaction Type`;

# Branch Performance Analysis
SELECT `Branch ID`,
       COUNT(*) AS Total_Customers,
       ROUND(SUM(`Account Balance`),2) AS Total_Deposits
FROM banking_analysis
GROUP BY `Branch ID`
ORDER BY Total_Deposits DESC;

# Credit Card Utilization Rate
SELECT `Card Type`,
       ROUND(
         AVG((`Credit Card Balance` / `Credit Limit`) * 100),
         2
       ) AS Utilization_Percentage
FROM banking_analysis
GROUP BY `Card Type`;

# Top Customers by Credit Card Spending
SELECT `Customer ID`,
       `First Name`,
       `Last Name`,
       `Credit Card Balance`
FROM banking_analysis
ORDER BY `Credit Card Balance` DESC
LIMIT 10;

# Rewards Points Analysis
SELECT `Card Type`,
       ROUND(AVG(`Rewards Points`),2) AS Avg_Rewards
FROM banking_analysis
GROUP BY `Card Type`;

# Customer Feedback Type
SELECT `Feedback Type`,
       COUNT(*) AS Total_Feedbacks
FROM banking_analysis
GROUP BY `Feedback Type`
ORDER BY Total_Feedbacks DESC;

# Resolution Status Performance
SELECT `Resolution Status`,
       COUNT(*) AS Total_Cases
FROM banking_analysis
GROUP BY `Resolution Status`;

# Age Group Analysis
SELECT
CASE
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    WHEN Age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
END AS Age_Group,
COUNT(*) AS Customers
FROM banking_analysis
GROUP BY Age_Group;

# Fraud/ Anomaly Detection
SELECT `Anomaly`,
       COUNT(*) AS Total_Records
FROM banking_analysis
GROUP BY `Anomaly`;

# Window Function Query Top 3 Customers in each city:
 WITH RankedCustomers AS (
    SELECT
        `Customer ID`,
        `First Name`,
        `Last Name`,
        `City`,
        `Account Balance`,
        ROW_NUMBER() OVER (
            PARTITION BY `City`
            ORDER BY `Account Balance` DESC
        ) AS rn
    FROM banking_analysis
)

SELECT *
FROM RankedCustomers
WHERE rn <= 3;

# Total Deposits in Bank
SELECT ROUND(SUM(`Account Balance`),2) AS Total_Deposits
FROM banking_analysis;

# Monthly Transaction Trend
SELECT MONTH(`Transaction Date`) AS Month,
       COUNT(*) AS Total_Transactions
FROM banking_analysis
GROUP BY MONTH(`Transaction Date`)
ORDER BY Month;

# Bank Performance Summary
SELECT
COUNT(DISTINCT `Customer ID`) AS Total_Customers,
ROUND(SUM(`Account Balance`),2) AS Total_Deposits,
ROUND(SUM(`Loan Amount`),2) AS Total_Loans,
ROUND(AVG(`Account Balance`),2) AS Avg_Balance,
ROUND(AVG(`Loan Amount`),2) AS Avg_Loan
FROM banking_analysis;