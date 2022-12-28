

select * from Customers where country like 'S_____'


select * from  Customers where CompanyName  like '__[^A-D]_%'


select * from Customers where Country ='Brazil' or Country ='USA';  --  aþðýdaký ile farký hýz farký vardýr bu daha yavaþtýr
select * from Customers where Country in('Brazil','USA','Spain');

select * from Products where ProductName like '% %' -- 1 den fazla kelime olanlar aradaký oþluk þeklinde sorgulanýr

select CompanyName,City as sehir from Customers where Country='USA' order by  sehir desc, CompanyName asc; -- order by en son caliþýr yani as iþlemini kabul etmeisi ondan
																								-- önde select where sonucularý alýnýr cýkan sonuýcu sýralama demek olur

		select CompanyName,City as sehir from Customers where Country='USA' order by  1 desc -- yazýlacak sutun sayýsý kaç ise yazdýðýn sýralamadan seçer sutunu

select top 1 *  from Customers  order by  NEWID() -- random seçim yapmak için kullanýlýr random sýralar

select top 1 FirstName, LastName from Employees order by HireDate desc
