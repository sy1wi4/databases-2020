
-- iloczyn kartezja�ski - ka�dy wiersz z 1 tabeli z ka�dym wierszem z 2

SELECT b.buyer_name AS [b.buyer_name],
b.buyer_id AS [b.buyer_id],
s.buyer_id AS [s.buyer_id],
qty AS [s.qty]
FROM buyers AS b, sales AS s
WHERE b.buyer_name = 'Adam Barr' and s.buyer_id = b.buyer_id


SELECT buyer_name, b.buyer_id, qty
FROM buyers AS b, sales AS s
WHERE s.buyer_id = b.buyer_id


-- INNER JOIN - z��czenie wewn�trzne

USE joindb
SELECT buyer_name, s.buyer_id, qty
FROM buyers b 
INNER JOIN sales s
ON b.buyer_id = s.buyer_id

-- Napisz polecenie zwracaj�ce nazwy produkt�w i firmy je dostarczaj�ce
-- tak aby produkty bez �dostarczycieli� i �dostarczyciele� bez
-- produkt�w nie pojawiali si� w wyniku.
use Northwind
select p.ProductName, s.CompanyName 
from suppliers s
inner join products p
on s.SupplierID = p.SupplierID

-- Napisz polecenie zwracaj�ce jako wynik nazwy klient�w,
-- kt�rzy z�o�yli zam�wienia po 1 marca 1998
select distinct c.companyname, o.orderdate
from orders o 
inner join customers c
on o.customerid = c.customerid and  orderdate > '1998-03-01 00:00:00.000'


-- OUTER JOIN - z��czenie zewn�trzne

USE joindb
SELECT buyer_name, sales.buyer_id, qty
FROM buyers LEFT OUTER JOIN sales
ON buyers.buyer_id = sales.buyer_id


-- Napisz polecenie zwracaj�ce wszystkich klient�w z datami zam�wie�.
use Northwind
select c.companyname, c.customerid, o.orderdate
from customers c 
left outer join orders o
on o.customerid = c.customerid


-- Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych
-- cz�onkami biblioteki. Interesuje nas imi�, nazwisko i data
-- urodzenia dziecka.
use library 

select firstname, m.lastname, j.birth_date
from juvenile j
inner join member m
on j.member_no = m.member_no


-- Napisz polecenie, kt�re podaje tytu�y aktualnie wypo�yczonych ksi��ek
select distinct title
from loan l
inner join title t
on l.title_no = t.title_no


-- Podaj informacje o karach zap�aconych za przetrzymywanie
-- ksi��ki o tytule �Tao Teh King�. Interesuje nas data oddania
-- ksi��ki, ile dni by�a przetrzymywana i jak� zap�acono kar�
select in_date, due_date, datediff(dd, due_date, in_date) as 'days', fine_assessed
from loanhist l 
inner join title t
on l.title_no = t.title_no and title = 'Tao Teh King' and in_date > due_date


-- Napisz polecenie kt�re podaje list� ksi��ek (numery ISBN)
-- zarezerwowanych przez osob� o nazwisku: Stephen A.Graff
select isbn
from member m
inner join reservation r
on m.member_no = r.member_no
where m.firstname = 'Stephen' and m.lastname = 'Graff' and m.middleinitial = 'A'


-- Wybierz nazwy i ceny produkt�w o cenie jednostkowej
-- pomi�dzy 20 a 30, dla ka�dego produktu podaj dane
-- adresowe dostawcy
use Northwind

select p.productname, p.unitprice, s.address
from products p 
inner join suppliers s 
on p.SupplierID = s.SupplierID
where UnitPrice between 20 and 30


-- Wybierz nazwy produkt�w oraz informacje o stanie
-- magazynu dla produkt�w dostarczanych przez firm� �Tokyo Traders�
select p.ProductName, p.UnitsInStock
from suppliers s
inner join products p
on p.SupplierID = s.SupplierID
where s.CompanyName = 'Tokyo Traders'


-- Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia
-- w 1997 roku, je�li tak to poka� ich dane adresowe

-- !!!
-- czyli wybieramy tych klient�w, kt�rzy zam�wili co� w 1997 oraz takich, 
-- dla kt�rych nie ma odpowiednika w prawej tabeli - czyli nie zam�wiono wtedy nic 
-- (LEFT OUTER JOIN) i bierzemy te, kt�rych orderdate = null, dzi�ki czemu nie pojawi� 
-- si� te, dla kt�rych co� wtedy zam�wiono

select c.CompanyName, orderdate,orderid,  Address + ' ' + City as address
from customers c
left outer join orders o
on o.CustomerID = c.CustomerID and YEAR(orderdate) = 1997
where orderdate is null


