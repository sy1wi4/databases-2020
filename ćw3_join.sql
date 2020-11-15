
-- iloczyn kartezjañski - ka¿dy wiersz z 1 tabeli z ka¿dym wierszem z 2

SELECT b.buyer_name AS [b.buyer_name],
b.buyer_id AS [b.buyer_id],
s.buyer_id AS [s.buyer_id],
qty AS [s.qty]
FROM buyers AS b, sales AS s
WHERE b.buyer_name = 'Adam Barr' and s.buyer_id = b.buyer_id


SELECT buyer_name, b.buyer_id, qty
FROM buyers AS b, sales AS s
WHERE s.buyer_id = b.buyer_id


-- INNER JOIN - z³¹czenie wewnêtrzne

USE joindb
SELECT buyer_name, s.buyer_id, qty
FROM buyers b 
INNER JOIN sales s
ON b.buyer_id = s.buyer_id

-- Napisz polecenie zwracaj¹ce nazwy produktów i firmy je dostarczaj¹ce
-- tak aby produkty bez „dostarczycieli” i „dostarczyciele” bez
-- produktów nie pojawiali siê w wyniku.
use Northwind
select p.ProductName, s.CompanyName 
from suppliers s
inner join products p
on s.SupplierID = p.SupplierID

-- Napisz polecenie zwracaj¹ce jako wynik nazwy klientów,
-- którzy z³o¿yli zamówienia po 1 marca 1998
select distinct c.companyname, o.orderdate
from orders o 
inner join customers c
on o.customerid = c.customerid and  orderdate > '1998-03-01 00:00:00.000'


-- OUTER JOIN - z³¹czenie zewnêtrzne

USE joindb
SELECT buyer_name, sales.buyer_id, qty
FROM buyers LEFT OUTER JOIN sales
ON buyers.buyer_id = sales.buyer_id


-- Napisz polecenie zwracaj¹ce wszystkich klientów z datami zamówieñ.
use Northwind
select c.companyname, c.customerid, o.orderdate
from customers c 
left outer join orders o
on o.customerid = c.customerid


-- Napisz polecenie, które wyœwietla listê dzieci bêd¹cych
-- cz³onkami biblioteki. Interesuje nas imiê, nazwisko i data
-- urodzenia dziecka.
use library 

select firstname, m.lastname, j.birth_date
from juvenile j
inner join member m
on j.member_no = m.member_no


-- Napisz polecenie, które podaje tytu³y aktualnie wypo¿yczonych ksi¹¿ek
select distinct title
from loan l
inner join title t
on l.title_no = t.title_no


-- Podaj informacje o karach zap³aconych za przetrzymywanie
-- ksi¹¿ki o tytule ‘Tao Teh King’. Interesuje nas data oddania
-- ksi¹¿ki, ile dni by³a przetrzymywana i jak¹ zap³acono karê
select in_date, due_date, datediff(dd, due_date, in_date) as 'days', fine_assessed
from loanhist l 
inner join title t
on l.title_no = t.title_no and title = 'Tao Teh King' and in_date > due_date


-- Napisz polecenie które podaje listê ksi¹¿ek (numery ISBN)
-- zarezerwowanych przez osobê o nazwisku: Stephen A.Graff
select isbn
from member m
inner join reservation r
on m.member_no = r.member_no
where m.firstname = 'Stephen' and m.lastname = 'Graff' and m.middleinitial = 'A'


-- Wybierz nazwy i ceny produktów o cenie jednostkowej
-- pomiêdzy 20 a 30, dla ka¿dego produktu podaj dane
-- adresowe dostawcy
use Northwind

select p.productname, p.unitprice, s.address
from products p 
inner join suppliers s 
on p.SupplierID = s.SupplierID
where UnitPrice between 20 and 30


-- Wybierz nazwy produktów oraz informacje o stanie
-- magazynu dla produktów dostarczanych przez firmê ‘Tokyo Traders’
select p.ProductName, p.UnitsInStock
from suppliers s
inner join products p
on p.SupplierID = s.SupplierID
where s.CompanyName = 'Tokyo Traders'


