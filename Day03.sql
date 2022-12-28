select * from Categories

-- where 
select * from Products where UnitPrice=30;

select * from Products where UnitPrice !=30;
select * from Products where UnitPrice <>30;

select * from Products where UnitPrice <=30;

--------------
select * from Orders where OrderDate <'1997-01-01' and ShipCity='lyon';
select * from Orders where OrderDate <'1997-01-01' or ShipCity='lyon';