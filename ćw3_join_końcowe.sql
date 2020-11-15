-- �wiczenie 1

-- 1. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek
-- oraz nazw� klienta.

use Northwind
select o.OrderID, sum(od.Quantity) as 'qty', c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.orderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName


-- 2. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
-- dla kt�rych ��czna liczb� zam�wionych jednostek jest wi�ksza ni� 250.

select o.OrderID, sum(od.Quantity) as 'qty', c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.orderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName
having sum(od.Quantity) > 250


-- 3. Dla ka�dego zam�wienia podaj ��czn� warto�� tego zam�wienia oraz
-- nazw� klienta.
select o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as 'value', c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName


-- 4. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
-- dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250.

select o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as value, c.CompanyName
from Orders o
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName
having sum(Quantity) > 250


-- 5. Zmodyfikuj poprzedni przyk�ad tak �eby doda� jeszcze imi� i
-- nazwisko pracownika obs�uguj�cego zam�wienie

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



-- �wiczenie 2

-- 1. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb�
-- zam�wionych przez klient�w jednostek towar�w.

-- przez wszystkich klient�w? to tak:
use Northwind 
select c.CategoryName, sum(od.Quantity) as 'qty' 
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName

-- czy dla ka�dego klienta osobno? wtedy tak:
select c.CategoryName, o.CustomerID, sum(od.Quantity) as 'qty' 
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
inner join Orders o 
on o.OrderID = od.OrderID
group by c.CategoryName, o.CustomerID


-- 2. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� warto��
-- zam�wie�

select c.CategoryName, round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName


-- 3. Posortuj wyniki w zapytaniu z punktu 2 wg:

-- a. ��cznej warto�ci zam�wie�
select c.CategoryName, round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName
order by value 

-- b. ��cznej liczby zam�wionych przez klient�w jednostek towar�w
select c.CategoryName, round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value',
       sum(quantity) as 'qty'
from Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName
order by sum(quantity)



-- �wiczenie 3

-- 1. Dla ka�dego przewo�nika (nazwa) podaj liczb� zam�wie�, kt�re
-- przewie�li w 1997r

select s.CompanyName, count(*) as 'orders'
from Shippers s
inner join Orders o
on o.ShipVia = s.ShipperID
where YEAR(shippedDate) = '1997'
group by s.CompanyName


-- 2. Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz�
-- liczb� zam�wie�) w 1997r, podaj nazw� tego przewo�nika
select top 1 s.CompanyName, count(*) as 'orders'
from Shippers s
inner join Orders o
on o.ShipVia = s.ShipperID
where YEAR(shippedDate) = '1997'
group by s.CompanyName
order by count(*) desc


-- 3. Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1997r,
-- podaj imi� i nazwisko takiego pracownika

select top 1 e.FirstName, e.LastName, count(*) as orders
from Orders o 
inner join Employees e
on e.EmployeeID = o.EmployeeID
where YEAR(shippedDate) = '1997'
group by e.EmployeeID, e.FirstName, e.LastName
order by count(*) desc



-- �wiczenie 4

-- 1. Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto��
-- zam�wie� obs�u�onych przez tego pracownika

select e.FirstName, e.LastName, 
       round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Employees e
inner join Orders o
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by e.EmployeeID, e.FirstName, e.LastName


-- 2. Kt�ry z pracownik�w obs�u�y� (by�?) najaktywniejszy (obs�u�y� zam�wienia
-- o najwi�kszej warto�ci) w 1997r, podaj imi� i nazwisko takiego
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


-- 3. Ogranicz wynik z pkt 1 tylko do pracownik�w:

--a. kt�rzy maj� podw�adnych

select e1.FirstName, e1.LastName, 
       round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Employees e1
inner join Employees e2   -- podw�adny
on e1.EmployeeID = e2.ReportsTo
inner join Orders o
on o.EmployeeID = e1.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by e1.EmployeeID, e1.FirstName, e1.LastName

/*
pracownicy maj�cy podw�adnych (self join):

select a.FirstName+' '+a.LastName as 'head', b.FirstName+' '+b.LastName as 'emp' 
from Employees a
inner join Employees b
on a.EmployeeID = b.ReportsTo
*/

-- b. kt�rzy nie maj� podw�adnych

select e1.FirstName, e1.LastName, 
       round(sum(od.quantity*od.unitprice*(1-od.discount)), 2) as 'value'
from Employees e1
left outer join Employees e2   -- podw�adny
on e1.EmployeeID = e2.ReportsTo
inner join Orders o
on o.EmployeeID = e1.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where e2.ReportsTo is null
group by e1.EmployeeID, e1.FirstName, e1.LastName

/*
pracownicy nie maj�cy podw�adnych (self join):

select a.FirstName+' '+a.LastName as 'emp'
from Employees a
left outer join Employees b
on a.EmployeeID = b.ReportsTo
where b.ReportsTo is null
*/
