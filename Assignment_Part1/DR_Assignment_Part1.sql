-- create a database called 'assignment' 
Create database assignment;

-- Create a table called countries with the following columns name, population, capital
use assignment;
Create table countries(
Name varchar(50) unique
,Popoulation int
,Capital varchar(50) unique
);

-- Add a couple of countries of your choice
insert into countries
values('China', 1382, 'Beijing'), ('India', 1326, 'Delhi'), ('United States', 324, 'Washington D.C.'), ('Indonesia', 260, 'Jakarta'), ('Brazil', 209, 'Brasilia'), ('Pakistan', 193, 'Islamabad'), 
('Nigeria', 187, 'Abuja'), ('Bangladesh', 163, 'Dhaka'), ('Russia', 163, 'Moscow'), ('Mexico', 128, 'Mexico City'), ('Japan', 126, 'Tokyo'), ('Philippines', 102, 'Manila'), ('Ethiopia', 101, 'Addis Ababa'),
('Vietnam', 94, 'Hanoi'), ('Egypt', 93, 'Cairo'), ('Germany', 81, 'Berlin'), ('Iran', 80, 'Tehran'), ('Turkey', 79, 'Ankara'), ('Congo', 79, 'Kinshasa'), ('France', 64, 'Paris'), ('United Kingdom', 65, 'London'),
('Italy', 60, 'Rome'), ('South Africa', 55, 'Pretoria'), ('Myanmar', 54, 'Naypyidaw'), ('Nepal', 100, 'Kathmandu'), ('Tibet', 99, 'Lhasa'), ('Bhutan', 95, 'Thimpu');

-- Change ‘Delhi' to ‘New Delhi'
update countries
set capital =  'New Delhi'
where capital = 'Delhi';

-- Rename the table countries to big_countries 
Rename table countries to big_countries;

-- Create following table: Product, Suppliers & Stock

Create table Supplier(
Supplier_id int primary key AUTO_INCREMENT
,Supplier_Name varchar(50) unique not null 
,Location varchar(50) not null
); 

insert into Supplier(Supplier_Name, Location)
values ('Ram', 'Ayodhya'), ('Shiva', 'Kashi'), ('Krishna', 'Mathura'), ('Kalki', 'Shyambala'), ('Venkateshwar', 'Tirupati') ;

Create table Product(
Product_id int primary key
,Product_Name varchar(50) unique not null 
,Supplier_id int auto_increment
,Description text not null
,foreign key (Supplier_id) references Supplier(Supplier_id)
); 

insert into Product(Product_id, Product_Name, Description)
values (101, 'Iphone', 'The iPhone is a smartphone made by Apple that combines a computer, iPod, digital camera and cellular phone into one device with a touchscreen interface. The iPhone runs the iOS operating system')
, (102, 'Ipad', 'The iPad is a brand of iOS and iPadOS-based tablet computers developed by Apple Inc. The iPad is a touchscreen tablet PC made by Apple')
, (103, 'Macbook', 'The MacBook is a brand of Macintosh notebook computers designed and marketed by Apple Inc. that uses macOS operating system')
, (104, 'Airpods', 'AirPods are wireless Bluetooth earbuds designed by Apple Inc. ')
, (105, 'Apple watch', 'The Apple Watch is a smartwatch that operates as a small wearable computing device worn on a user’s wrist');


Create table Stock(
Stock_id int primary key
,Balance_stock int not null
,Foreign key (stock_id) references product(product_id)
); 

insert into Stock
values (101, 100), (102, 250), (103, 400), (104, 750), (105, 999);

set sql_safe_updates = 0;

 -- Modify the emp table and a.	Add a column called deptno
ALTER TABLE emp
ADD COLUMN deptno INT;

-- Set the value of deptno in the following order:  deptno = 20 where emp_id is divisible by 2;  deptno = 30 where emp_id is divisible by 3; deptno = 40 where emp_id is divisible by 4;  deptno = 50 where emp_id is divisible by 5;  deptno = 10 for the remaining records.
UPDATE emp
SET deptno = (CASE 
WHEN  (mod(emp_no, 2) = 0) THEN 20
WHEN  (mod(emp_no, 3) = 0) THEN 30
WHEN  (mod(emp_no, 4) = 0) THEN 40
WHEN  (mod(emp_no, 5) = 0) THEN 50
ELSE 10
End);

-- Create a unique index on the emp_id column.
CREATE UNIQUE INDEX unq_index_empid
ON emp(emp_no);

SHOW INDEXES from emp;

-- Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.
CREATE VIEW emp_sal AS
SELECT
emp_no
, first_name
, last_name
,Salary
From emp
Order by Salary desc;










