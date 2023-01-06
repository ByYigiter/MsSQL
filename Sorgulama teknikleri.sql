-- Sorgulama Teknikleri
SELECT e.FirstName + ' ' + e.LastName AS Calisan,
       COUNT(o.OrderID) AS SiparisSayisi
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName + ' ' + e.LastName


SELECT *
FROM (SELECT e.FirstName + ' ' + e.LastName AS Calisan
	  FROM Employees e
	  JOIN Orders o ON e.EmployeeID = o.EmployeeID
     ) g
PIVOT
(
	COUNT(Calisan)
	FOR Calisan IN([Nancy Davolio],[Andrew Fuller])
) AS pvt


--SELECT *
--FROM (SELECT e.FirstName + ' ' + e.LastName AS Calisan
--	  FROM Employees e
--	  JOIN Orders o ON e.EmployeeID = o.EmployeeID
--	  WHERE FirstName = 'Nancy'
--     ) g
--PIVOT
--(
--	COUNT(Calisan)
--	FOR Calisan IN([Nancy Davolio],[Andrew Fuller])
--) AS pvt


SELECT * FROM
	(SELECT c.CategoryName,
		   od.UnitPrice * od.Quantity * (1 - od.Discount) AS Tutar
	FROM Categories c
	JOIN Products p ON c.CategoryID = p.CategoryID
	JOIN [Order Details] od ON p.ProductID = od.ProductID
) CategorySales
PIVOT
(
	SUM(Tutar)
	FOR CategoryName IN([Beverages],[Confections],[Seafood]) 
) pvt

-------------------------------------------------------
SELECT ISNULL(Country,'Toplam'),
       COUNT(CustomerID)
FROM Customers
GROUP BY CUBE(Country)

SELECT ISNULL(Country,'Toplam'),
       ISNULL(City, Country + ' Toplamý'),
	   COUNT(CustomerID)
FROM Customers
GROUP BY ROLLUP(Country, City)

-----------------------------------------------
-- Ranking Functions
SELECT CustomerID,
       CompanyName,
	   Country,
	   ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Country) AS SatirNo
FROM Customers


-- Hangi ülkeye en yüksek tutarlý sipariþ kalemi hangi sipariþtedir?
SELECT *
FROM
(SELECT o.ShipCountry,
       o.OrderID,
	   Quantity * UnitPrice * (1 - Discount) AS Tutar,
	   ROW_NUMBER() OVER(PARTITION BY o.ShipCountry ORDER BY (Quantity * UnitPrice * (1 - Discount)) DESC) AS RowNo
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID) AS Siparis
WHERE RowNo = 1


-- Hangi ülkeye en yüksek tutarlý hangi sipariþ?
SELECT t.ShipCountry, t.OrderID, t.Tutar
FROM
(SELECT *,
       ROW_NUMBER() OVER(PARTITION BY ShipCountry ORDER BY Tutar DESC) AS SatirNo
FROM
(SELECT o.ShipCountry,
       o.OrderID,
	   SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Tutar
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry, o.OrderID) AS UlkeSiparisToplam) AS t
WHERE t.SatirNo = 1



SELECT UnitPrice,
       ProductID,
	   RANK() OVER(PARTITION BY ProductID ORDER BY UnitPrice) AS SatirNo
FROM [Order Details]


SELECT UnitPrice,
       ProductID,
	   DENSE_RANK() OVER(PARTITION BY ProductID ORDER BY UnitPrice) AS SatirNo
FROM [Order Details]