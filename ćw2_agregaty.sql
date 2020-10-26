use Northwind


-- TOP n wartoœci, u¿ycie funkcji agreguj¹cych - æwiczenia


-- 1.  Podaj liczbê produktów o cenach mniejszych ni¿ 10$ lub wiêkszych ni¿ 20$
select count (*) from products
where UnitPrice not between 10 and 20

-- 2.  Podaj maksymaln¹ cenê produktu dla produktów o cenach poni¿ej 20$
select max(unitprice) as 'max price'  from products
where unitprice < 20

-- 3. Podaj maksymaln¹, minimaln¹ i œredni¹ cenê produktu dla
-- produktów sprzedawanych w butelkach (‘bottle’)
select max(unitprice) as 'max price', min(unitprice) as 'min price', avg(unitprice) as 'average price'
from products
where QuantityPerUnit like '%bottle%'

-- 4. Wypisz informacjê o wszystkich produktach o cenie powy¿ej œredniej

-- tak nie zadzia³a --
--select * from products 
--where unitprice > avg(unitprice)

select avg(unitprice) from products

select * from products
where unitprice > 28.8663

-- 5. Podaj wartoœæ zamówienia o numerze 10250
select round(sum(quantity*unitprice*(1-discount)), 2) as 'value'
from [order details]
where orderid = 10250



-- Grupowanie danych - klauzula GROUP BY - æwiczenia

-- 1. Podaj maksymaln¹ cenê zamawianego produktu dla ka¿dego zamówienia. 
-- Posortuj zamówienia wg maksymalnej ceny produktu

select orderid, max(unitprice) as 'max price' from [order details]
group by orderid 
order by [max price] desc

-- 2. Podaj maksymaln¹ i minimaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
select max(unitprice) as 'max price', min(unitprice) as 'min price' from [Order Details]
group by orderid

-- 3. Podaj liczbê zamówieñ dostarczanych przez poszczególnych spedytorów
select shipvia, count(shipvia) as 'orders no' from orders
group by shipvia

-- 4. Który ze spedytorów by³ najaktywniejszy w 1997 roku?
select top 1 shipvia, count(*) as 'orders no' from orders
where YEAR(shippeddate) = 1997
group by shipvia
order by [orders no] desc



-- U¿ycie klauzuli GROUP BY z klauzul¹ HAVING - æwiczenia

-- 1. Wyœwietl zamówienia dla których liczba pozycji zamówienia jest wiêksza ni¿ 5
select orderid from [order details]
group by orderid
having count(orderid) > 5

-- 2. Wyœwietl klientów, dla których w 1998 roku zrealizowano wiêcej ni¿ 8 zamówieñ 
-- (wyniki posortuj malej¹co wg ³¹cznej kwoty za dostarczenie zamówieñ dla ka¿dego z klientów)
select customerid, count(orderid) as 'orders no' from Orders
where YEAR(orderdate) = 1998
group by customerid
having count(*) > 8
order by sum(freight) desc
 
