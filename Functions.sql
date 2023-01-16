-- User Defined Functions

-- Scalar Valued Functions
CREATE FUNCTION fn_Topla(@sayi1 AS INT, @sayi2 AS INT)
RETURNS INT
AS
BEGIN
	DECLARE @sonuc AS INT
	SET @sonuc = @sayi1 + @sayi2
	RETURN @sonuc
END

ALTER FUNCTION fn_Topla(@sayi1 AS INT, @sayi2 AS INT = 100)
RETURNS INT
AS
BEGIN
	DECLARE @sonuc AS INT
	SET @sonuc = @sayi1 + @sayi2
	RETURN @sonuc
END

--SELECT dbo.fn_Topla(10,20)
SELECT dbo.fn_Topla(25,DEFAULT)
SELECT dbo.fn_Topla(25,50)

CREATE FUNCTION FiyatHesapla(@quantity AS INT, @price AS DECIMAL, @discount AS FLOAT)
RETURNS DECIMAL
AS
BEGIN
	RETURN @quantity * @price * (1 - @discount)
END

-- Her ülkeye gönderilen siparişlerden ne kadar kazanılmıştır?
SELECT o.ShipCountry,
       SUM(dbo.FiyatHesapla(od.Quantity,od.UnitPrice,od.Discount))
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry


CREATE FUNCTION GetFullname(@name AS NVARCHAR(30), @surname AS NVARCHAR(50))
RETURNS NVARCHAR(80)
AS
BEGIN
	RETURN @name + ' ' + @surname
END

SELECT dbo.GetFullname(FirstName, LastName)
FROM Employees


-- Table Valued Functions
--DECLARE @data AS TABLE
--SET @data = (SELECT * FROM Customers)


CREATE FUNCTION SehreGoreMusteriGetir(@sehir AS NVARCHAR(20))
RETURNS TABLE
AS
RETURN (SELECT * FROM Customers WHERE City = @sehir)


SELECT *
FROM dbo.SehreGoreMusteriGetir('London')

SELECT *
FROM dbo.SehreGoreMusteriGetir('Strasbourg')

SELECT *
FROM dbo.SehreGoreMusteriGetir('London') c
JOIN Orders o ON c.CustomerID = o.CustomerID


SELECT *
FROM dbo.SehreGoreMusteriGetir('London') c
CROSS APPLY Orders o
WHERE c.CustomerID = o.CustomerID

SELECT *
FROM dbo.SehreGoreMusteriGetir('London') c
OUTER APPLY Orders o
WHERE c.CustomerID = o.CustomerID

-- Multi-Statement Table Valued Function
ALTER FUNCTION GetOrderInfoByCategory(@categoryName AS NVARCHAR(15))
RETURNS @orderInfo TABLE
(
	CompanyName NVARCHAR(40) NOT NULL,
	ContactName NVARCHAR(30) NULL,
	Employee NVARCHAR(50) NOT NULL
)
AS
BEGIN
	INSERT @orderInfo
	SELECT c.CompanyName,
	       c.ContactName,
		   e.FirstName + ' ' + e.LastName AS Employee
	FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
	JOIN [Order Details] od ON o.OrderID = od.OrderID
	JOIN Products p ON od.ProductID = p.ProductID
	JOIN Categories cat ON p.CategoryID = cat.CategoryID
	JOIN Employees e ON o.EmployeeID = e.EmployeeID
	WHERE cat.CategoryName = @categoryName

	RETURN
END

SELECT * FROM dbo.GetOrderInfoByCategory('Seafood')