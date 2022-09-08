use assignment;

-- 1. Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status of the orders placed in that month. 
Delimiter $$
CREATE PROCEDURE `order_status` (IN year INT, IN month INT)
BEGIN
Select
ordernumber
,orderdate
,status
from orders
where year(orderdate) = year and left(month(orderdate), 6) = month;
END;


Call order_status(2005, 03);


-- 2. a) Write a stored procedure to insert a record into the cancellations table for all cancelled orders.
CREATE TABLE Cancellations (
ID INT PRIMARY KEY AUTO_INCREMENT
, CustomerNumber INT
, OrderNumber INT
, FOREIGN KEY (CustomerNumber) REFERENCES Customers (CustomerNumber)
, FOREIGN KEY (OrderNumber) REFERENCES Orders (OrderNumber)
);


-- 2. b)  Read through the orders table . If an order is cancelled, then put an entry in the cancellations table.
Delimiter $$
CREATE PROCEDURE `abc`(IN Stat VARCHAR (150))

BEGIN
DECLARE lcl_CustomerNumber, lcl_Ordernumber, Finished INT default 0;

DECLARE enter cursor for 
Select  
CustomerNumber
,Ordernumber
from orders
where status = Stat;

declare exit HANDLER for NOT FOUND set Finished =1;

open enter;
enterloop:Repeat
		fetch enter into lcl_CustomerNumber, lcl_Ordernumber;
        
		insert into cancellations (CustomerNumber, Ordernumber)
        
        VALUES (lcl_CustomerNumber, lcl_OrderNUmber);
         
		until finished = 1
end repeat enterloop;

END;


Call cancel_procedure ('Cancelled');

select * from cancellations;

Delimiter $$
CREATE PROCEDURE `abc` (in Stat VARCHAR (50))

BEGIN
DECLARE cnum, ordnum, Finished INT default 0;

DECLARE ord_cus cursor for 
Select  
CustomerNumber
,Ordernumber
from orders
where status = Stat;

declare exit HANDLER for NOT FOUND 
set Finished =1;

open ord_cus;
ordloop:Repeat
		fetch ord_cus into cnum, ordnum;
        
		insert into cancellations (CustomerNumber, Ordernumber)
        
        VALUES (cnum, ordnum);
         
		until finished = 1
		end repeat ordloop;

END;


Call abc ('Disputed');

select * from cancellations;

drop table cancellations;


-- 3  a) Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments] if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold if amount > 50000 Platinum
Delimiter $$
CREATE FUNCTION 'Pur_Stat'(cid INT) RETURNS varchar(20)
DETERMINISTIC
BEGIN
    DECLARE stat VARCHAR(20);
    DECLARE credit numeric;
    SET credit = (select sum(Amount) from Payments where CustomerNumber = cid);

    IF credit > 50000 THEN
		SET stat = 'Platinum';
    ELSEIF (credit >= 25000 AND 
			credit <= 50000) THEN
        SET stat = 'Gold';
    ELSEIF credit < 25000 THEN
        SET stat = 'Silver';
    END IF;

	RETURN (stat);
END;


SELECT
Pur_Stat(112) as Purchase_Status;


--  3  b) Write a query that displays customerNumber, customername and purchase_status from customers table.
Select
p.customernumber
, c.customername
, sum(amount)
, case
when sum(amount) > 50000 then 'Platinum'
when sum(amount) < 25000 then 'Silver'
Else 'Gold'
End as 'Purchase_Status'
from customers c inner join payments p on c.customernumber = p.customernumber
Group by p.customernumber;


--  4)  Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.
Delimiter $$
Create Trigger updates After update
ON movies For each row
Begin 
update rentals 
Set movieid = new.id;
End $$ 

Show Triggers;

update movies
Set id = 11  where title = 'Unsafe';

Select * from movies;

Select * from rentals;
 
Delimiter $$
Create Trigger deletes After delete
ON movies For each row
Begin 
delete from rentals 
where movieid = old.id;
End $$ 

Show Triggers;

delete from movies
where id = 1;

Select * from movies;

Select * from rentals;


--  5)  Select the first name of the employee who gets the third highest salary. [table: employee]
SELECT
fname as First_Name
,RANK() over (ORDER BY salary desc) as 'Rank_Salary'
,Salary
from  employee
LIMIT 2, 1;


-- 6)  Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]
SELECT
fname as First_Name
,RANK() over (ORDER BY salary desc) as 'Rank_Salary'
,salary
from  employee;
