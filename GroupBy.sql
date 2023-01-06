-- GROUP BY

SELECT CategoryID,
       COUNT(*) AS UrunSayisi
FROM Products
GROUP BY CategoryID

SELECT c.CategoryName,
       COUNT(p.ProductID) AS UrunSayisi
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName


SELECT Country AS Ulke,
       COUNT(CustomerID) AS MusteriSayisi
FROM Customers
GROUP BY Country
ORDER BY MusteriSayisi DESC


SELECT Country AS Ulke,
       City AS Sehir,
       COUNT(CustomerID) AS MusteriSayisi
FROM Customers
GROUP BY Country,
         City
ORDER BY MusteriSayisi DESC


-- Her sipariþten ne kadar kazanýlmýþtýr?
SELECT OrderID,
       SUM(UnitPrice * Quantity * (1 - Discount)) AS Kazanc
FROM [Order Details]
GROUP BY OrderID


SELECT c.CategoryName,
       MAX(p.UnitPrice) AS EnPahaliFiyat
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName


-- Her çalýþan kaç tanse sipariþle ilgilenmiþtir? CalisanTamAdi | SiparisSayisi
SELECT e.FirstName + ' ' + e.LastName AS CalisanTamAdi,
       COUNT(o.OrderID) AS SiparisSayisi
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
--GROUP BY e.FirstName, e.LastName
GROUP BY e.FirstName + ' ' + e.LastName


-- 10'dan fazla gecikme yaþanýlan kargo firmalarý?
SELECT s.CompanyName,
       COUNT(o.OrderID)
FROM Orders o
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE o.ShippedDate > o.RequiredDate -- AND COUNT(o.OrderID) > 10
GROUP BY s.CompanyName
HAVING COUNT(o.OrderID) > 10

-- Condiments kategorsindeki ürünlerden kaç kez sipariþ verilmiþtir?
SELECT c.CategoryName,
       COUNT(od.OrderID)
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE c.CategoryName = 'Condiments'
GROUP BY c.CategoryName
--HAVING c.CategoryName = 'Condiments'


-- 50'den fazla sipariþ alýnan ülkelere göre ciro nedir? Ulke | Ciro
SELECT o.ShipCountry AS Ulke,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Ciro
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
HAVING COUNT(DISTINCT o.OrderID) > 50