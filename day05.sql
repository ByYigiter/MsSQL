-- Built-in Functions
-- Metinsel

SELECT LOWER('EDGAR CODD')
SELECT UPPER('edgar codd')

SELECT REVERSE('akin')

SELECT '         edgar codd'
SELECT LTRIM('         edgar codd')
SELECT RTRIM('edgar codd        ')

SELECT LEN('    edgar codd   ')
SELECT LEN(LTRIM('    edgar codd'))
SELECT LEN('edgar codd        ')
SELECT LEN(RTRIM('edgar codd        '))


SELECT DATALENGTH('Türkiye')
SELECT DATALENGTH(1234576)


SELECT LEFT('istanbul',3)
SELECT RIGHT('istanbul',3)

-- Ülkesinin son harfi y olan müşteriler
SELECT *
FROM Customers
WHERE RIGHT(Country,1) = 'y'

SELECT SUBSTRING('istanbul',3,3)

SELECT CHARINDEX('e','techcareer', 3)

SELECT REPLACE('ankara','a','e')

SELECT REPLICATE('abc',10)

SELECT STUFF('ankara',2,2,'xxxxxxxxxxx')

------------------------------------------------------
SELECT FirstName, LastName, ISNULL(Region,'Bölgesi Yok') AS Bolge
FROM Employees

SELECT CompanyName, COALESCE(Fax,Region,'Veri Yok')
FROM Customers

--------------------------------------------------------
-- Aggregate Functions
SELECT MAX(UnitPrice)
FROM Products

SELECT MIN(UnitPrice)
FROM Products

SELECT AVG(UnitPrice)
FROM Products

SELECT SUM(UnitsInStock)
FROM Products

SELECT COUNT(*)
FROM Products

SELECT COUNT(Region)
FROM Employees

SELECT DISTINCT Country
FROM Customers

SELECT COUNT(DISTINCT Country)
FROM Customers

-----------------------------------
-- MATH Functions
SELECT PI()

SELECT POWER(2,5)
SELECT POWER(0,0)

SELECT SQRT(25)

SELECT FLOOR(123.78)
SELECT CEILING(123.18)

SELECT ROUND(123.7824335,2)
SELECT ROUND(123.7824335,0)
SELECT ROUND(123.1824335,0)

-----------------------------------------
SELECT CAST('10' AS INT)
SELECT CAST('abc' AS BIGINT)

SELECT CONVERT(INTEGER,'234')
SELECT CONVERT(DATE,'20221218')
SELECT CONVERT(DATETIME,'20221218 20:28')

---------------------------------------
-- Tarih
SELECT GETDATE()
SELECT GETUTCDATE()
SELECT SYSDATETIME()

SELECT CURRENT_TIMESTAMP

SELECT DATEADD(YEAR,10,GETDATE())
SELECT DATEADD(WEEK,10,GETDATE())
SELECT DATEADD(DAY,-5,GETDATE())

SELECT DATENAME(MONTH,GETDATE())
SELECT DATENAME(DAY,GETDATE())
SELECT DATENAME(WEEKDAY,GETDATE())

SELECT DATEPART(MONTH,GETDATE())
SELECT DATEPART(QUARTER,GETDATE())
SELECT DATEPART(DAYOFYEAR,GETDATE())

SELECT DATEDIFF(DAY,GETDATE(),'2025-05-23')
SELECT DATEDIFF(WEEK,GETDATE(),DATEADD(MONTH,134,GETDATE()))
SELECT DATEADD(MONTH,134,GETDATE())

SELECT YEAR(GETDATE())
SELECT MONTH(GETDATE())
SELECT DAY(GETDATE())

SELECT DATEPART(D,DATEADD(DAY,-20,GETDATE()))


-- Çarşamba günü alınan siparişler
SELECT *
FROM Orders
WHERE DATENAME(WEEKDAY,OrderDate) = 'Wednesday'

-- Çalışanlar hangi gün doğmuştur?
SELECT FirstName AS Ad,
       LastName AS Soyad,
	   DATENAME(WEEKDAY,BirthDate) AS DogduguGun
FROM Employees

-- Her ayın 15inde sevk edilen siparişlerden en yüksek kargo ücreti olan siparişin nosu
SELECT TOP 1 OrderID,
             ShippedDate,
			 Freight
FROM Orders
WHERE DAY(ShippedDate) = 15
ORDER BY Freight DESC

--------------------------------------------------
-- CASE WHEN
-- Simple Case When

SELECT FirstName,
       LastName,
	   Gender = CASE TitleOfCourtesy
				 WHEN 'Mr.' THEN 'Erkek'
				 WHEN 'Ms.' THEN 'Kadın'
				 WHEN 'Mrs.' THEN 'Kadın'
				 ELSE 'Bilinmiyor'
			    END
FROM Employees

SELECT CustomerID,
       CompanyName,
	   Country = CASE Country
					WHEN 'USA' THEN 'America'
					WHEN 'UK' THEN 'England'
					ELSE Country
	             END
FROM Customers

-- Searched Case When
SELECT ProductName,
       UnitPrice,
	   CASE
		WHEN UnitPrice < 20 THEN 'Ucuz'
		WHEN UnitPrice < 50 THEN 'Normal'
		ELSE 'Pahalı'
	   END AS FiyatBilgisi
FROM Products

-- Çalışanlardan 60 yaşından küçüklere Genç, 60-75 arası Orta Yaşlı, diğerlerine de Yaşlı
SELECT FirstName + ' ' + LastName AS Calisan,
       DATEDIFF(YEAR,BirthDate,GETDATE()) AS Yas,
	   CASE
		WHEN (YEAR(GETDATE()) - YEAR(BirthDate)) < 60 THEN 'Genç'
		WHEN (YEAR(GETDATE()) - YEAR(BirthDate)) < 75 THEN 'Orta Yaşlı'
		ELSE 'Yaşlı'
	   END AS Bilgi
FROM Employees