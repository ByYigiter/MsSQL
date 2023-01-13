-- Stored Procedure

-- ad-hoc query

-- PARSE
-- RESOLVE
-- OPTIMIZE
-- COMPILE
	-- Execution Plan
-- EXECUTE
-- RESULT

------------------------------------------
CREATE PROC sp_GetProducts
AS
BEGIN
	SELECT * FROM Products
END

--EXECUTE sp_GetProducts
EXEC sp_GetProducts
--sp_GetProducts


ALTER PROC sp_GetProducts
AS
SET NOCOUNT ON
BEGIN
	SELECT * FROM Products
END


DROP PROC sp_GetProducts