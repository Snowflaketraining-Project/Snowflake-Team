create database emp;
create schema emp_schema;

create or replace table employee(
        emp_id int primary key, 
        name varchar(255),
        dept varchar(255),
        salary int, 
        dates date
);
insert into employee values(101,'John','IT',65000,'2021-04-01'),
(102,'Sneha','HR',48000,'2020-11-15'),
(103,'Michael','SALES',72000,'2022-01-05'),
(104,'Priya','IT',85000,'2019-07-19'),
(105,'David','FINANCE',56000,'2021-09-10');

select * from employee;

create or replace table sales_transactions(
        txn_id int primary key, 
        emp_id int foreign key references employee(emp_id),
        amount int,
        txn_date date
);

insert into sales_transactions values(1,103,900,'2023-01-18'),
(2,103,1200,'2023-02-11'),
(3,104,450,'2023-02-28'),
(4,101,700,'2023-01-09'),
(5,105,1500,'2023-03-03');

select * from sales_transactions;

----------------------------------------------------------------------------------------------------------------------------

SECTION A — SQL (8 questions)

--1. Write a query to list the top 3 highest-paid employees.

select * from employee order by salary desc limit 3;

--2. Display employees whose salary is above the overall average salary.

select * from employee where salary> (select avg(salary) from employee);

--3. Show department-wise total salary, sorted by highest total salary first.

select sum(salary) as salary, dept from employee group by dept order by salary desc;

--4. List employees hired between 2020 and 2022.

select * from employee where dates between '2020-01-01' and '2022-01-01';

--5. Find employees who have never performed a transaction.

select e.emp_id, e.name from employee as e 
join
sales_transactions as t on e.emp_id =t.emp_id where t.emp_id is not null;

--6. Display each employee and the number of transactions they made.

select e.emp_id, e.name, count(txn_id) as txn from employee as e 
join sales_transactions as s on e.emp_id = s.emp_id
group by e.emp_id, e.name;

--7. Use a window function to rank employees by salary within each department.

SELECT
    emp_id,
    name,
    dept,
    salary,
    RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS salary_rank
FROM employee;


--8. Show month-wise total sales for 2023.
select sum(amount), txn_date from sales_transactions group by txn_date;

________________________________________


SECTION B — DDL & DML (4 questions)

--9. Create a table named PROJECT with:
PROJECT_ID INT, PROJECT_NAME STRING, START_DATE DATE, EMP_ID INT.

create or replace table project(project_id int, 
        project_name string, 
        start_date date,
        emp_id int
);

--10. Insert 2 rows and update one row to change the project name

insert into project values 
(1,'snowflake','2025-12-02',102),
(2,'ETL','2025-12-06',103);

select * from project;

update project set project_name = 'informatica' where project_id = 2;

--11. Delete all projects started before 2021.

delete from project where start_date <'2021-01-01';

--12. Explain the difference between DELETE, TRUNCATE, and DROP.

delete:
Delete it will delete the particular value based upon the condition it will delete the record.It will delete the record line by line.

Truncate:
Truncate it will delete the table records not the table it will be fast compare to the delete command.

Drop:
Drop is will to delete the table permently.

-----------------------------------------------------------------------------------------------------

create or replace table application_log(raw variant);

CREATE OR REPLACE TABLE Application_log_new (
    user_name STRING,
    device STRING,
    ip_address STRING,
    action STRING
);

INSERT INTO APPLICATION_LOG_new (user_name, device, ip_address, action)
SELECT
    raw:user::string                 AS user_name,
    raw:metadata:device::string      AS device,
    raw:metadata:ip::string          AS ip_address,
    f.value::string                  AS action
FROM APPLICATION_LOG,
     LATERAL FLATTEN(input => raw:actions) f;



SECTION C — SEMI-STRUCTURED DATA (VARIANT, ARRAY, OBJECT) (6 questions)

--13. Extract all usernames from APPLICATION_LOGS.

select user_name from  application_log_new;

--14. Extract IP address and device from metadata.

select device, ip_address from application_log_new;

--15. Flatten the "actions" array into individual rows.

SELECT
    raw:user::string                 AS user_name,
    raw:metadata:device::string      AS device,
    raw:metadata:ip::string          AS ip_address,
    f.value::string                  AS action
FROM APPLICATION_LOG,
     LATERAL FLATTEN(input => raw:actions) f;


--16. Count how many users performed the "login" action.

select * from application_log_new;
select count(user_name),action from application_log_new where action = 'login' group by action;

--17. Show users who performed "download_report".

SELECT DISTINCT
    raw:user::string AS user_name
FROM EMP.EMP_SCHEMA.APPLICATION_LOG,
     LATERAL FLATTEN(input => raw:actions) f
WHERE f.value::string = 'download_report';


--18. Explain the difference between VARIANT, ARRAY, and OBJECT.

variant is used in the xml,json etc like this file we can use variant.

----------------------------------------------------------------------------------------------------

--SECTION D — VIEWS & SECURE VIEWS (4 questions)

--19. Create a view showing EMP_ID, NAME, and SALARY.

create view emp_views as select emp_id, name, salary from employee;
select * from emp_views;
select * from employee

--20. Create a secure view that shows NAME and masked salary (SALARY * 0.8).

create or replace secure view emp_secure as select name,salary* 0.8 as salary from employee;
select * from emp_secure;

--21. Explain why secure views are required for data sharing.

Secure view is mostly used to share the data secure.

--22. Create a view showing each employee and their total sales amount.

create or replace view emp_total as select sum(salary)as total_salary from employee;
select * from emp_total

-------------------------------------------------------------------------------------------------------------------------

SECTION E — INTERMEDIATE LOGIC (2 questions)

--23. Using QUALIFY, show the latest transaction per employee.

select * from sales_transactions
qualify row_number() over(
partition by emp_id
order by txn_date desc) = 1;

--24. Identify employees whose salary is within ±10% of their department average salary.

SELECT
    EMP_ID,
    NAME,
    DEPT,
    SALARY,
    AVG(SALARY) OVER (PARTITION BY DEPT) AS DEPT_AVG
FROM EMPLOYEE
QUALIFY SALARY BETWEEN 
       (AVG(SALARY) OVER (PARTITION BY DEPT) * 0.90)
   AND (AVG(SALARY) OVER (PARTITION BY DEPT) * 1.10);