-- Wybierz nazwy i numery telefon�w dostawc�w,
-- dostarczaj�cych produkty, kt�rych aktualnie nie ma w magazynie
select CompanyName, Phone
from suppliers s
inner join products p
on s.SupplierID = p.SupplierID
where UnitsInStock = 0



-- CROSS JOIN - iloczyn kartezja�ski

USE joindb
SELECT buyer_name, qty
FROM buyers
CROSS JOIN sales


-- Napisz polecenie, wy�wietlaj�ce CROSS JOIN mi�dzy
-- shippers i suppliers. U�yteczne dla listowania wszystkich
-- mo�liwych sposob�w w jaki dostawcy mog� dostarcza� swoje produkty
use Northwind
select shippers.CompanyName as [shippers.CompanyName], suppliers.CompanyName as [suppliers.CompanyName]
from shippers
cross join suppliers



-- ��czenie wi�cej ni� dw�ch tabel
use joindb

SELECT buyer_name, prod_name, qty
FROM buyers
INNER JOIN sales
ON buyers.buyer_id = sales.buyer_id
INNER JOIN produce
ON sales.prod_id = produce.prod_id


-- Napisz polecenie zwracaj�ce list� produkt�w zamawianych
-- w dniu 1996-07-08.
use Northwind
select od.ProductID, p.ProductName
from orders o
inner join [Order Details] od
on od.OrderID = o.OrderID and o.OrderDate = '1996-07-08'
inner join products p 
on p.ProductID = od.ProductID


-- Wybierz nazwy i ceny produkt�w (baza northwind) o cenie
-- jednostkowej pomi�dzy 20 a 30, dla ka�dego produktu
-- podaj dane adresowe dostawcy, interesuj� nas tylko
-- produkty z kategorii �Meat/Poultry
use Northwind
select ProductName, UnitPrice, Address
from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID and UnitPrice between 20 and 30 
inner join Categories c
on c.CategoryID = p.CategoryID
where CategoryName = 'Meat/Poultry'


-- Wybierz nazwy i ceny produkt�w z kategorii �Confections�
-- dla ka�dego produktu podaj nazw� dostawcy

select ProductName, UnitPrice, s.CompanyName 
from Categories c
inner join Products p
on c.CategoryID = p.CategoryID
inner join Suppliers s
on s.SupplierID = p.SupplierID
where CategoryName = 'Confections'


-- Wybierz nazwy i numery telefon�w klient�w , kt�rym w
-- 1997 roku przesy�ki dostarcza�a firma �United Package�
select distinct c.CompanyName,  c.Phone 
from shippers s
inner join orders o
on s.ShipperID = o.ShipVia
inner join Customers c
on o.CustomerID = c.CustomerID
where s.CompanyName = 'United Package' and YEAR(o.ShippedDate) = 1997


-- Wybierz nazwy i numery telefon�w klient�w, kt�rzy
-- kupowali produkty z kategorii �Confections�

select distinct c.CompanyName, c.Phone
from customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join [Order Details] od on od.OrderID = o.OrderID
inner join Products p on p.ProductID = od.ProductID
inner join Categories cat on cat.CategoryID = p.CategoryID
where cat.CategoryName = 'Confections'


-- Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych
-- cz�onkami biblioteki. Interesuje nas imi�, nazwisko, data
-- urodzenia dziecka i adres zamieszkania dziecka.
use library
select m.firstname, m.lastname, j.birth_date, street+' '+city+' '+state as address
from juvenile j
inner join member m 
on m.member_no = j.member_no
inner join adult a 
on j.adult_member_no = a.member_no


-- Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych
-- cz�onkami biblioteki. Interesuje nas imi�, nazwisko, data
-- urodzenia dziecka, adres zamieszkania dziecka oraz imi� i
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



-- ��czenie tabeli samej ze sob� - self join


-- Napisz polecenie, kt�re wy�wietla list� wszystkich
-- kupuj�cych te same produkty (bez duplikat�w).
USE joindb
select a.buyer_id as 'buyer 1', b.buyer_id as 'buyer 2', a.prod_id
from sales a
inner join sales b
on a.prod_id = b.prod_id
where a.buyer_id < b.buyer_id    -- !!! zapewnia unikalno��


-- Napisz polecenie, kt�re pokazuje pary pracownik�w
-- zajmuj�cych to samo stanowisko.
use Northwind
select a.FirstName+' '+a.LastName as 'emp 1', b.FirstName+' '+b.LastName as 'emp 2'
from Employees a
inner join Employees b
on a.Title = b.Title
where a.EmployeeID < b.EmployeeID


-- Napisz polecenie, kt�re wy�wietla pracownik�w oraz ich podw�adnych.
select a.FirstName+' '+a.LastName as 'head', b.FirstName+' '+b.LastName as 'emp' 
from Employees a
inner join Employees b
on a.EmployeeID = b.ReportsTo


