-- yorum sat�r�  
--sdf
-- SQL ==> Structured Query Language	3 e ayr�l�r
		-- DDL=> Data definition Language
		--DML==> Data Manipulation Language
		--DCL==>Data Control Language

select 'codd' as 'boot name'
select 'codd' as bootname
select 'codd' [bootname]
select orderid from orders
select 10+20
select 'Akin ' +' '+ 'Karabulut'
print 'hello World'
select CategoryName,Description from Categories
select * from Categories

-- �alisanlara mektup yazaca��m say�n ad soyad hitap edecek �ekilde ba�las�n
select 'Say�n ' +firstName + ' '+lastname as hitap from Employees;

-- where 
select * from Products where UnitPrice=30;

select * from Products where UnitPrice !=30;
select * from Products where UnitPrice <>30;

select * from Products where UnitPrice <=30;

--------------
select * from Orders where OrderDate <'1997-01-01' and ShipCity='lyon';
select * from Orders where OrderDate <'1997-01-01' or ShipCity='lyon';