-- Czy s¹ jacyœ klienci którzy nie z³o¿yli ¿adnego zamówienia
-- w 1997 roku, jeœli tak to poka¿ ich dane adresowe

-- !!!
-- czyli wybieramy tych klientów, którzy zamówili coœ w 1997 oraz takich, 
-- dla których nie ma odpowiednika w prawej tabeli - czyli nie zamówiono wtedy nic 
-- (LEFT OUTER JOIN) i bierzemy te, których orderdate = null, dziêki czemu nie pojawi¹ 
-- siê te, dla których coœ wtedy zamówiono

select c.CompanyName, orderdate,orderid,  Address + ' ' + City as address
from customers c
left outer join orders o
on o.CustomerID = c.CustomerID and YEAR(orderdate) = 1997
where orderdate is null


-- Wybierz nazwy i numery telefonów dostawców,
-- dostarczaj¹cych produkty, których aktualnie nie ma w magazynie
select CompanyName, Phone
from suppliers s
inner join products p
on s.SupplierID = p.SupplierID
where UnitsInStock = 0



-- CROSS JOIN - iloczyn kartezjañski

USE joindb
SELECT buyer_name, qty
FROM buyers
CROSS JOIN sales


-- Napisz polecenie, wyœwietlaj¹ce CROSS JOIN miêdzy
-- shippers i suppliers. U¿yteczne dla listowania wszystkich
-- mo¿liwych sposobów w jaki dostawcy mog¹ dostarczaæ swoje produkty
use Northwind
select shippers.CompanyName as [shippers.CompanyName], suppliers.CompanyName as [suppliers.CompanyName]
from shippers
cross join suppliers



-- £¹czenie wiêcej ni¿ dwóch tabel
use joindb

SELECT buyer_name, prod_name, qty
FROM buyers
INNER JOIN sales
ON buyers.buyer_id = sales.buyer_id
INNER JOIN produce
ON sales.prod_id = produce.prod_id


-- Napisz polecenie zwracaj¹ce listê produktów zamawianych
-- w dniu 1996-07-08.
use Northwind
select od.ProductID, p.ProductName
from orders o
inner join [Order Details] od
on od.OrderID = o.OrderID and o.OrderDate = '1996-07-08'
inner join products p 
on p.ProductID = od.ProductID


-- Wybierz nazwy i ceny produktów (baza northwind) o cenie
-- jednostkowej pomiêdzy 20 a 30, dla ka¿dego produktu
-- podaj dane adresowe dostawcy, interesuj¹ nas tylko
-- produkty z kategorii ‘Meat/Poultry
use Northwind
select ProductName, UnitPrice, Address
from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID and UnitPrice between 20 and 30 
inner join Categories c
on c.CategoryID = p.CategoryID
where CategoryName = 'Meat/Poultry'


-- Wybierz nazwy i ceny produktów z kategorii ‘Confections’
-- dla ka¿dego produktu podaj nazwê dostawcy

select ProductName, UnitPrice, s.CompanyName 
from Categories c
inner join Products p
on c.CategoryID = p.CategoryID
inner join Suppliers s
on s.SupplierID = p.SupplierID
where CategoryName = 'Confections'


-- Wybierz nazwy i numery telefonów klientów , którym w
-- 1997 roku przesy³ki dostarcza³a firma ‘United Package’
select distinct c.CompanyName,  c.Phone 
from shippers s
inner join orders o
on s.ShipperID = o.ShipVia
inner join Customers c
on o.CustomerID = c.CustomerID
where s.CompanyName = 'United Package' and YEAR(o.ShippedDate) = 1997


-- Wybierz nazwy i numery telefonów klientów, którzy
-- kupowali produkty z kategorii ‘Confections’

select distinct c.CompanyName, c.Phone
from customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join [Order Details] od on od.OrderID = o.OrderID
inner join Products p on p.ProductID = od.ProductID
inner join Categories cat on cat.CategoryID = p.CategoryID
where cat.CategoryName = 'Confections'


