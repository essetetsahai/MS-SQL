--Querying Multiple Tables

--1. Retrieve only employee records that correspond to departments in the departments table.

select *
from EMPLOYEES
where DEP_ID in (select DEPT_ID_DEP	
				 from DEPARTMENTS)

--2. Retrieve list of employees only in L0002 location

select *
from EMPLOYEES
where DEP_ID in (select DEPT_ID_DEP
				 from DEPARTMENTS
				 where LOC_ID = 'L0002')

--3. Retrieve dept ID and dept name for employees who earn more than $70k

select DEPT_ID_DEP, DEP_NAME
from DEPARTMENTS
where DEPT_ID_DEP in (select DEP_ID
					  from EMPLOYEES
					  where SALARY > 70000)

				
-----------------------------------------------------------------------------
--                                                                         --
--          Accessing Multiple Tables with Implicit Join                   --
--                                                                         --
-----------------------------------------------------------------------------

-- Specify 2 tables in the FROM clause
-- Complete a full join of the EMPLOYEES and DEPARTMENTS tables
select * 
from EMPLOYEES, DEPARTMENTS  --results in full join


-- Only show results for matching departments in EMPLOYEES and DEPARTMENTS tables
select * 
from EMPLOYEES, DEPARTMENTS
where EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP --specify the table name.column name for each

-- Use shorter aliases for table names
select *
from EMPLOYEES E, DEPARTMENTS D
where E.DEP_ID = D.DEPT_ID_DEP


-- List employee ID(from employee table) and department name (from departments table)
select EMP_ID, DEP_NAME
from EMPLOYEES E, DEPARTMENTS D
where D.DEPT_ID_DEP = E.DEP_ID


---------------------------------------------------------------------------------------

--LAB:WORKING WITH MULTIPLE TABLES
--Exercise 1: Accessing Multiple Tables with Sub-Queries


--1. Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table
select *
from EMPLOYEES
where JOB_ID in (select JOB_IDENT
				 from JOBS)

--2. Retrieve only list of employees whose JOB_TITLE is Jr. Designer.
select *
from EMPLOYEES
where JOB_ID in (select JOB_IDENT
				 from JOBS
				 where JOB_TITLE = 'Jr. Designer')

--3. Retrieve JOB information and list of employees who earn more than 70,000
select *
from JOBS 
where JOB_IDENT in (select JOB_ID
					from EMPLOYEES
					where SALARY > '70000')

--4. Retrieve JOB information for employees whos birth year is after 1976
select *
from JOBS
where JOB_IDENT in (select JOB_ID
					from EMPLOYEES
					where YEAR(B_DATE) > 1976)

--4. Retrieve JOB information and list of female employees whose birth year is after 1976
select *
from JOBS
where JOB_IDENT in (select JOB_ID
					from EMPLOYEES
					where YEAR(B_DATE) > 1976 and SEX = 'F')



--Exercise 2: Accessing Multiple Tables with Implicit Joins

--1. Perform an implict catersian/cross join between Employees and Jobs Tables
select *
from EMPLOYEES, JOBS

--2. Retrieve only EMPLOYEES records that correspond to jobs in the JOBS table
select *
from EMPLOYEES, JOBS 
where EMPLOYEES.JOB_ID = JOBS.JOB_IDENT

--3. Redo above question, using shorter aliases for table names
select *
from EMPLOYEES E, JOBS J
where E.JOB_ID = J.JOB_IDENT

--4. Redo above problem but retrieve only Employee ID, Employee Name and Job Title
select EMP_ID, F_NAME, L_NAME, JOB_TITLE
from EMPLOYEES E, JOBS J
where E.JOB_ID = J.JOB_IDENT

--5. Redo above query but specify fully qualified names with aliases in the SELECT clause
select E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
from EMPLOYEES E, JOBS J
where E.JOB_ID = J.JOB_IDENT

--7-7

--Query Name and Start date for each person in the EMPLOYEE table (Lc)

select F_NAME, L_NAME, START_DATE 
from EMPLOYEES left join JOB_HISTORY 
on EMPLOYEES.EMP_ID = JOB_HISTORY.EMPL_ID

--Query the second highest salary from the EMPLOYEE table (Lc)

select distinct SALARY as SecondHighestSalary 
from EMPLOYEES
order by SALARY desc
offset 1 row
fetch next 1 row only

--Sort rows in the EMPLOYEE table first by DEP_ID ascending, then by SALARY descending

select * 
from EMPLOYEES 
order by DEP_ID, SALARY desc 

--sort by MANAGER_ID in ascending order, with null values last
--case when - assign null values to 0 
select F_NAME, L_NAME, MANAGER_ID 
from (
	select F_NAME, L_NAME, MANAGER_ID, 
	case when MANAGER_ID is null then 0 else 1 end as is_null 
	from EMPLOYEES
	) x
order by is_null desc, MANAGER_ID
