CREATE TABLE IF NOT EXISTS Flights (
    flno INTEGER NOT NULL PRIMARY KEY,  
    `from` NVARCHAR(50) NOT NULL,
    `to` NVARCHAR(50) NOT NULL,
	distance INTEGER NOT NULL,
	departs time NOT NULL,
	arrives time NOT NULL
);
INSERT INTO Flights VALUES (1, 'Bonn', 'Madras', 1000, 3:00, 18:00);
INSERT INTO Flights VALUES (2, 'Canada', 'USA', 123, 11:00, 18:00);
INSERT INTO Flights VALUES (3, 'Sydney', 'Barcelona', 1233, 5:00, 13:00);
INSERT INTO Flights VALUES (4, 'London', 'Sylhet', 10, 7:00, 20:00);
INSERT INTO Flights VALUES (5, 'Miami', 'Greenland', 3500, 12:00, 13:00);

CREATE TABLE IF NOT EXISTS Aircraft (
    aid INTEGER NOT NULL PRIMARY KEY,  
    aname NVARCHAR(50) NOT NULL,
    cruisingrange INTEGER NOT NULL
);
INSERT INTO Aircraft VALUES (1, 'Boeing', 30000);
INSERT INTO Aircraft VALUES (2, 'Cracker', 420);
INSERT INTO Aircraft VALUES (3, 'Dawnia', 5500);
INSERT INTO Aircraft VALUES (4, 'Elvy', 15990);
INSERT INTO Aircraft VALUES (5, 'Fredo', 1);

CREATE TABLE IF NOT EXISTS Employee (
    eid INTEGER NOT NULL PRIMARY KEY,  
    ename NVARCHAR(50) NOT NULL,
    salary INTEGER NOT NULL
);

INSERT INTO Employee VALUES (1, 'Alfred', 76000);
INSERT INTO Employee VALUES (2, 'Booligan', 200000);
INSERT INTO Employee VALUES (3, 'Collins', 200000);
INSERT INTO Employee VALUES (4, 'Dulligan', 1);
INSERT INTO Employee VALUES (5, 'Elliot', 95000);

CREATE TABLE IF NOT EXISTS Certified (
    eid INTEGER NOT NULL,  
    aid INTEGER NOT NULL,
	FOREIGN KEY (eid) REFERENCES Employee(eid),
	FOREIGN KEY (aid) REFERENCES Aircraft(aid)
);

INSERT INTO Certified VALUES (1, 1);
INSERT INTO Certified VALUES (1, 2);
INSERT INTO Certified VALUES (1, 3);
INSERT INTO Certified VALUES (2, 1);
INSERT INTO Certified VALUES (2, 3);
INSERT INTO Certified VALUES (2, 5);
INSERT INTO Certified VALUES (3, 1);
INSERT INTO Certified VALUES (3, 2);
INSERT INTO Certified VALUES (3, 3);
INSERT INTO Certified VALUES (3, 4);
INSERT INTO Certified VALUES (4, 1);
INSERT INTO Certified VALUES (5, 1);
INSERT INTO Certified VALUES (5, 2);
INSERT INTO Certified VALUES (5, 3);

-- QUERY 

-- Question 2 i
SELECT C.eid
FROM Certified C, Aircraft A
WHERE A.aname = 'Boeing' and C.aid = A.aid

-- Question 2 ii
SELECT E.ename
FROM Employee E, Certified C, Aircraft A
WHERE A.aname = 'Boeing' and A.aid = C.aid and C.eid = E.eid

-- Question 2 iii
SELECT A.aid
FROM Aircraft A, Flights F
WHERE F.from = 'Bonn' and F.to = 'Madras' and F.distance <= A.cruisingrange

-- Question 2 iv 
SELECT F.flno
FROM Flights F, Certified C, Aircraft A, Employee E
WHERE E.salary > 100000 and F.distance <= A.cruisingrange and C.eid = E.eid and C.aid = A.aid

-- Question 2 v 
SELECT E.ename
FROM Employee E, Certified C, Aircraft A
WHERE A.cruisingrange > 3000 and A.aname = 'Boeing' and E.eid = C.eid and C.aid = A.aid

-- Question 2 vi
SELECT 
