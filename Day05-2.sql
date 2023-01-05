-- JOIN yazmadan JOIN

SELECT p.ProductName,
       c.CategoryName
FROM Products p, Categories c
--WHERE Products.CategoryID = Categories.CategoryID
WHERE p.CategoryID = c.CategoryID


-- INNER JOIN
SELECT p.ProductName,
       c.CategoryName
FROM Products p
INNER JOIN Categories c
	ON p.CategoryID = c.CategoryID


SELECT p.ProductName,
       c.CategoryName
FROM Products p
JOIN Categories c
	ON p.CategoryID = c.CategoryID


-- OUTER JOIN
SELECT p.ProductName,
       c.CategoryName
FROM Products p
LEFT JOIN Categories c
	ON p.CategoryID = c.CategoryID

SELECT p.ProductName,
       c.CategoryName
FROM Products p
RIGHT JOIN Categories c
	ON p.CategoryID = c.CategoryID

SELECT p.ProductName,
       c.CategoryName
FROM Categories c
LEFT JOIN Products p
	ON p.CategoryID = c.CategoryID

SELECT p.ProductName,
       c.CategoryName
FROM Products p
FULL JOIN Categories c
	ON p.CategoryID = c.CategoryID


-- CROSS JOIN
SELECT p.ProductName,
       c.CategoryName
FROM Products p
CROSS JOIN Categories c

----------------------------------------------------
-- Her çalýþaný amiriyle beraber listeleyin. Calisan | Amir
SELECT calisan.FirstName + ' ' + calisan.LastName AS Calisan,
       amir.FirstName + ' ' + amir.LastName AS Amir
FROM Employees calisan
LEFT JOIN Employees amir
	ON calisan.ReportsTo = amir.EmployeeID


-- Beverages kategorisinden sipariþ vermiþ müþteriler kimlerdir?
SELECT DISTINCT c.CompanyName
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
				 JOIN [Order Details] od ON o.OrderID = od.OrderID
				 JOIN Products p ON od.ProductID = p.ProductID
				 JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName='Beverages'


-- Hangi sipariþ hangi müþteri tarafýndan verilmiþ ve hangi çalýþan ilgilenmiþ?
SELECT o.OrderID,
       c.CompanyName,
	   e.FirstName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID