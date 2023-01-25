-- Atomicity
-- Consistency
-- Isolation
-- Durability



-- AutoCommit
-- Implicit

SET IMPLICIT_TRANSACTIONS ON
-- komutlar
-- sorgular
SET IMPLICIT_TRANSACTIONS OFF

-- Explicit

BEGIN TRANSACTION

DECLARE @ordersCount AS INT = (SELECT COUNT(*) FROM Orders)
DECLARE @newOrdersCount AS INT

INSERT INTO Orders(OrderDate,RequiredDate)
VALUES(GETDATE(),DATEADD(WEEK,2,GETDATE()))

SELECT @newOrdersCount = COUNT(*) FROM Orders

IF @ordersCount = @newOrdersCount
BEGIN
	ROLLBACK TRANSACTION
END
ELSE
BEGIN
	DECLARE @currentOrderID AS INT = SCOPE_IDENTITY()

	INSERT INTO [Order Details](OrderID,ProductID)
	VALUES(@currentOrderID, 1)

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END
END


-- READ UNCOMMITTED
-- READ COMMITTED (default)
-- REPEATABLE READ
-- SERIALIZABLE
-- SNAPSHOT


SET TRANSACTION ISOLATION LEVEL SERIALIZABLE


SELECT * FROM Categories WITH(NOLOCK)