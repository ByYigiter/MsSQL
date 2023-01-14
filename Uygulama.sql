--Ürün nosunu, zam mı indirim mi bilgisini ve oranı parametre alan ve buna göre ürün fiyatını güncelleyen sp
CREATE PROC sp_UrunFiyatGuncelle
(
	@urunNo AS INT,
	@oran AS FLOAT,
	@zamMi AS BIT
)
AS
BEGIN
	DECLARE @fiyat AS DECIMAL
	DECLARE @miktar AS DECIMAL

	SELECT @fiyat = UnitPrice FROM Products WHERE ProductID = @urunNo
	SET @miktar = @fiyat * @oran / 100

	IF @zamMi = 0 -- zamMi değeri false'a mı eşiy yani indirim mi
	BEGIN
		SET @miktar = @miktar * -1
	END

	UPDATE Products
	SET UnitPrice += @miktar
	WHERE ProductID = @urunNo
END

EXEC sp_UrunFiyatGuncelle 2,100,1
EXEC sp_UrunFiyatGuncelle 2,50,0

--Kargo firmasına ve bir fiyat aralığına göre o firmanın taşıdığı ve kargo ücreti verilen aralıkta olan siparişleri listeleyen sp
ALTER PROC sp_SiparisleriGetir
(
	@kargo AS NVARCHAR(40),
	@minFiyat AS DECIMAL,
	@maxFiyat AS DECIMAL
)
AS
BEGIN
	SELECT o.OrderID,
	       s.CompanyName,
		   o.Freight
	FROM Orders o
	JOIN Shippers s ON o.ShipVia = s.ShipperID
	WHERE s.CompanyName = @kargo AND
	      o.Freight BETWEEN @minFiyat AND @maxFiyat
END

EXEC sp_SiparisleriGetir @kargo='Speedy Express',@minFiyat=5,@maxFiyat=30


--Siparişleri listeleyn bir sp yazın. Ama istersem müşteriye göre, istersem çalışana göre istersem de her ikisine göre filtreleyebileyim.
ALTER PROC sp_GetOrders
(
	@customerID AS CHAR(5) = NULL,
	@employeeID AS INT = NULL
)
AS
BEGIN
	DECLARE @query AS NVARCHAR(200) = 'SELECT OrderID, CustomerID, EmployeeID FROM Orders'

	IF @customerID IS NOT NULL AND @employeeID IS NOT NULL
	BEGIN
		SET @query += ' WHERE CustomerID = ''' + @customerID + ''' AND EmployeeID = ' + CAST(@employeeID AS CHAR)
	END
	ELSE IF @customerID IS NOT NULL
	BEGIN
		SET @query += ' WHERE CustomerID = ''' + @customerID + ''''
	END
	ELSE IF @employeeID IS NOT NULL
	BEGIN
		SET @query += ' WHERE EmployeeID = ' + CAST(@employeeID AS CHAR)
	END

	PRINT @query
	EXEC(@query)
END

EXEC sp_GetOrders
EXEC sp_GetOrders @customerID='ALFKI'
EXEC sp_GetOrders @employeeID=3
EXEC sp_GetOrders @customerID='ALFKI', @employeeID=3

--Parametre olarak bölge bilgisi alan ve o bölgeden sorumlu çalışanların ilgilendiği sipariş sayısını geri dönen bir sp.
CREATE PROC sp_GetOrdersByEmployee
(
	@region AS NCHAR(50),
	@orderCount AS INT OUT
)
AS
BEGIN
	SELECT @orderCount = COUNT(OrderID)
	FROM Orders
	WHERE EmployeeID IN(SELECT DISTINCT e.EmployeeID
					   FROM Employees e
					   JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
					   JOIN Territories t ON et.TerritoryID = t.TerritoryID
					   JOIN Region r ON t.RegionID = r.RegionID
					   WHERE r.RegionDescription = @region)

	--SELECT @orderCount = COUNT(o.OrderID)
	--FROM Employees e
	--JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
	--JOIN Territories t ON et.TerritoryID = t.TerritoryID
	--JOIN Region r ON t.RegionID = r.RegionID
	--JOIN Orders o ON e.EmployeeID = o.EmployeeID
	--WHERE r.RegionDescription = @region
	--GROUP BY r.RegionDescription
END

DECLARE @ordersCount AS INT
EXEC sp_GetOrdersByEmployee 'Western', @ordersCount OUTPUT
PRINT @ordersCount

--Ürün adı ve kategori adı şeklinde iki parametre alan, kategori varsa ürünü o kategori altına ekleyecek ama kategori yoksa önce kategoriyi sonra da ürünü o kategori altına ekleyecek sp
CREATE PROC sp_AddProductCategory
(
	@product AS NVARCHAR(40),
	@category AS NVARCHAR(15)
)
AS
BEGIN
	DECLARE @categoryID AS INT
	SELECT @categoryID = CategoryID FROM Categories WHERE CategoryName=@category

	IF @categoryID IS NULL
	BEGIN
		INSERT INTO Categories(CategoryName)
		VALUES(@category)

		SET @categoryID = SCOPE_IDENTITY()
	END

	INSERT INTO Products(ProductName,CategoryID)
	VALUES(@product,@categoryID)

END

EXEC sp_AddProductCategory 'Masa','Mobilya'
EXEC sp_AddProductCategory 'Sandalye','Mobilya'