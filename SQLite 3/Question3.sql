CREATE TABLE IF NOT EXISTS Suppliers (
    sid INTEGER NOT NULL PRIMARY KEY,  
    sname NVARCHAR(50) NOT NULL,
    address NVARCHAR(50) NOT NULL
);
INSERT INTO Suppliers VALUES (1, 'Saiduck', '1065 Military Trail');
INSERT INTO Suppliers VALUES (2, 'Big Dinguz', '456 Big Boonda Avenue');
INSERT INTO Suppliers VALUES (3, 'Lazer', '789 Big Broker Avenue');
INSERT INTO Suppliers VALUES (4, 'Ball Handlez', '22 Big Bull Avenue');
INSERT INTO Suppliers VALUES (5, 'Canada Suppliers', '24 Big Between Avenue');

CREATE TABLE IF NOT EXISTS Parts (
    pid INTEGER NOT NULL PRIMARY KEY,  
    pname NVARCHAR(50) NOT NULL,
    color NVARCHAR(15) NOT NULL
);
INSERT INTO Parts VALUES (10, 'Hands', 'red');
INSERT INTO Parts VALUES (11, 'Feet', 'green');
INSERT INTO Parts VALUES (12, 'Eyes', 'blue');
INSERT INTO Parts VALUES (13, 'Toes', 'red');
INSERT INTO Parts VALUES (14, 'Fingers', 'green');

CREATE TABLE IF NOT EXISTS Catalog (
    sid INTEGER NOT NULL,  
    pid INTEGER NOT NULL,
    cost REAL NOT NULL,
	FOREIGN KEY (sid) REFERENCES Suppliers(sid),
	FOREIGN KEY (pid) REFERENCES Parts(pid)
);
INSERT INTO Catalog VALUES (1, 10, 21);
INSERT INTO Catalog VALUES (1, 11, 34);
INSERT INTO Catalog VALUES (1, 12, 200);
INSERT INTO Catalog VALUES (2, 10, 421);
INSERT INTO Catalog VALUES (2, 11, 54);
INSERT INTO Catalog VALUES (2, 12, 22);
INSERT INTO Catalog VALUES (2, 13, 444);
INSERT INTO Catalog VALUES (2, 14, 54);
INSERT INTO Catalog VALUES (3, 10, 12);
INSERT INTO Catalog VALUES (3, 12, 45);
INSERT INTO Catalog VALUES (3, 13, 5000);
INSERT INTO Catalog VALUES (3, 14, 67);
INSERT INTO Catalog VALUES (4, 11, 24);
INSERT INTO Catalog VALUES (4, 12, 22);
INSERT INTO Catalog VALUES (4, 13, 44);
INSERT INTO Catalog VALUES (5, 10, 12);
INSERT INTO Catalog VALUES (5, 11, 123);
INSERT INTO Catalog VALUES (5, 12, 1234);
INSERT INTO Catalog VALUES (5, 13, 122);
INSERT INTO Catalog VALUES (5, 14, 199);


-- Question 1 b i
SELECT S.name
FROM Catalog C, Parts P, Suppliers S
WHERE P.color = 'red' and C.pid = P.pid and C.sid = pid

-- Question 1 b ii
SELECT C.sid
FROM Catalog C, Parts P
WHERE (P.color = 'red' or P.color = 'green') and C.pid = P.pid

-- Question 1 b iii
SELECT S.sid
FROM Suppliers S 
WHERE S.address = '1065 Military Trail'
	or	(SELECT C.sid
		 FROM Catalog C, Parts P
		 WHERE P.color = 'red' and C.pid = P.pid)
-- Question 1 b iv
SELECT C.sid
FROM Catalog C, Parts P
WHERE P.color = 'red' and C.pid = P.pid 
	AND EXISTS (SELECT P2.pid
				FROM Parts P2, Catalog C2
				WHERE P2.color = 'green' and P2.pid = C2.pid and C2.sid = C.sid)
-- Question 1 b v
SELECT C.sid 
FROM Catalog C
WHERE NOT EXISTS (SELECT P.pid
				  FROM Parts P
				  WHERE NOT EXISTS (SELECT C2.sid
									FROM Catalog C2
									WHERE C2.sid = C.sid and C2.pid = P.pid))
-- Question 1 b vi
SELECT C.sid
FROM Catalog C
WHERE NOT EXISTS (SELECT P.pid
				  FROM Parts P
				  WHERE P.color = 'red'
				  AND (NOT EXISTS (SELECT C2.sid
									FROM Catalog C2
									WHERE C2.sid = C.sid and C2.pid = P.pid)))		
-- Question 1 b vii
SELECT C.sid
FROM Catalog C
WHERE NOT EXISTS (SELECT P.pid
				  FROM Parts P
				  WHERE P.color = 'red' or P.color = 'green'
				  AND (NOT EXISTS (SELECT C2.sid
									FROM Catalog C2
									WHERE C2.sid = C.sid and C2.pid = P.pid)))						
-- Question 1 b viii
SELECT C.sid
FROM Catalog C
WHERE NOT EXISTS (SELECT P.pid
				  FROM Parts P
				  WHERE P.color = 'red'
				  AND (NOT EXISTS (SELECT C2.sid
									FROM Catalog C2
									WHERE C2.sid = C.sid and C2.pid = P.pid))) 			
		or 	NOT EXISTS (SELECT P2.pid
				  FROM Parts P2
				  WHERE P2.color = 'green'
				  AND (NOT EXISTS (SELECT C3.sid
									FROM Catalog C3
									WHERE C3.sid = C.sid and C3.pid = P2.pid)))
-- Question 1 b ix
SELECT C.sid, C2.sid
FROM Catalog C, Catalog C2
WHERE C2.cost < C.cost and C.pid = C2.pid and C.sid <> C2.sid

-- Question 1 b x
SELECT C.pid
FROM Catalog C
WHERE EXISTS (SELECT C2.sid
			  FROM Catalog C2
			  WHERE C.pid = C2.pid and C.sid <> C2.sid)
-- Question 1 b xi
SELECT C.pid
FROM Catalog C, Suppliers S
WHERE S.address = 'Canada Suppliers' and C.sid = S.sid
				and C.cost = (SELECT max(C2.cost)
							  FROM Catalog C2, Suppliers S2
							  WHERE S2.address = 'Canada Suppliers' and C2.sid = S2.sid)
-- Question 1 b xii
SELECT C.pid
FROM Catalog C, Suppliers S
WHERE C.cost < 200 and C.sid = S.sid							  
							 