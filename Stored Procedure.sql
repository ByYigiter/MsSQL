-- Şehir bilgisini parametre olarak alıp o şehirdeki müşterileir listeleyen sp
CREATE PROC sp_GetCustomersByCity
(
	@city AS NVARCHAR(50)
)
AS
BEGIN
	SELECT * FROM Customers WHERE City = @city
END

EXEC sp_GetCustomersByCity @city='London'
EXEC sp_GetCustomersByCity 'London'

--Employee tablosuna kayıt atan sp
CREATE PROC sp_AddEmployee
(
	@firstName AS NVARCHAR(10),
	@lastName AS NVARCHAR(20)
)
AS
BEGIN
	INSERT INTO Employees(FirstName,LastName)
	VALUES(@firstName,@lastName)
END

EXEC sp_AddEmployee 'Marty','McFly'
EXEC sp_AddEmployee @lastName='McFly',@firstName='Marty'

--Kategori adını parametre olarak alıp ona göre ürünleri getiren sp
ALTER PROC sp_GetProductsByCategory
(
	@catName AS NVARCHAR(15) = NULL
)
AS
BEGIN
	--IF @catName IS NULL
	--BEGIN
	--	SELECT p.ProductName, c.CategoryName
	--	FROM Products p
	--	JOIN Categories c ON p.CategoryID = c.CategoryID
	--END
	--ELSE
	--BEGIN
	--	SELECT p.ProductName, c.CategoryName
	--	FROM Products p
	--	JOIN Categories c ON p.CategoryID = c.CategoryID
	--	WHERE c.CategoryName = @catName
	--END

	SELECT p.ProductName, c.CategoryName
	FROM Products p
	JOIN Categories c ON p.CategoryID = c.CategoryID
	WHERE c.CategoryName = ISNULL(@catName,c.CategoryName)
END

EXEC sp_GetProductsByCategory 'Seafood'

--------------------------------------------------------------------
-- OUTPUT PARAMETER
-- Kategori adını parametre alıp hem o kategorinin ürünlerini hem de ürün sayısını dönen sp
CREATE PROC sp_Urunler
(
	@kategori AS NVARCHAR(15),
	@adet AS INT OUT
)
AS
BEGIN
	SELECT p.ProductName
	FROM Products p
	JOIN Categories c ON p.CategoryID = c.CategoryID
	WHERE c.CategoryName LIKE (@kategori + '%')

	SET @adet = @@ROWCOUNT
END

DECLARE @urunSayisi INT
--DECLARE @x AS NVARCHAR(15) = 'C'
EXEC sp_Urunler 'C', @urunSayisi OUT
PRINT  'Ürün Sayısı : ' + CAST(@urunSayisi AS NVARCHAR(5))


-- Dynamic SQL
EXEC('SELECT * FROM Products')

DECLARE @table AS NVARCHAR(50)
SET @table = 'Orders'

EXEC('SELECT * FROM ' + @table)

-- Kategori ID'sine göre ürünleri getiren sp
ALTER PROC sp_UrunleriGetir
(
	@kategoriID AS INT = NULL
)
AS
BEGIN
	DECLARE @query AS NVARCHAR(100)
	SET @query = 'SELECT * FROM Products'

	IF @kategoriID IS NOT NULL
	BEGIN
		SET @query += ' WHERE CategoryID = ' + CAST(@kategoriID AS NVARCHAR(2))
	END

	EXEC(@query)
END

EXEC sp_UrunleriGetir 3