-- Napisz polecenie, kt�re wy�wietla pracownik�w, kt�rzy nie maj� podw�adnych.
select a.FirstName+' '+a.LastName as 'emp'
from Employees a
left outer join Employees b
on a.EmployeeID = b.ReportsTo
where b.ReportsTo is null


-- Napisz polecenie, kt�re wy�wietla adresy cz�onk�w
-- biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia 1996
use library
select distinct a.member_no, street+' '+city+' '+state as address
from juvenile j
inner join adult a
on j.adult_member_no = a.member_no and j.birth_date < '1996-01-01'
inner join member m
on a.member_no = m.member_no


-- Napisz polecenie, kt�re wy�wietla adresy cz�onk�w
-- biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia
-- 1996. Interesuj� nas tylko adresy takich cz�onk�w biblioteki,
-- kt�rzy aktualnie nie przetrzymuj� ksi��ek.
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


-- ��czenie kilku zbior�w wynikowych 

-- do tworzenia pojedynczego zbioru wynikowego z wielu zapyta�
-- ka�de zapytanie musi mie� zgodne typy, t� sam� liczb� kolumn, 
-- taki sam porz�dek kolumn w select-list


USE northwind
SELECT (firstname + ' ' + lastname) AS name ,city, postalcode
FROM employees
UNION
SELECT companyname, city, postalcode
FROM customers


-- Napisz polecenie kt�re zwraca imi� i nazwisko (jako
-- pojedyncz� kolumn� � name), oraz informacje o adresie:
-- ulica, miasto, stan kod (jako pojedyncz� kolumn� � address)
-- dla wszystkich doros�ych cz�onk�w biblioteki

use library
select m.firstname +' '+ m.lastname as name, 
	   a.street+' '+a.city+ ' '+a.state+' ' +a.zip as address
from adult a
inner join member m 
on m.member_no = a.member_no


-- Napisz polecenie kt�re zwraca informacj� o u�ytkownikach
-- biblioteki o nr 250, 342, i 1675 (nr, imi� i nazwisko cz�onka
-- biblioteki) oraz informacje o zarezerwowanych ksi��kach (isbn, data) 

select m.member_no, m.firstname +' '+m.lastname as name, r.isbn, r.log_date
from member m
left outer join reservation r    -- je�li nie maj� rezerwacji
on m.member_no = r.member_no
where m.member_no in (250, 342, 1675)


-- Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ),
-- kt�rzy maj� wi�cej ni� dwoje dzieci zapisanych do biblioteki 

select j.adult_member_no
from adult a
inner join juvenile j
on j.adult_member_no = a.member_no
where a.state = 'AZ'
group by j.adult_member_no
having count(*) > 2


-- Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie
-- (AZ) kt�rzy maj� wi�cej ni� dwoje dzieci zapisanych do
-- biblioteki oraz takich kt�rzy mieszkaj� w Kaliforni i maj�
-- wi�cej ni� troje dzieci zapisanych do biblioteki

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



-- �wiczenia

--1. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb�
-- zam�wionych przez klienta jednostek.

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


-- 2. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek
-- oraz nazw� klienta

select o.orderID, sum(od.Quantity) as 'qty', c.CompanyName
from orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName


-- 3. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia,
-- dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250.

select o.orderID, sum(od.Quantity) as 'qty', c.CompanyName
from orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Customers c
on c.CustomerID = o.CustomerID
group by o.OrderID, c.CompanyName
having sum(od.Quantity) > 250


-- 4. Dla ka�dego klienta (nazwa) podaj nazwy towar�w, kt�re zam�wi�

select distinct c.CompanyName, p.ProductName
from customers c
inner join orders o
on o.CustomerID = c.CustomerID 
inner join [Order Details] od
on od.OrderID = o.OrderID
inner join Products p
on p.ProductID = od.ProductID


-- 5. Dla ka�dego klienta (nazwa) podaj warto�� poszczeg�lnych
-- zam�wie�. Gdy klient nic nie zam�wi� te� powinna pojawi� si�
-- informacja.

select c.CompanyName, o.OrderID, round(sum(quantity*unitprice*(1-discount)), 2) as 'value'
from Customers c 
left outer join Orders o 
on o.CustomerID = c.CustomerID
left outer join [Order Details] od
on od.OrderID = o.OrderID
group by c.CompanyName, o.OrderID
order by c.CompanyName


-- 6. Podaj czytelnik�w (imi�, nazwisko), kt�rzy nigdy nie po�yczyli �adnej ksi��ki.

use library 
select m.firstname +' '+m.lastname as name
from member m
left outer join loanhist lh
on m.member_no = lh.member_no
left outer join loan l
on l.member_no = m.member_no
where lh.member_no is null and l.member_no is null



