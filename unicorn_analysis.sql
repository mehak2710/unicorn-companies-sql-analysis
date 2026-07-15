CREATE DATABASE IF NOT EXISTS unicorn_analysis;
USE unicorn_analysis;
-----------------------------------------------------------

-- Total number of unicorn companies

-- Display first 10 records

SELECT *
FROM unicorn_companies
LIMIT 10;

-----------------------------------------------------------

-- View all distinct countries

SELECT DISTINCT Country
FROM unicorn_companies;

-----------------------------------------------------------
-- View all industries

SELECT DISTINCT Industry
FROM unicorn_companies;
-----------------------------------------------------------

-- Number of countries

SELECT COUNT(DISTINCT Country) AS Countries
FROM unicorn_companies;

-----------------------------------------------------------
-- Number of industries

SELECT COUNT(DISTINCT Industry) AS Industries
FROM unicorn_companies;
/*=========================================================
            COUNTRY ANALYSIS
=========================================================*/

-- Top 10 countries with most unicorn companies

SELECT
Country,
COUNT(*) AS Unicorns
FROM unicorn_companies
GROUP BY Country
ORDER BY Unicorns DESC
LIMIT 10;
-----------------------------------------------------------

-- Countries having more than 20 unicorns

SELECT
Country,
COUNT(*) AS Unicorns
FROM unicorn_companies
GROUP BY Country
HAVING COUNT(*) > 20
ORDER BY Unicorns DESC;
/*=========================================================
                CITY ANALYSIS
=========================================================*/

-- Top 10 cities

SELECT
City,
COUNT(*) AS Unicorns
FROM unicorn_companies
GROUP BY City
ORDER BY Unicorns DESC
LIMIT 10;
/*=========================================================
                INDUSTRY ANALYSIS
=========================================================*/

-- Number of unicorns by industry

SELECT
Industry,
COUNT(*) AS Companies
FROM unicorn_companies
GROUP BY Industry
ORDER BY Companies DESC;
-----------------------------------------------------------

-- Average investors by industry

SELECT
Industry,
ROUND(AVG(`Investors Count`),2) AS Avg_Investors
FROM unicorn_companies
GROUP BY Industry
ORDER BY Avg_Investors DESC;
/*=========================================================
            VALUATION ANALYSIS
=========================================================*/

-- Highest valued companies

SELECT
Company,
`Valuation ($B)`
FROM unicorn_companies
ORDER BY
CAST(REPLACE(`Valuation ($B)`,'$','') AS DECIMAL(10,2))
DESC
LIMIT 10;
-----------------------------------------------------------

-- Average valuation

SELECT
ROUND(
AVG(
CAST(REPLACE(`Valuation ($B)`,'$','')
AS DECIMAL(10,2))
),2) AS Average_Valuation
FROM unicorn_companies;
-----------------------------------------------------------

-- Average valuation by country

SELECT
Country,
ROUND(
AVG(
CAST(REPLACE(`Valuation ($B)`,'$','')
AS DECIMAL(10,2))
),2) AS Average_Valuation
FROM unicorn_companies
GROUP BY Country
ORDER BY Average_Valuation DESC;
/*=========================================================
            COMPANY AGE ANALYSIS
=========================================================*/

-- Companies founded after 2015

SELECT
Company,
`Founded Year`
FROM unicorn_companies
WHERE `Founded Year` > 2015;
-----------------------------------------------------------

-- Unicorns founded each year

SELECT
`Founded Year`,
COUNT(*) AS Companies
FROM unicorn_companies
GROUP BY `Founded Year`
ORDER BY `Founded Year`;
/*=========================================================
            INVESTOR ANALYSIS
=========================================================*/

-- Top companies by investor count

SELECT
Company,
`Investors Count`
FROM unicorn_companies
ORDER BY `Investors Count` DESC
LIMIT 10;

-----------------------------------------------------------
-- Average investor count

SELECT
ROUND(AVG(`Investors Count`),2)
AS Average_Investor_Count
FROM unicorn_companies;
/*=========================================================
            FINANCIAL STAGE ANALYSIS
=========================================================*/

-- Distribution by financial stage

SELECT
`Financial Stage`,
COUNT(*) AS Companies
FROM unicorn_companies
GROUP BY `Financial Stage`
ORDER BY Companies DESC;
/*=========================================================
            DEAL TERMS ANALYSIS
=========================================================*/

-- Companies with highest deal terms

SELECT
Company,
`Deal Terms`
FROM unicorn_companies
ORDER BY `Deal Terms` DESC
LIMIT 10;
/*=========================================================
            PORTFOLIO EXIT ANALYSIS
=========================================================*/

-- Companies with highest exits

SELECT
Company,
`Portfolio Exits`
FROM unicorn_companies
ORDER BY `Portfolio Exits` DESC
LIMIT 10;
/*=========================================================
            CASE STATEMENT ANALYSIS
=========================================================*/

-- Categorize companies based on valuation

SELECT

Company,

`Valuation ($B)`,

CASE

WHEN CAST(REPLACE(`Valuation ($B)`,'$','')
AS DECIMAL(10,2)) >= 50

THEN 'Mega Unicorn'
WHEN CAST(REPLACE(`Valuation ($B)`,'$','')
AS DECIMAL(10,2)) >= 10

THEN 'Large Unicorn'

ELSE 'Emerging Unicorn'

END AS Category

FROM unicorn_companies;
/*=========================================================
            BUSINESS DASHBOARD SUMMARY
===========================================================*/
SELECT
COUNT(*) AS Total_Unicorns,

COUNT(DISTINCT Country) AS Countries,

COUNT(DISTINCT Industry) AS Industries,

ROUND(
AVG(
CAST(REPLACE(`Valuation ($B)`,'$','') AS DECIMAL(10,2))
),2) AS Average_Valuation,

MAX(`Investors Count`) AS Highest_Investor_Count,

ROUND(AVG(`Investors Count`),2) AS Average_Investor_Count

FROM unicorn_companies;

