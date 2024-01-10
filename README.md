# HR-Data-Analytics
## Overview Project
This project dives deep into the realm of data analysis using SQL and Power BI to uncover important human resource insights that can greatly benefit the company.<br>Featuring eye-catching dashboards offer crucial HR metrics like employee turnover, diversity, recruitment efficacy and performance evaluations. These help HR professionals make informed decisions and strategic workforce planning.
<hr>

## Sample Data Source
You can download the data from [Sample Data folder](https://github.com/AndyDuong0112/HR-Data-Analytics/blob/main/Sample%20Data/Human%20Resources.csv). <br>

<hr>

## Tools
1) <b>SQL</b> - Data Cleaning and Analyzing <br>
   ( Import CSV File, Create Database, Basic Queries, CASE statement, Aggregate Functions, String Functions, Date Functions, Subquery, CTE's)

2) <b>PowerBI</b> - Creating reports <br>
   ( Connect to SQL and Transform Data, Visualize Data)
<hr>

## HR Questions To Answer
<ol>
  <li>What is the gender breakdown of employees in the company?</li>
  <li>What is the race/ethnicity breakdown of employees in the company?</li>
  <li>What is the age distribution of employees in the company?</li>
  <li>How many employees work at headquarters versus remote locations?</li>
  <li>What is the average length of employment for employees who have been terminated?</li>
  <li>How does the gender distribution vary across departments and job titles?</li>
  <li>What is the distribution of job titles across the company?</li>
  <li>Which department has the highest turnover rate?</li>
  <li>What is the distribution of employees across locations by city and state?</li>
  <li>How has the company's employee count changed over time based on hire and term dates?</li>
  <li>What is the tenure distribution for each department?</li>
</ol>
<hr>

## Findings
<ol>
  <li> <b>Male:</b> 10,067 people (50.9%), <b>Female:</b> 9,151 people (46.3%), <b>Non-confirming:</b> 543 people (2.7%).</li>
  <li> White employees are the majority in the company, followed by Two or More Races.</li>
  <li> The most popular age-group is from 31-40 years old, followed by 41-50 years old. The fewest group is 60+ years old.</li>
  <li> There are 14,835 people (about 75.1%) working at headquarters and 4926 people working remotely.</li>
  <li> The average length of employment for employees who have been terminated is 7 years.</li>
  <li> Research Assistant II from Business Development has the most people both Male (336) and Female (324).</li>
  <li> Research Assistant II has the most people with total 690 people, followed by Business Analyst (632), Human Resources Analyst II (544).</li>
  <li> The department has highest turnover rate is Auditing (0.15).</li>
  <li> Most employees are in Cleveland, Ohio (14,978) followed distantly by Chicago, Illinois (316) and Philadelphia, Pennsylvania (295).</li>
  <li> Percentage Change have increased from 85.9% in 2000 to 97.4% in 2020.</li>
  <li> Auditing is the department which has the highest average tenure (about 13.3 years). In contrast, Legal has the lowest average tenure (about 12.2 years).</li>
</ol>
<hr>

## A. Data Cleaning & Analyzing (SQL)
#### 1. Create Database
```sql
CREATE DATABASE HR_Resources;
```
#### 2. Overview data, Change Data Type and Create new Column
<ul>
  <li>birthdate and hire_date column</li>
  
  ```sql
  ALTER TABLE [dbo].[human_resources]
  ALTER COLUMN birthdate date;

  ALTER TABLE [dbo].[human_resources]
  ALTER COLUMN hire_date date;
  ```
  <li>termdate column</li>
  
  ```sql
  UPDATE [dbo].[human_resources]
  SET termdate = CAST(SUBSTRING(termdate,1,10) AS date)
  WHERE termdate IS NOT NULL AND termdate != '';

  ALTER TABLE [dbo].[human_resources]
  ALTER COLUMN termdate date;
  ```

  <li>create age column</li>
  
  ```sql
  ALTER TABLE [dbo].[human_resources]
  ADD age int;

  UPDATE [dbo].[human_resources]
  SET age = DATEDIFF(YEAR,birthdate,GETDATE());
  ```
</ul>

#### 3. Answer Questions 
Click here to see all queries used [SQLQuery_HR Data Cleaning and Analyzing.sql](https://github.com/AndyDuong0112/HR-Data-Analytics/blob/main/SQLQuery_HR%20Data%20Cleaning%20and%20Analyzing)

## B. Data Visualization
#### 1. Connect to SQL Database
#### 2. Transform Data ( Check Data Type)
#### 3. Visualize Data
![Hr_Dashboard_01-07-2024-1](https://github.com/AndyDuong0112/HR-Data-Analytics/assets/125394873/6e43645f-e03f-4956-94e8-037fb89dd9e2)

![Hr_Dashboard_01-07-2024-2](https://github.com/AndyDuong0112/HR-Data-Analytics/assets/125394873/b10afffd-369f-4580-bc68-3a489313727c)

