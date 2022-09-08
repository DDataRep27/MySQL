use assignment;

-- select all employees in department 10 whose salary is greater than 3000 [table: employee]
Select * 
from employee
where salary > 3000 and deptno = 10;


-- The grading of students based on the marks they have obtained is done as follows:
-- 40 to 50 -> Second Class
-- 50 to 60 -> First Class
-- 60 to 80 -> First Class
-- 80 to 100 -> Distinctions
-- a. How many students have graduated with first class?
-- b. How many students have obtained distinction? [table: students] 
Select
case
when marks >  80 then 'Distinction'
when marks >  50 then 'First_Class'
else 'Second_Class'
end as Grade
,count(case
when marks >  80 then 'Distinction'
when marks >  50 then 'First_Class'
else 'Second_Class'
end) as Countof_Grades
from students
group by grade;


-- Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
Select Distinct 
id
,city
from station
where mod(id, 2)=0;


-- Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, write a query to find the value of N-N1 from station. [table: station]
Select 
count(city) as 'Total_Cities'
,Count(DISTINCT city) as 'Distinct_Cities'
,(count(city)) - (Count(DISTINCT city)) as 'Duplicate_Records'
from station;


-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]
Select DISTINCT
city
from station
WHERE left(city, 1) in ('a', 'e', 'i', 'o', 'u');


-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
Select Distinct
city
from station
WHERE left(city, 1) in ('a', 'e', 'i', 'o', 'u') and right(city,1) in ('a', 'e', 'i', 'o', 'u');


-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
Select Distinct
city
from station
WHERE city not regexp '^[a, e,i, o, u]';


-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. [table: station]
Select Distinct
city
from station
WHERE city not regexp '^[a, e,i, o, u]$';


-- Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. Sort your result by descending order of salary. [table: emp]
Select 
concat(first_name, ' ', last_name) as FullName
,Gender
,Salary
,Hire_date
from emp
where salary > 2000 and timestampdiff(month, hire_date, curdate()) <=36
Order by salary desc;


-- How much money does the company spend every month on salaries for each department? [table: employee]
SELECT
Deptno
,sum(Salary) as TotalSalary 
From employee
Group by Deptno;


-- How many cities in the CITY table have a Population larger than 100,000. [table: city]
Select DISTINCT
count(*) as 'Pop more than 100000'
from city
where population > 100000;

-- What is the total population of California? [table: city]
SELECT
sum(population) as 'Total_Population'
from city
where name = 'Ageo';


-- What is the average population of the districts in each country? [table: city]
SELECT
countrycode
,avg(population) as 'Avg_Population'
from city
group by countrycode;


-- Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]
SELECT
o.ordernumber
,c.customernumber
,o.status
,c.customername
,o.comments
from orders o inner join customers c on o.customernumber = c.customernumber
where o.status = 'Disputed';



