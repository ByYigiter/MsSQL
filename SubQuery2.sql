-- Amerika'da yaþayan çalýþanlarýn ilgilendið sipariþler
SELECT *
FROM Orders
WHERE EmployeeID IN(SELECT EmployeeID
                    FROM Employees
					WHERE Country = 'USA')

-- Sipariþlerin nosu, ilgilenen çalýþan ve sipariþ tutarý
SELECT o.OrderID,
       (SELECT FirstName
	    FROM Employees
		WHERE EmployeeID = o.EmployeeID),
	   (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
	    FROM [Order Details]
		WHERE OrderID = o.OrderID)
FROM Orders o


SELECT od.OrderID,
       SUM(UnitPrice * Quantity * (1 - Discount)),
	   (SELECT FirstName + ' ' + LastName
	    FROM Employees
		WHERE EmployeeID IN(SELECT EmployeeID
		                    FROM Orders
							WHERE OrderID = od.OrderID)
	   )
FROM [Order Details] od
GROUP BY od.OrderID

-- Brezilya ülkesindeki müþterilerden gelen sipariþler içerisinde en yüksek tutarlý sipariþin tutarý?
SELECT MAX(UnitPrice * Quantity * (1 - Discount))
FROM [Order Details]
WHERE OrderID IN(SELECT OrderID
                 FROM Orders
				 WHERE CustomerID IN(SELECT CustomerID
				                     FROM Customers
									 WHERE Country = 'Brazil')
				)