-- Napisz polecenie, które wyœwietla listê dzieci bêd¹cych
-- cz³onkami biblioteki. Interesuje nas imiê, nazwisko, data
-- urodzenia dziecka i adres zamieszkania dziecka.
use library
select m.firstname, m.lastname, j.birth_date, street+' '+city+' '+state as address
from juvenile j
inner join member m 
on m.member_no = j.member_no
inner join adult a 
on j.adult_member_no = a.member_no


-- Napisz polecenie, które wyœwietla listê dzieci bêd¹cych
-- cz³onkami biblioteki. Interesuje nas imiê, nazwisko, data
-- urodzenia dziecka, adres zamieszkania dziecka oraz imiê i
-- nazwisko rodzica. 
select jm.firstname as 'j firstname', jm.lastname as 'j lastname', 
       j.birth_date, street+' '+city+' '+state as address, 
	   am.firstname as 'a firstname', am.lastname as 'a lastname'
from juvenile j
inner join member jm 
on jm.member_no = j.member_no
inner join adult a 
on j.adult_member_no = a.member_no
inner join member am
on am.member_no = a.member_no



-- £¹czenie tabeli samej ze sob¹ - self join


-- Napisz polecenie, które wyœwietla listê wszystkich
-- kupuj¹cych te same produkty (bez duplikatów).
USE joindb
select a.buyer_id as 'buyer 1', b.buyer_id as 'buyer 2', a.prod_id
from sales a
inner join sales b
on a.prod_id = b.prod_id
where a.buyer_id < b.buyer_id    -- !!! zapewnia unikalnoœæ


-- Napisz polecenie, które pokazuje pary pracowników
-- zajmuj¹cych to samo stanowisko.
use Northwind
select a.FirstName+' '+a.LastName as 'emp 1', b.FirstName+' '+b.LastName as 'emp 2'
from Employees a
inner join Employees b
on a.Title = b.Title
where a.EmployeeID < b.EmployeeID


-- Napisz polecenie, które wyœwietla pracowników oraz ich podw³adnych.
select a.FirstName+' '+a.LastName as 'head', b.FirstName+' '+b.LastName as 'emp' 
from Employees a
inner join Employees b
on a.EmployeeID = b.ReportsTo


-- Napisz polecenie, które wyœwietla pracowników, którzy nie maj¹ podw³adnych.
select a.FirstName+' '+a.LastName as 'emp'
from Employees a
left outer join Employees b
on a.EmployeeID = b.ReportsTo
where b.ReportsTo is null


-- Napisz polecenie, które wyœwietla adresy cz³onków
-- biblioteki, którzy maj¹ dzieci urodzone przed 1 stycznia 1996
use library
select distinct a.member_no, street+' '+city+' '+state as address
from juvenile j
inner join adult a
on j.adult_member_no = a.member_no and j.birth_date < '1996-01-01'
inner join member m
on a.member_no = m.member_no


-- Napisz polecenie, które wyœwietla adresy cz³onków
-- biblioteki, którzy maj¹ dzieci urodzone przed 1 stycznia
-- 1996. Interesuj¹ nas tylko adresy takich cz³onków biblioteki,
-- którzy aktualnie nie przetrzymuj¹ ksi¹¿ek.
use library
select distinct a.member_no, street+' '+city+' '+state as address
from juvenile j
inner join adult a
on j.adult_member_no = a.member_no and j.birth_date < '1996-01-01'
inner join member m
on a.member_no = m.member_no
left outer join loan l
on l.member_no = a.member_no
where l.member_no is null or  due_date < GETDATE()


-- £¹czenie kilku zbiorów wynikowych 

-- do tworzenia pojedynczego zbioru wynikowego z wielu zapytañ
-- ka¿de zapytanie musi mieæ zgodne typy, tê sam¹ liczbê kolumn, 
-- taki sam porz¹dek kolumn w select-list


USE northwind
SELECT (firstname + ' ' + lastname) AS name ,city, postalcode
FROM employees
UNION
SELECT companyname, city, postalcode
FROM customers


