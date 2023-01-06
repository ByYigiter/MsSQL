-- 'Romero y Tomillo' adl� m��teriye g�nderilen �r�nler?
SELECT ProductName
FROM Products
WHERE ProductID IN(SELECT ProductID
                   FROM [Order Details]
				   WHERE OrderID IN(SELECT OrderID
				                    FROM Orders
									WHERE CustomerID = (SELECT CustomerID
														FROM Customers
														WHERE CompanyName='Romero y Tomillo'
									                    )
									)
				   )

-- Hangi �lkelere hangi sipari�ler en ge� teslim edilmi�tir?
SELECT ShipCountry,
       OrderID
FROM Orders o
WHERE DATEDIFF(DAY,RequiredDate,ShippedDate) = (SELECT MAX(DATEDIFF(DAY,RequiredDate,ShippedDate))
												FROM Orders
												WHERE RequiredDate < ShippedDate --AND ShipCountry = o.ShipCountry
												GROUP BY ShipCountry
												HAVING ShipCountry = o.ShipCountry
												)



-- Her y�l�n en �ok sipari� veren m��terisi kimdir?
SELECT *
FROM (SELECT YEAR(o.OrderDate) AS Yil,
			 c.CompanyName AS Musteri,
			 COUNT(o.OrderID) AS SiparisSayisi
	  FROM Customers c
	  JOIN Orders o ON c.CustomerID = o.CustomerID
	  GROUP BY YEAR(o.OrderDate),
			    c.CompanyName
     ) AS MusteriSiparisMain
WHERE SiparisSayisi = (SELECT MAX(SiparisSayisi)
                       FROM (SELECT YEAR(o.OrderDate) AS Yil,
									c.CompanyName AS Musteri,
									COUNT(o.OrderID) AS SiparisSayisi
							  FROM Customers c
							  JOIN Orders o ON c.CustomerID = o.CustomerID
							  GROUP BY YEAR(o.OrderDate),
											c.CompanyName
							  ) MusteriSiparisSub
						WHERE Yil = MusteriSiparisMain.Yil
					   )

-- Hangi kargo firmas� en �ok hangi �r�n� ta��m��t�r?
-- �al��anlar yapt�klar� en y�ksek tutarl� sipari�i hangi tarihte yapm��t�r?