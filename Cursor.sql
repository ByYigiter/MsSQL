-- CURSOR

DECLARE @name AS NVARCHAR(40)
DECLARE @price AS DECIMAL

DECLARE ProductCursor CURSOR FOR
	SELECT ProductName, UnitPrice FROM Products

OPEN ProductCursor

FETCH NEXT FROM ProductCursor INTO @name, @price

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @price > 50
	BEGIN
		PRINT @name + ' isimli ürün pahalýdýr'
	END
	ELSE
	BEGIN
		PRINT @name + ' isimli ürün ucuzdur'
	END

	FETCH NEXT FROM ProductCursor INTO @name, @price
END

CLOSE ProductCursor

DEALLOCATE ProductCursor