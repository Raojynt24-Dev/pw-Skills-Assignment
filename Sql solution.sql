create database  pw;
use pw;
CREATE TABLE Customers ( 
CustomerID INT, 
CustomerName VARCHAR(50), 
City VARCHAR(30), 
JoinDate DATE 
);
INSERT INTO Customers VALUES 
(101,'Rahul Sharma','Bangalore','2023-01-15'), 
(102,'Priya Mehta','Mumbai','2024-03-20'), 
(103,'Arjun Nair','Chennai','2025-01-12'), 
(104,'Sneha Gupta','Delhi','2022-07-10'), 
(105,'Kavya Reddy','Hyderabad','2024-08-15'), 
(106,'Amit Verma','Pune','2023-11-05'), 
(107,'Rohan Singh','Kolkata','2024-05-18'), 
(108,'Simran Kaur','Delhi','2025-02-01'), 
(109,'Anjali Jain','Mumbai','2023-09-22'), 
(110,'Vikram Patel','Ahmedabad','2022-12-30');  
# orders
CREATE TABLE Orders ( 
OrderID INT, 
CustomerID INT, 
OrderDate DATE, 
OrderAmount DECIMAL(10,2), 
Status VARCHAR(20) 
);
INSERT INTO Orders VALUES 
(5001,101,'2025-01-05',12000,'Delivered'), 
(5002,102,'2025-01-15',8500,'Pending'), 
(5003,101,'2025-02-10',22000,'Delivered'), 
(5004,104,'2025-02-15',4500,'Cancelled'), 
(5005,103,'2025-03-01',17500,'Delivered'), 
(5006,105,'2025-03-10',9800,'Pending'), 
(5007,106,'2025-03-18',25000,'Delivered'), 
(5008,107,'2025-04-02',14500,'Delivered'), 
(5009,101,'2025-04-10',30000,'Delivered'), 
(5010,109,'2025-04-15',6500,'Pending'), 
(5011,110,'2025-05-01',42000,'Delivered'), 
(5012,104,'2025-05-08',18000,'Delivered'), 
(5013,106,'2025-05-15',7000,'Cancelled'), 
(5014,102,'2025-05-20',27000,'Delivered'), 
(5015,107,'2025-06-01',15500,'Pending');  
# Employees
CREATE TABLE Employees ( 
EmployeeID INT, 
EmployeeName VARCHAR(50), 
ManagerID INT, 
Department VARCHAR(30), 
JoiningDate DATE, 
Salary DECIMAL(10,2) 
); 
INSERT INTO Employees VALUES 
(1,'Rajesh Kumar',NULL,'Management','2018-01-10',150000), 
(2,'Neha Sharma',1,'Sales','2020-03-15',90000), 
(3,'Amit Gupta',1,'IT','2019-06-20',110000), 
(4,'Priyanka Singh',2,'Sales','2022-01-12',65000), 
(5,'Vikas Patel',2,'Sales','2021-09-18',70000), 
(6,'Rohit Jain',3,'IT','2023-02-05',60000), 
(7,'Anjali Verma',3,'IT','2022-11-10',62000), 
(8,'Karan Mehta',1,'HR','2021-05-25',80000), 
(9,'Sneha Kapoor',8,'HR','2024-01-05',50000), 
(10,'Arjun Malhotra',3,'IT','2024-04-15',55000); 

# Q1 Solution---------------------------------------------
SELECT o.orderid,c.customerName,o.orderAmount from orders o
 inner join customers c on o.customerId=c.customerId 
 order by o.orderAmount Desc limit 5;
  #Q2 Solution---------------------------------------------
 Select*from customers where CustomerName REGEXP'^[ARS]';
 #Q3 Solution------------------------------------------
 SELECT o.orderid,c.customerName,o.orderAmount,o.Status from customers c
 inner join orders o on c.customerId=o.customerId
 where o.orderAmount>10000 AND o.status ='Pending';
  # Q4 Solution----------------------------------
  SELECT customerName,joinDate,datediff(CurDate(),joindate)as
  Days_Associated
  from customers
  where datediff(CurDate(),joindate)>365;
   #Q5 Solution--------------------------------------
   select orderid,orderAmount as current_Amount,
   orderAmount*18/100 as GST_18_Percent,
   orderAmount+( orderAmount*18/100) as TOTAL_Amount_After_GST,
   date_add(orderDate,INTERVAL 15 DAY) AS Expected_Collection_Date
   from orders;
    # Q6 Solution-------------------------------------------
    select orderId,customerid,orderAmount from orders 
    order by orderAmount desc  limit 13 offset 10;
     #Q7 Solution-----------------------------------------
     select c.customerId,
     c.customerName,
     c.joinDate,datediff(curDate(),c.joindate) as Days_Since_Registration
     from customers c
     left join orders o
     on c.customerId=o.customerId
     where o.customerId is Null;
      #Q8 Solution--------------------------------------------------
      Select e.employeeName as employee_Name,
      m.employeeName as Manager_Name,
      e.department as Department from Employees e
      left join Employees m
      on e.managerId=m.employeeId;
      # Q9 Solution----------------------
      select 
      c.customerName,c.joinDate,
      min(o.orderDate) AS First_Order_Date,
      datediff(min(o.orderDate),c.joinDate) AS Days_Taken
      from customers c
      inner join orders o
      on c.customerId=o.customerId
      group by
      c.customerId,
      c.customerName,
      c.joinDate
      having datediff(min(o.orderDate),c.joinDate) between 0 and 30;
      
	#Q10 Solution -------------------------------------
    select c.customerName,
    sum(o.orderAmount) AS Total_Purchase_Amount,
    case
    when sum(o.orderAmount)>50000
    Then 'premium'
    when sum(o.orderAmount) between 20000 and 50000 
    Then 'Gold'
    else 'Silver'
    End as Spending_Category,
    case 
    when c.joinDate < '2024-01-01'
        then 'Loyal Customer'
        else 'New Customer' End as Loyality_status
        from customers c
        left join orders o
        on c.customerId=o.CustomerId
        group by
        c.customerId,
        c.customerName,
        C.joinDate;
        
#Q11 Solution ---------------------
SELECT o.orderid,c.customerName,o.orderAmount 
from customers c
 inner join orders o
 on c.customerId=o.customerId
 where o.orderAmount>(select Avg(orderAmount) from orders);
 
#Q12 Solution------------------
SELECT o.orderid,c.customerName,o.orderAmount 
from customers c
 inner join orders o
 on c.customerId=o.customerId
 order by o.orderAmount Desc
 limit 5 offset 1;