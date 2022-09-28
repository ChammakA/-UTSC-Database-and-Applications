--foreign key CONSTRAINT
-- INSERT INTO student VALUES(78999, 'John', 20, 120);

-- Selecting distinct department from student table
SELECT DISTINCT DepartmentId
FROM student;

-- select departments with budget >= 90000
SELECT dept_name
FROM department
WHERE budget >= 90000;

-- Select name, and IDs of students in ascending order of names
SELECT name, StudentId
FROM student
ORDER BY name ASC; 

-- Select 10 students with names and IDs
SELECT StudentId, name
FROM student
LIMIT 10;

-- In the following example, we will join the two tables "Students" 
-- and "Departments" with DepartmentId to get the department name 
-- for each student, as follows:
SELECT
  student.name,
  department.dept_name
FROM student
INNER JOIN department ON student.DepartmentId = department.DepartmentId;

-- In the following example, we will join the two tables "Students" 
-- and "Departments" with DepartmentId to get the department name 
-- for each student, as follows:
SELECT
  student.name,
  department.dept_name
FROM student
INNER JOIN department USING(DepartmentId);

-- In the following example, we will try the "LEFT JOIN" 
-- to join the two tables "Students" and "Departments":
SELECT
  student.name,
  department.dept_name
FROM student
LEFT JOIN department ON student.DepartmentId = department.DepartmentId;

-- In the following query we will try CROSS JOIN between 
-- the Students and Departments tables:
SELECT
  student.name,
  department.dept_name
FROM student
CROSS JOIN department;

--ORDER BY
-- In the following example, we will select all the students ordered by 
-- their names but in descending order, then by the department name in ascending order:
SELECT s.name, d.dept_name
FROM student AS s
INNER JOIN department AS d ON s.DepartmentId = d.DepartmentId
ORDER BY d.dept_name ASC , s.name DESC;

--Remove duplicates using DISTINCT
SELECT DISTINCT d.dept_name
FROM student AS s
INNER JOIN department AS d ON s.DepartmentId = d.DepartmentId;

-- AGRREGATE
--AVG()
SELECT AVG(mark) FROM mark;
Returns the total count of the number of times the x value appeared. And here are some options you can use with COUNT:

--COUNT()
-- COUNT(x): Counts only x values, where x is a column name. It will ignore NULL values.
-- COUNT(*): Count all the rows from all the columns.
-- COUNT (DISTINCT x): You can specify a DISTINCT keyword before the x which will 
--          get the count of the distinct values of x.
SELECT COUNT(DepartmentId), 
	COUNT(DISTINCT DepartmentId), 
	COUNT(*) FROM student;
	
-- MAX() & MIN()
-- MAX(X) returns you the highest value from the X values. 
-- MAX will return a NULL value if all the values of x are null. 
-- Whereas MIN(X) returns you the smallest value from the X values. 
-- MIN will return a NULL value if all the values of X are null.
SELECT MAX(mark), MIN(mark) FROM mark;

-- SUM(x), Total(x)
-- 
-- Both of them will return the sum of all the x values. 
-- But they are different in the following:
-- SUM will return null if all the values are null, but Total will return 0.
-- TOTAL always returns floating point values. 
-- SUM returns an integer value if all the x values are an integer. 
-- However, if the values are not an integer, it will return a floating point value.
SELECT SUM(mark), TOTAL(mark) FROM mark;

-- BETWEEN
-- Select students with credit between 50 and 100
SELECT name, tot_cred
FROM student
WHERE
	tot_cred BETWEEN 50 and 100
ORDER BY
	tot_cred;
	
-- IN operator
-- The following statement uses the IN operator to query 
-- the student whose department is either 1, 2 or 3
SELECT name, tot_cred, DepartmentId
FROM student
WHERE
	DepartmentId IN (1, 2, 3)
ORDER BY
	name ASC;
	
--like operator
--Find names of students and department ID that start with 'B'
SELECT name, DepartmentId
FROM student
WHERE
	name LIKE 'B%'

--IS NULL
--Find students whose depratment IDs are unknown
SELECT name, tot_cred, DepartmentId
FROM student
WHERE
	DepartmentId IS NULL
ORDER BY
	name ASC;
	
--GROUP BY
-- The following query will give you the total number 
-- of students present in each department.
SELECT d.dept_name, COUNT(s.StudentId) AS StudentsCount
FROM student AS s 
INNER JOIN department AS d ON s.DepartmentId = d.DepartmentId
GROUP BY d.dept_name;

	
--HAVING clause
-- In the following query, we will select those departments 
-- that have only two students on it:
SELECT d.dept_name, COUNT(s.StudentId) AS StudentsCount
FROM student AS s 
INNER JOIN department AS d ON s.DepartmentId = d.DepartmentId
GROUP BY d.dept_name
HAVING COUNT(s.StudentId) = 2;


-- Following is a basic syntax of sqlite3 command to create the View
CREATE VIEW AllStudentsView
AS
  SELECT 
    s.StudentId,
    s.name,
    s.tot_cred,
    d.dept_name
FROM student AS s
INNER JOIN department AS d ON s.DepartmentId = d.DepartmentId;

-- Now our view is created, you can use it as a normal table something like this:
SELECT * FROM AllStudentsView;

--temporary view
CREATE TEMP VIEW AllStudentsViewTemp
AS
  SELECT 
    s.StudentId,
    s.name,
    s.tot_cred,
    d.dept_name
FROM student AS s
INNER JOIN department AS d ON s.DepartmentId = d.DepartmentId;

SELECT * FROM AllStudentsViewTemp;

--To delete a VIEW, you can use the "DROP VIEW" statement:
DROP VIEW AllStudentsView;

--SET operations

--UNION
-- In the following example, we will get the list of DepartmentId 
-- from the students table and the list of the DepartmentId from the 
-- departments table in the same column:
SELECT TestId AS TestIdUnioned FROM mark
UNION
SELECT TestId FROM test;

-- UNION ALL 
-- In the following example, we will get the list of TestId 
-- from the mark table and the list of the TestId from 
-- the test table in the same column:
SELECT TestId AS TestIdUnioned FROM mark
UNION ALL
SELECT TestId FROM test;
--rows from mark + rows from test

--INTERSECT
--In the following query, we will select the TestId values 
-- that exist in both the tables mark and test
-- in the TestId column:
SELECT TestId FROM mark
INTERSECT
SELECT TestId FROM test;

--EXCEPT
-- In the following query, we will select the TestId values 
-- that exist in the test table and doesn't exist in the mark table:
SELECT TestId FROM test
EXCEPT
SELECT TestId FROM mark;