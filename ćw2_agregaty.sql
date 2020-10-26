use Northwind


-- TOP n warto�ci, u�ycie funkcji agreguj�cych - �wiczenia


-- 1.  Podaj liczb� produkt�w o cenach mniejszych ni� 10$ lub wi�kszych ni� 20$
select count (*) from products
where UnitPrice not between 10 and 20

-- 2.  Podaj maksymaln� cen� produktu dla produkt�w o cenach poni�ej 20$
select max(unitprice) as 'max price'  from products
where unitprice < 20

-- 3. Podaj maksymaln�, minimaln� i �redni� cen� produktu dla
-- produkt�w sprzedawanych w butelkach (�bottle�)
select max(unitprice) as 'max price', min(unitprice) as 'min price', avg(unitprice) as 'average price'
from products
where QuantityPerUnit like '%bottle%'

-- 4. Wypisz informacj� o wszystkich produktach o cenie powy�ej �redniej

-- tak nie zadzia�a --
--select * from products 
--where unitprice > avg(unitprice)

select avg(unitprice) from products

select * from products
where unitprice > 28.8663

-- 5. Podaj warto�� zam�wienia o numerze 10250
select round(sum(quantity*unitprice*(1-discount)), 2) as 'value'
from [order details]
where orderid = 10250



-- Grupowanie danych - klauzula GROUP BY - �wiczenia

-- 1. Podaj maksymaln� cen� zamawianego produktu dla ka�dego zam�wienia. 
-- Posortuj zam�wienia wg maksymalnej ceny produktu

select orderid, max(unitprice) as 'max price' from [order details]
group by orderid 
order by [max price] desc

-- 2. Podaj maksymaln� i minimaln� cen� zamawianego produktu dla ka�dego zam�wienia
select max(unitprice) as 'max price', min(unitprice) as 'min price' from [Order Details]
group by orderid

-- 3. Podaj liczb� zam�wie� dostarczanych przez poszczeg�lnych spedytor�w
select shipvia, count(shipvia) as 'orders no' from orders
group by shipvia

-- 4. Kt�ry ze spedytor�w by� najaktywniejszy w 1997 roku?
select top 1 shipvia, count(*) as 'orders no' from orders
where YEAR(shippeddate) = 1997
group by shipvia
order by [orders no] desc



-- U�ycie klauzuli GROUP BY z klauzul� HAVING - �wiczenia

-- 1. Wy�wietl zam�wienia dla kt�rych liczba pozycji zam�wienia jest wi�ksza ni� 5
select orderid from [order details]
group by orderid
having count(orderid) > 5

-- 2. Wy�wietl klient�w, dla kt�rych w 1998 roku zrealizowano wi�cej ni� 8 zam�wie� 
-- (wyniki posortuj malej�co wg ��cznej kwoty za dostarczenie zam�wie� dla ka�dego z klient�w)
select customerid, count(orderid) as 'orders no' from Orders
where YEAR(orderdate) = 1998
group by customerid
having count(*) > 8
order by sum(freight) desc
 