-- Napisz polecenie które zwraca imiê i nazwisko (jako
-- pojedyncz¹ kolumnê – name), oraz informacje o adresie:
-- ulica, miasto, stan kod (jako pojedyncz¹ kolumnê – address)
-- dla wszystkich doros³ych cz³onków biblioteki

use library
select m.firstname +' '+ m.lastname as name, 
	   a.street+' '+a.city+ ' '+a.state+' ' +a.zip as address
from adult a
inner join member m 
on m.member_no = a.member_no


-- Napisz polecenie które zwraca informacjê o u¿ytkownikach
-- biblioteki o nr 250, 342, i 1675 (nr, imiê i nazwisko cz³onka
-- biblioteki) oraz informacje o zarezerwowanych ksi¹¿kach (isbn, data) 

select m.member_no, m.firstname +' '+m.lastname as name, r.isbn, r.log_date
from member m
left outer join reservation r    -- jeœli nie maj¹ rezerwacji
on m.member_no = r.member_no
where m.member_no in (250, 342, 1675)


-- Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie (AZ),
-- którzy maj¹ wiêcej ni¿ dwoje dzieci zapisanych do biblioteki 

select j.adult_member_no
from adult a
inner join juvenile j
on j.adult_member_no = a.member_no
where a.state = 'AZ'
group by j.adult_member_no
having count(*) > 2


-- Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie
-- (AZ) którzy maj¹ wiêcej ni¿ dwoje dzieci zapisanych do
-- biblioteki oraz takich którzy mieszkaj¹ w Kaliforni i maj¹
-- wiêcej ni¿ troje dzieci zapisanych do biblioteki

select j.adult_member_no
from adult a
inner join juvenile j
on j.adult_member_no = a.member_no
where a.state = 'AZ'
group by j.adult_member_no
having count(*) > 2
union 
select j.adult_member_no
from adult a
inner join juvenile j
on j.adult_member_no = a.member_no
where a.state = 'CA'
group by j.adult_member_no
having count(*) > 3



-- Æwiczenia

--1. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ liczbê
-- zamówionych przez klienta jednostek.

use Northwind 
select c.CategoryName, o.CustomerID, sum(od.Quantity) as 'qty' from 
Categories c
inner join Products p
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
inner join Orders o 
on o.OrderID = od.OrderID
group by c.CategoryName, o.CustomerID


-- 2. Dla ka¿dego zamówienia podaj ³¹czn¹ liczbê zamówionych jednostek
-- oraz nazwê klienta

select o.orderID, sum(od.Quantity) as 'qty', c.CompanyName
from orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName


-- 3. Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia,
-- dla których ³¹czna liczba jednostek jest wiêksza ni¿ 250.

select o.orderID, sum(od.Quantity) as 'qty', c.CompanyName
from orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName
having sum(od.Quantity) > 250


-- 4. Dla ka¿dego klienta (nazwa) podaj nazwy towarów, które zamówi³

select distinct c.CompanyName, p.ProductName
from customers c
inner join orders o
on o.CustomerID = c.CustomerID 
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Products p
on p.ProductID = od.ProductID


-- 5. Dla ka¿dego klienta (nazwa) podaj wartoœæ poszczególnych
-- zamówieñ. Gdy klient nic nie zamówi³ te¿ powinna pojawiæ siê
-- informacja.

select c.CompanyName, o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as 'value'
from Customers c 
left outer join Orders o 
on o.CustomerID = c.CustomerID
left outer join [Order Details] od
on od.OrderID = o.OrderID
group by c.CompanyName, o.OrderID
order by c.CompanyName


-- 6. Podaj czytelników (imiê, nazwisko), którzy nigdy nie po¿yczyli ¿adnej ksi¹¿ki.

use library 
select m.firstname +' '+m.lastname as name
from member m
left outer join loanhist lh
on m.member_no = lh.member_no
left outer join loan l
on l.member_no = m.member_no
where lh.member_no is null and l.member_no is null



