-- VIEWS

SELECT ProductName, UnitPrice, UnitsInStock
FROM Products

SELECT * FROM Invoices

SELECT *
FROM [Summary of Sales by Quarter]

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'view'

-----------------------------------------------------
-- 1997 yılında çalışanların müşteri bazında satış sayıları
CREATE VIEW vw_1997Siparisleri
AS
SELECT e.FirstName + ' ' + e.LastName AS Calisan,
       c.CompanyName AS Musteri,
	   COUNT(o.OrderID) AS SiparisSayisi
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.CompanyName,e.FirstName, e.LastName


SELECT * FROM vw_1997Siparisleri
WHERE Calisan = 'Nancy Davolio'

SELECT Calisan, SUM(SiparisSayisi)
FROm vw_1997Siparisleri
GROUP BY Calisan


ALTER VIEW vw_1997Siparisleri
AS
SELECT e.FirstName + ' ' + e.LastName AS Calisan,
       c.CompanyName AS Musteri,
	   COUNT(o.OrderID) AS SiparisSayisi
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY c.CompanyName,e.FirstName, e.LastName

SELECT *
FROM vw_1997Siparisleri


DROP VIEW vw_1997Siparisleri

-----------------------------------------------------------
CREATE VIEW vw_Products
AS
SELECT ProductName, UnitPrice, UnitsInStock
FROM Products

INSERT INTO vw_Products
VALUES('Telefon',322,45)


ALTER VIEW vw_Products
AS
SELECT UnitPrice, UnitsInStock
FROM Products

INSERT INTO vw_Products
VALUES(322,45)

----------------------------------------------------
SELECT OBJECT_ID('vw_Products')
SELECT OBJECT_ID('Customers')

SELECT * FROM sys.sql_modules
WHERE OBJECT_ID = OBJECT_ID('vw_Products')

SELECT OBJECT_DEFINITION(OBJECT_ID('Invoices'))
SELECT * FROm sys.tables

-- View Sifreleme
CREATE VIEW vw_LondradaYasayanCalisanlar
WITH ENCRYPTION
AS
SELECT * FROM Employees WHERE City='London'

SELECT * FROM vw_LondradaYasayanCalisanlar


SELECT * FROM sys.sql_modules
WHERE OBJECT_ID = OBJECT_ID('vw_LondradaYasayanCalisanlar')

ALTER VIEW vw_LondradaYasayanCalisanlar
AS
SELECT * FROM Employees WHERE City='London'

-------------------------------------------
--SCHEMA BINDING
CREATE VIEW vw_Kategoriler
WITH SCHEMABINDING
AS
SELECT CategoryName FROM dbo.Categories

SELECT * FROm vw_Kategoriler