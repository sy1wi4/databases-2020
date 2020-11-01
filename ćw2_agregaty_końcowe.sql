use Northwind

-- �wiczenie 1

-- 1. Napisz polecenie, kt�re oblicza warto�� sprzeda�y dla ka�dego zam�wienia i wynik
-- zwraca posortowany w malej�cej kolejno�ci (wg warto�ci sprzeda�y).

select orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc


-- 2. Zmodyfikuj zapytanie z punktu 1., tak aby zwraca�o pierwszych 10 wierszy

select TOP 10 orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc


-- 3. Zmodyfikuj zapytanie z punktu 2., tak aby zwraca�o 10 pierwszych
-- produkt�w wliczaj�c r�wnorz�dne. Por�wnaj wyniki.

select TOP 10 WITH TIES orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc



-- �wiczenie 2

-- 1. Podaj liczb� zam�wionych jednostek produkt�w dla produkt�w o identyfikatorze < 3

select productid, sum(quantity) as "total quantity" from [Order Details]
group by productid
having productid < 3


-- 2. Zmodyfikuj zapytanie z punktu 1. tak aby podawa�o liczb� zam�wionych 
-- jednostek produktu dla wszystkich produkt�w

select productid, sum(quantity) as "total quantity" from [Order Details]
group by productid


-- 3. Podaj warto�� zam�wienia dla ka�dego zam�wienia, dla kt�rego ��czna 
-- liczba zamawianych jednostek produkt�w jest > 250 

select orderid, sum(unitprice*quantity*(1-discount)) as "order value"
from [Order Details]
group by orderid
having sum(quantity) > 250



-- �wiczenie 3

-- 1. Napisz polecenie, kt�re oblicza sumaryczn� ilo�� zam�wionych towar�w
-- i porz�dkuje wg productid i orderid oraz wykonuje kalkulacje rollup.

select productid, orderid, sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with rollup


-- 2. Zmodyfikuj zapytanie z punktu 1., tak aby ograniczy� wynik tylko do produktu o numerze 50.

select productid, orderid, sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with rollup
having productid = 50


-- 3. Jakie jest znaczenie warto�ci null w kolumnie productid i orderid?

-- oznacza to tyle, �e obliczona jest suma wszystkich productid b�d� orderid


-- 4. Zmodyfikuj polecenie z punktu 1. u�ywaj�c operator cube zamiast rollup. 
-- U�yj r�wnie� funkcji GROUPING na kolumnach productid i orderid do 
-- rozr�nienia mi�dzy sumarycznymi i szczeg�owymi wierszami w zbiorze

select productid, grouping(productid), orderid, grouping(orderid),
sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with cube
having productid = 50


-- 5. Kt�re wiersze s� podsumowaniami?
-- Kt�re podsumowuj� wed�ug produktu, a kt�re wed�ug zam�wienia?

-- Podsumowaniami s� wiersze, kt�re w kom�rce productid lub orderid zawieraj� NULL.
-- Je�eli NULL jest w orderid, to wiersz podsumowuje wg produktu, je�eli NULL w productid, 
-- to wg zam�wienia.

