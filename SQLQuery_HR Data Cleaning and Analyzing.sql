CREATE DATABASE HR_Resources;

-- A. DATA CLEANING
-- Overview Data
SELECT *
FROM [dbo].[human_resources];

-- Change Data type Columns
-- birthdate and hire_date
ALTER TABLE [dbo].[human_resources]
ALTER COLUMN birthdate date;

ALTER TABLE [dbo].[human_resources]
ALTER COLUMN hire_date date;

-- termdate 
UPDATE [dbo].[human_resources]
SET termdate = CAST(SUBSTRING(termdate,1,10) AS date)
WHERE termdate IS NOT NULL AND termdate != '';

ALTER TABLE [dbo].[human_resources]
ALTER COLUMN termdate date;

-- Create age column
ALTER TABLE [dbo].[human_resources]
ADD age int;

UPDATE [dbo].[human_resources]
SET age = DATEDIFF(YEAR,birthdate,GETDATE());

-- B. DATA ANALYSIS
-- 1. What is the gender breakdown of employees in the company?
SELECT gender
, COUNT(gender) AS [number]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
GROUP BY gender
ORDER BY COUNT(gender) DESC;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race
, COUNT(race) AS [number]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
GROUP BY race
ORDER BY COUNT(race) DESC;

-- 3. What is the age distribution of employees in the company?
WITH CTE_age_group
AS (
SELECT 
CASE	
	WHEN age >= 18 AND age <= 30 THEN '18-30'
	WHEN age > 30 AND age <= 40 THEN '31-40'
	WHEN age > 40 AND age <= 50 THEN '41-50'
	WHEN age > 51 AND age <= 60 THEN '51-60'
	ELSE '60+'
END AS [age_group]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
)

SELECT age_group
, COUNT(age_group) AS [number]
FROM CTE_age_group
GROUP BY age_group
ORDER BY age_group ASC;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location
, COUNT(location) AS [number_of_employee]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT AVG(YEAR(termdate) - YEAR(hire_date)) AS [avg_length_of_employment (terminated)]
FROM [dbo].[human_resources]
WHERE termdate <= GETDATE();

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department
, jobtitle
, gender
, COUNT(gender) AS [number]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
GROUP BY department, jobtitle, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle
, COUNT(*) AS [number]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
GROUP BY jobtitle
ORDER BY jobtitle;

-- 8. Which department has the highest turnover rate?
WITH CTE_terminated_count
AS (
SELECT department
, SUM(CASE
	WHEN termdate IS NULL THEN 0
	WHEN termdate <= GETDATE() THEN 1
	ELSE 0
  END) AS [terminated_count]
, CAST(COUNT(*) AS float) AS [total_employee]
FROM [dbo].[human_resources]
GROUP BY department
)

SELECT department
, terminated_count
, total_employee
, ROUND(terminated_count / total_employee,2) AS [turnover_rate]
FROM CTE_terminated_count
ORDER BY ROUND(terminated_count / total_employee,2) DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_city
, location_state
, COUNT(*) AS [number_employee]
FROM [dbo].[human_resources]
WHERE termdate IS NULL OR termdate > GETDATE()
GROUP BY location_city, location_state
ORDER BY location_state, location_city;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT year
, hires
, terminations
, hires - terminations AS [net_change]
, ROUND((hires - CAST(terminations AS float)) / hires * 100,2) AS [percentage_change]
FROM (
SELECT YEAR(hire_date) AS [year]
, COUNT(*) AS [hires]
, SUM(CASE
		WHEN termdate <= GETDATE() THEN 1
		WHEN termdate IS NULL OR termdate > GETDATE() THEN 0
	  END) AS [terminations]
FROM [dbo].[human_resources]
GROUP BY YEAR(hire_date)
) AS sub
ORDER BY year;

-- 11. What is the tenure distribution for each department?
WITH CTE_tenure
AS(
SELECT id
, department
, CAST(CASE
			WHEN termdate IS NULL OR termdate > GETDATE() THEN DATEDIFF(YEAR,hire_date,GETDATE())
			ELSE DATEDIFF(YEAR,hire_date,termdate)
       END AS float) AS [tenure]
FROM [dbo].[human_resources]
)

SELECT department
, ROUND(AVG(tenure),1) AS [avg_tenure]
FROM CTE_tenure
GROUP BY department;




