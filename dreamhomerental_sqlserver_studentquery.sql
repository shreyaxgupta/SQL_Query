-- Script dreamhomerental_sqlserver_student.sql will create the following tables: 

-- Branch(branchNo, street, city, postcode)
-- Staff(staffNo, fName, lName, branchNo) branchNo is FK
-- PropertyForRent(propertyNo, street, .. ownerNo, staffNo, branchNo)
--                   FK are ownerNo and staffNo and branchNo
-- Client(clientNo  ..)
-- PrivateOwner(ownerNo, ..)
-- Viewing(clientNo, propertyNo, ů) PK=(clientNo,propertyNo) FK=clientNo and FK=propertyNo
-- Registration(clientNo,branchNo, staffNo,  ) PK=clientNo FK=branchNo  and staffNo

-- List the fname and lname of all staff.
SELECT s.fname, s.lname
FROM staff s; 

fName	lName
Mary                	Howe                
David               	Ford                
Ann                 	Beech               
Susan               	Brand               
John                	White               
Julie               	Lee                 

-- List the fname and lname of staff who manage properties.
SELECT s.fname, s.lname
FROM staff s, propertyforrent pfr
WHERE s.staffno = pfr.staffno;

fName	lName
Mary                	Howe                
David               	Ford                
Ann                 	Beech               
Ann                 	Beech               
Julie               	Lee   

-- List the fname and lname of staff who currently do not manage any properties.á
SELECT s1.fname, s1.lname, s1.staffno
FROM staff s1
EXCEPT
SELECT s2.fname, s2.lname, s2.staffno
FROM staff s2, propertyforrent pfr
WHERE s2.staffno = pfr.staffno;

fname	lname	staffno
Susan               	Brand               	SG5       
John                	White               	SL21      

-- List the names of clients who have viewed a property for rent in 'Glasgow'.
SELECT c1.lname
FROM client c1
INTERSECT
SELECT c2.lname
FROM client c2, viewing v2, propertyforrent pfr2
WHERE v2.clientno = c2.clientno AND pfr2.propertyno = v2.propertyno AND pfr2.city = 'Glasgow';

lname
Kay
Stewart

-- List the names of clients who have not viewed a property for rent in 'Glasgow'.
SELECT c1.lname
FROM client c1
EXCEPT
SELECT c2.lname
FROM client c2, viewing v2, propertyforrent pfr2
WHERE v2.clientno = c2.clientno AND pfr2.propertyno = v2.propertyno AND pfr2.city = 'Glasgow';

lname
Ritchie             
Tregear             


-- Run script company_sqlserver_student.sql to create the following tables:  
--
-- Employee(fName, lName, SSN, bDate, address, sex, salary, superSSN, dNo)
-- Department(dName, dNo, mgrSSN, mgrStartDate)
-- Dept_locations(dNo, dLocation)
-- Project(pName, pNo, pLocation, dNo)
-- WorksOn(SSN, pNo, hours)
-- Dependent(SSN, dependent_name, sex, bDate, relationship) 

-- List the names of employees who work on BOTH projects 1 AND 2.
SELECT e1.fname, e1.lname
FROM EMPLOYEE e1, WorksOn wo1
WHERE e1.SSN = wo1.SSN AND wo1.pno ='1'
INTERSECT
SELECT e2.fname, e2.lname
FROM EMPLOYEE e2, WorksOn wo2
WHERE e2.SSN = wo2.SSN AND wo2.pno ='2';

fname	lname
John                	Smith               
Franklin            	Wong                
Joyce               	English             

-- List the names of employees who work on BOTH projects ProductX AND ProductY. 
SELECT e1.fname, e1.lname
FROM EMPLOYEE e1, PROJECT px, WorksOn wo1
WHERE e1.dno = px.dno AND wo1.pno = px.pno AND wo1.ssn = e1.ssn AND px.pname = 'ProductX'
INTERSECT
SELECT e2.fname, e2.lname
FROM EMPLOYEE e2, PROJECT py, WorksOn wo2
WHERE e2.dno = py.dno AND wo2.pno = py.pno AND wo2.ssn = e2.ssn AND py.pname = 'ProductY'

fname	lname
John                	Smith               
Franklin            	Wong                
Joyce               	English   

-- List the name of the employee, the name of their department, and the 
-- name  of the manager of this department.
SELECT e.fname AS 'EMP_FNAME', d.dname, e1.fname AS 'MGR_FNAME'
FROM EMPLOYEE e, DEPARTMENT d, EMPLOYEE e1
WHERE e.dno = d.dno AND d.mgrssn = e1.ssn

EMP_FNAME	dname		MGR_FNAME
John            Research        Franklin            
Franklin        Research        Franklin            
Joyce           Research        Franklin            
Ramesh          Research        Franklin            
James           Headquater      James               
Jennifer        Administration  Jennifer            
Ahmad           Administration  Jennifer            
Alicia          Administration  Jennifer            
