SELECT * INTO CustomerCopy
FROM Customers


-- TRIGGERS

-- DDL TRIGGER
-- DML TRIGGER -> Insert Update Delete
-- AFTER(FOR) - INSTEAD OF

CREATE TRIGGER DeleteCustomers
ON Customers
AFTER DELETE
AS
BEGIN
	INSERT INTO CustomersLog
	VALUES('XXXXX')
END

DELETE FROM Customers
WHERE CustomerID = 'TECHC'

TRUNCATE TABLE CustomersLog

ALTER TRIGGER DeleteCustomers
ON Customers
AFTER DELETE
AS
BEGIN
	--DECLARE @name AS NVARCHAR(50)
	--DECLARE @id AS CHAR(5)

	--SELECT @name = CompanyName,
	--       @id = CustomerID
	--FROM deleted

	SELECT * FROM deleted

	--INSERT INTO CustomersLog
	--VALUES(@id,@name,SUSER_NAME(),GETDATE())

END

DISABLE TRIGGER DeleteCustomers ON Customers
DELETE FROM Customers WHERE CustomerID = 'TECHC'
ENABLE TRIGGER DeleteCustomers ON Customers

DROP TRIGGER DeleteCustomers

-------------------------------------------------
CREATE TRIGGER StokGuncelle
ON [Order Details]
AFTER INSERT
AS
BEGIN
	DECLARE @productID AS INT
	DECLARE @quantity AS SMALLINT

	SELECT @productID = ProductID,
	       @quantity = Quantity
    FROM inserted

	UPDATE Products
	SET UnitsInStock -= @quantity
	WHERE ProductID = @productID
END

INSERT INTO [Order Details]
VALUES(10248,1,20,10,0)

------------------------------------------------
-- INSTEAD OF
CREATE TRIGGER UpdateShipper
ON Shippers
INSTEAD OF UPDATE
AS
BEGIN
	IF SUSER_NAME() != 'admin'
	BEGIN
		DECLARE @oldName AS NVARCHAR(40)
		DECLARE @newName AS NVARCHAR(40)

		SELECT @oldName = CompanyName
		FROM deleted

		SELECT @newName = CompanyName
		FROm inserted

		IF @newName != @oldName
		BEGIN
			PRINT 'Şirket adını güncelleme yetkiniz yoktur'
		END
		ELSE
		BEGIN
			DECLARE @phone AS NVARCHAR(24)
			DECLARE @shipperID AS INT

			SET @shipperID = (SELECT ShipperID FROM deleted)
			SET @phone = (SELECT Phone FROM inserted)

			UPDATE Shippers
			SET Phone = @phone
			WHERE ShipperID = @shipperID
		END

	END
END

UPDATE Shippers
SET CompanyName = 'TechCareer'
WHERE ShipperID = 3

UPDATE Shippers
SET Phone = '12345'
WHERE ShipperID = 3


CREATE TRIGGER IslemYap
ON Shippers
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
		PRINT 'Güncelleme işlemi'
	ELSE IF EXISTS(SELECT * FROM inserted)
		PRINT 'Ekleme işlemi'
	ELSE IF EXISTS(SELECT * FROM deleted)
		PRINT 'Silme işlemi'
END

INSERT INTO Shippers(CompanyName)
VALUES('TechCareer')

UPDATE Shippers
SET Phone = '134332'
WHERE ShipperID = 100

DELETE FROM Shippers
WHERE ShipperID=100