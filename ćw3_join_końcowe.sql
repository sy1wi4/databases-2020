-- Æwiczenie 1

-- 1. Dla każdego zamówienia podaj ³¹czn¹ liczbê zamówionych jednostek
-- oraz nazwê klienta.

use Northwind
select o.OrderID, sum(od.Quantity) as 'qty', c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.orderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName


-- 2. Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia,
-- dla których ³¹czna liczbê zamówionych jednostek jest wiêksza ni¿ 250.

select o.OrderID, sum(od.Quantity) as 'qty', c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.orderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName
having sum(od.Quantity) > 250


-- 3. Dla ka¿dego zamówienia podaj ³¹czn¹ wartoœæ tego zamówienia oraz
-- nazwê klienta.
select o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as 'value', c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName


-- 4. Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia,
-- dla których ³¹czna liczba jednostek jest wiêksza ni¿ 250.

select o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as value, c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName
having sum(Quantity) > 250


-- 5. Zmodyfikuj poprzedni przyk³ad tak ¿eby dodaæ jeszcze imiê i
-- nazwisko pracownika obs³uguj¹cego zamówienie

select o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as value, 
       c.CompanyName, e.FirstName +' '+ e.LastName as 'employee name'
from Orders o
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
inner join Employees e
on e.EmployeeID = o.EmployeeID
group by o.OrderID, c.CompanyName, e.FirstName +' '+ e.LastName
having sum(Quantity) > 250



-- Æwiczenie 2

-- 1. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ liczbê
-- zamówionych przez klientów jednostek towarów.

-- przez wszystkich klientów? to tak:
use Northwind 
select c.CategoryName, sum(od.Quantity) as 'qty' 
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName

-- czy dla ka¿dego klienta osobno? wtedy tak:
select c.CategoryName, o.CustomerID, sum(od.Quantity) as 'qty' 
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
inner join Orders o 
on o.OrderID = od.OrderID
group by c.CategoryName, o.CustomerID


-- 2. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ wartoœæ
-- zamówieñ

select c.CategoryName, round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName


-- 3. Posortuj wyniki w zapytaniu z punktu 2 wg:

-- a. ³¹cznej wartoœci zamówieñ
select c.CategoryName, round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName
order by value 

-- b. ³¹cznej liczby zamówionych przez klientów jednostek towarów
select c.CategoryName, round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value',
       sum(quantity) as 'qty'
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName
order by sum(quantity)



-- Æwiczenie 3

-- 1. Dla ka¿dego przewoŸnika (nazwa) podaj liczbê zamówieñ, które
-- przewieŸli w 1997r

select s.CompanyName, count(*) as 'orders'
from Shippers s
inner join Orders o
on o.ShipVia = s.ShipperID
where YEAR(shippedDate) = '1997'
group by s.CompanyName


-- 2. Który z przewoŸników by³ najaktywniejszy (przewióz³ najwiêksz¹
-- liczbê zamówieñ) w 1997r, podaj nazwê tego przewoŸnika
select top 1 s.CompanyName, count(*) as 'orders'
from Shippers s
inner join Orders o
on o.ShipVia = s.ShipperID
where YEAR(shippedDate) = '1997'
group by s.CompanyName
order by count(*) desc


-- 3. Który z pracowników obs³u¿y³ najwiêksz¹ liczbê zamówieñ w 1997r,
-- podaj imiê i nazwisko takiego pracownika

select top 1 e.FirstName, e.LastName, count(*) as orders
from Orders o 
inner join Employees e
on e.EmployeeID = o.EmployeeID
where YEAR(shippedDate) = '1997'
group by e.EmployeeID, e.FirstName, e.LastName
order by count(*) desc



-- Æwiczenie 4

-- 1. Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ
-- zamówieñ obs³u¿onych przez tego pracownika

select e.FirstName, e.LastName, 
       round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Employees e
inner join Orders o
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by e.EmployeeID, e.FirstName, e.LastName


-- 2. Który z pracowników obs³u¿y³ (by³?) najaktywniejszy (obs³u¿y³ zamówienia
-- o najwiêkszej wartoœci) w 1997r, podaj imiê i nazwisko takiego
--  pracownika

select top 1 e.FirstName, e.LastName, 
	   round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Orders o 
inner join Employees e
on e.EmployeeID = o.EmployeeID
inner join [Order Details] od 
on od.OrderID = o.OrderID
where YEAR(shippedDate) = '1997'
group by e.EmployeeID, e.FirstName, e.LastName
order by 3 desc


-- 3. Ogranicz wynik z pkt 1 tylko do pracowników:

--a. którzy maj¹ podw³adnych

select e1.FirstName, e1.LastName, 
       round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Employees e1
inner join Employees e2   -- podw³adny
on e1.EmployeeID = e2.ReportsTo
inner join Orders o
on o.EmployeeID = e1.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by e1.EmployeeID, e1.FirstName, e1.LastName

/*
pracownicy maj¹cy podw³adnych (self join):

select a.FirstName+' '+a.LastName as 'head', b.FirstName+' '+b.LastName as 'emp' 
from Employees a
inner join Employees b
on a.EmployeeID = b.ReportsTo
*/

-- b. którzy nie maj¹ podw³adnych

select e1.FirstName, e1.LastName, 
       round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Employees e1
left outer join Employees e2   -- podw³adny
on e1.EmployeeID = e2.ReportsTo
inner join Orders o
on o.EmployeeID = e1.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where e2.ReportsTo is null
group by e1.EmployeeID, e1.FirstName, e1.LastName

/*
pracownicy nie maj¹cy podw³adnych (self join):

select a.FirstName+' '+a.LastName as 'emp'
from Employees a
left outer join Employees b
on a.EmployeeID = b.ReportsTo
where b.ReportsTo is null
*/
