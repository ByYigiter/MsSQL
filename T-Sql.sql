-- IDENTITY FUNCTIONS

INSERT INTO Shippers(CompanyName)
VALUES('Y Kargo')

SELECT SCOPE_IDENTITY()

INSERT INTO Categories(CategoryName)
VALUES('Market')

SELECT IDENT_CURRENT('Products')

SELECT @@IDENTITY


----------------------------------------
-- T-SQL
--DECLARE @sayi AS INT = 20

--SELECT @sayi

--SET @sayi = 10
--PRINT @sayi


DECLARE @urunSayisi AS INT

SELECT @urunSayisi = COUNT(*) FROM Products
PRINT @urunSayisi


DECLARE @fullname AS NVARCHAR(30)
SET @fullname = (SELECT FirstName + ' ' + LastName FROM Employees WHERE EmployeeID = 1)
PRINT @fullname


DECLARE @number AS INT = 11
IF @number % 2 = 0
BEGIN
	PRINT 'Sayı çifttir'
END
ELSE
BEGIN
	PRINT 'Sayı tektir'
END


IF EXISTS(SELECT * FROM Products WHERE ProductID = 500)
BEGIN
	PRINT 'Kayıt vardır'
	SELECT * FROM Products WHERE ProductID = 50
END
ELSE
BEGIN
	PRINT 'Kayıt yoktur'
END

IF NOT EXISTS(SELECT * FROM Products WHERE ProductID = 500)
BEGIN
	PRINT 'Kayıt yoktur'
END
ELSE
BEGIN
	PRINT 'Kayıt vardır'
	SELECT * FROM Products WHERE ProductID = 50
END

--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'
--PRINT 'Akın Karabulut'


DECLARE @sayac AS INT = 1
WHILE @sayac <= 10
BEGIN
	PRINT @sayac
	--SET @sayac = @sayac + 1
	SET @sayac += 1
END


-- ID'si tek olan çalışanlar
--DECLARE @counter AS INT = 1
--DECLARE @employeeCount AS INT
--DECLARE @employeeID AS INT
--DECLARE @name AS NVARCHAR(10)


--SELECT @employeeCount = COUNT(*) FROM Employees

--WHILE @counter <= @employeeCount
--BEGIN
--	SELECT @employeeID = EmployeeID,
--	       @name = FirstName
--	FROM Employees
--	WHERE EmployeeID = @counter


--	IF @employeeID % 2 = 1
--	BEGIN
--		PRINT @name
--	END

--	SET @counter += 1

--END


DECLARE @counter AS INT = 1
DECLARE @employeeCount AS INT
DECLARE @name AS NVARCHAR(10)


SELECT @employeeCount = COUNT(*) FROM Employees

WHILE @counter <= @employeeCount
BEGIN

	IF EXISTS(SELECT * FROM Employees WHERE EmployeeID = @counter)
	BEGIN
		SELECT @name = FirstName
		FROM Employees
		WHERE EmployeeID = @counter


		IF @counter % 2 = 1
		BEGIN
			PRINT @name
		END
	END
	ELSE
	BEGIN
		PRINT ''
	END

	SET @counter += 1

END