-- CRUD

INSERT INTO Categories([Description],Picture,CategoryName)
VALUES('Her türlü süt, peynir vs.',NULL,'Þarküteri')

SELECT * FROM Categories

INSERT INTO Categories(CategoryName)
VALUES('Kozmetiklknlkrnkejrnkejrnfkjrenfkejrnfkejnf')


SET IDENTITY_INSERT Categories ON

INSERT INTO Categories(CategoryID,CategoryName)
VALUES(50,'Kozmetik')

SET IDENTITY_INSERT Categories OFF


INSERT INTO Categories(CategoryName)
VALUES('Tekstil')


INSERT INTO Shippers(CompanyName)
VALUES('Bizim Kargo'),('Sizin Kargo'),('X Kargo')

SELECT *
FROM (VALUES('Bizim Kargo'),('Sizin Kargo'),('X Kargo')) DATASOURCE(KargoAdi)

INSERT INTO Shippers(CompanyName,Phone)
SELECT CompanyName,Fax FROM Customers

-- BULK COPY/INSERT

SELECT *
INTO CustomersCopy
FROM Customers


SELECT FirstName, LastName
INTO Calisanlar
FROM Employees


-- UPDATE
UPDATE CustomersCopy
SET CompanyName = 'TechCareer'

UPDATE Calisanlar
SET FirstName = 'Marty'
WHERE FirstName='Nancy'

UPDATE Shippers
SET CompanyName = 'Y Kargo',
    Phone = '12324'
WHERE ShipperID = 4

UPDATE Products
	SET UnitPrice += 10


-- DELETE
DELETE Calisanlar

DELETE FROM CustomersCopy

DELETE FROM Shippers WHERE ShipperID > 3

INSERT INTO Shippers(CompanyName)
VALUES('X Kargo')


SELECT *
INTO ProductsCopy
FROM Products

DELETE FROM ProductsCopy

INSERT INTO ProductsCopy(ProductName, Discontinued)
VALUES('Telefon', 0)

SELECT * FROM ProductsCopy

---------------------

TRUNCATE TABLE Products

DROP TABLE ProductsCopy