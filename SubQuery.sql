-- SUBQUERY

-- SELECT CLAUSE (Correlated Subquery)
-- WHERE CLAUSE (Basic Subquery)
-- FROM CLAUSE


-- SELECT CLAUSE (Correlated Subquery)
-- 1997 y�l�nda sipari� veren m��teriler. SiparisNo | MusteriAdi
SELECT OrderID,
       (SELECT CompanyName
	    FROM Customers
		WHERE CustomerID = o.CustomerID
	    )
FROM Orders o
WHERE YEAR(OrderDate) = 1997

SELECT OrderID,
       (SELECT CompanyName
	    FROM Customers
		WHERE CustomerID = o.CustomerID
	    ) AS Musteri,
		(SELECT FirstName + ' ' + LastName
		 FROM Employees
		 WHERE EmployeeID = o.EmployeeID
		) AS Calisan
FROM Orders o
WHERE YEAR(OrderDate) = 1997


SELECT c.CompanyName,
       (SELECT MIN(OrderID)
	    FROM Orders
	    WHERE CustomerID = c.CustomerID)
FROM Customers c



-- WHERE CLAUSE (Basic Subquery)
-- Ortalam �r�n fiyat�ndan daha y�ksek fiyatl� fiyat
SELECT *
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- Janet adl� �al��an�n bulundu�u �ehirde bulunan m��teriler
SELECT *
FROM Customers
WHERE City = (SELECT City
              FROM Employees
			  WHERE FirstName = 'Janet')

SELECT *
FROM Employees
WHERE FirstName = 'Janet' AND City IN(SELECT City
                                      FROM Customers)


-- FROM CLAUSE
-- �lk kaydedilen 10 �r�n i�erisinde kritik stok seviyesi 0 olanlar
SELECT TOP 10 *
FROM Products
WHERE ReorderLevel = 0


SELECT UrunAdi
FROM (SELECT TOP 10 ProductName AS UrunAdi,
                    ReorderLevel AS KritikSeviye
      FROM Products) AS Ilk10Urun
WHERE KritikSeviye = 0