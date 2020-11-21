-- Ćwiczenie 1.

-- 1) Wybierz nazwy i numery telefonów klientów , którym w 1997 roku
-- przesyłki dostarczała firma United Package.

select distinct CompanyName, Phone 
from Customers c
	where exists (select * 
	from Orders o where o.CustomerID = c.CustomerID
	and ShipVia = (select ShipperID 
	from Shippers s where s.ShipperID = o.ShipVia 
	and CompanyName = 'United Package' and YEAR(o.ShippedDate) = 1997))

-- albo
select distinct CompanyName, Phone 
from Customers c
	where c.CustomerID in (select CustomerID 
	from Orders o where o.CustomerID = c.CustomerID
	and ShipVia = (select ShipperID 
	from Shippers s where s.ShipperID = o.ShipVia 
	and CompanyName = 'United Package' and YEAR(o.ShippedDate) = 1997))


-- 2) Wybierz nazwy i numery telefonów klientów, którzy kupowali
-- produkty z kategorii Confections.

-- exists
select distinct CompanyName, Phone 
from Customers c
	where exists (select * from Orders o 
	where o.CustomerID = c.CustomerID and
	exists (select * from [Order Details] od
	where od.OrderID = o.OrderID and 
	exists (select * from Products p
	where p.ProductID = od.ProductID and 
	exists (select * from Categories cat
	where cat.CategoryID = p.CategoryID and CategoryName = 'Confections'))))
-- order by CompanyName


-- in
select distinct CompanyName, Phone 
from Customers c
	where CustomerID in (select CustomerID from Orders o 
	where o.CustomerID = c.CustomerID and
	OrderID in (select OrderID from [Order Details] od
	where od.OrderID = o.OrderID and 
	ProductID in (select ProductID from Products p
	where p.ProductID = od.ProductID and 
	CategoryID in (select CategoryID from Categories cat
	where cat.CategoryID = p.CategoryID and CategoryName = 'Confections'))))


-- 3) Wybierz nazwy i numery telefonów klientów, którzy nie kupowali
-- produktów z kategorii Confections

select distinct CompanyName, Phone 
from Customers c
	where not exists (select * from Orders o 
	where o.CustomerID = c.CustomerID and
	exists (select * from [Order Details] od
	where od.OrderID = o.OrderID and 
	exists (select * from Products p
	where p.ProductID = od.ProductID and 
	exists (select * from Categories cat
	where cat.CategoryID = p.CategoryID and CategoryName = 'Confections'))))



-- Ćwiczenie 2.

-- 1) Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek
select distinct productid, quantity
from [Order Details] od1
	where quantity = (select max(quantity)
	from [Order Details] od2 
	where od1.ProductID = od2.ProductID)
order by productid

-- bez podzapytania
select ProductID, max(quantity) as 'max qty'
from [Order Details]
group by ProductID
order by ProductID


-- 2) Podaj wszystkie produkty których cena jest mniejsza niż średnia
-- cena produktu

select ProductID, ProductName
from Products
	where UnitPrice < (select avg(unitprice) from Products)

-- 3) Podaj wszystkie produkty których cena jest mniejsza niż średnia
-- cena produktu danej kategorii

select ProductID, ProductName, unitprice, CategoryID
from Products p1
	where UnitPrice < (select avg(unitprice) from Products p2
	where p2.CategoryID = p1.CategoryID)
		
		
-- Ćwiczenie 3. 

-- 1) Dla każdego produktu podaj jego nazwę, cenę, średnią cenę
-- wszystkich produktów oraz różnicę między ceną produktu a
-- średnią ceną wszystkich produktów
select ProductName, UnitPrice, (select avg(UnitPrice) from  Products) as avgPrice,
	UnitPrice - (select avg(UnitPrice) from  Products p2) as diff
from Products


-- 2) Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu,
-- cenę, średnią cenę wszystkich produktów danej kategorii oraz
-- różnicę między ceną produktu a średnią ceną wszystkich
-- produktów danej kategorii
select ProductName, UnitPrice, 
	(select CategoryName from Categories c where c.CategoryID = p2.CategoryID) as 'CategoryName',
	(select avg(UnitPrice) from Products p1 where p1.CategoryID = p2.CategoryID) as 'AvgCatPrice',
 	(UnitPrice - (select avg(UnitPrice) from Products p1 where p1.CategoryID = p2.CategoryID)) as 'Diff'
from Products p2



-- Ćwiczenie 4.

-- 1) Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij
-- cenę za przesyłkę)

select round(((select sum(UnitPrice*Quantity*(1-Discount)) from [Order Details] od
	where od.OrderID = o.OrderID) + Freight), 2) as 'value'
from Orders o
where OrderID = 10250


-- 2)  Podaj łączną wartość zamówień każdego zamówienia (uwzględnij
-- cenę za przesyłkę)
select OrderID, round(((select sum(UnitPrice*Quantity*(1-Discount)) from [Order Details] od
	where od.OrderID = o.OrderID) + Freight), 2) as 'value'
from Orders o


-- 3) Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997
-- roku, jeśli tak to pokaż ich dane adresowe

-- join
select c.CompanyName,  Address + ' ' + City as address
from customers c
left outer join orders o
on o.CustomerID = c.CustomerID and YEAR(orderdate) = 1997
where orderdate is null

-- podzapytanie
select CompanyName, Address + ' ' + City as address
from customers c
where not exists (select * from Orders o where o.CustomerID = c.CustomerID and YEAR(orderdate) = 1997)
