use Northwind

-- Ćwiczenie 1

-- 1. Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia i wynik
-- zwraca posortowany w malejącej kolejności (wg wartości sprzedaży).

select orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc


-- 2. Zmodyfikuj zapytanie z punktu 1., tak aby zwracało pierwszych 10 wierszy

select TOP 10 orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc


-- 3. Zmodyfikuj zapytanie z punktu 2., tak aby zwracało 10 pierwszych
-- produktów wliczając równorzędne. Porównaj wyniki.

select TOP 10 WITH TIES orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc



-- Ćwiczenie 2

-- 1. Podaj liczbę zamówionych jednostek produktów dla produktów o identyfikatorze < 3

select productid, sum(quantity) as "total quantity" from [Order Details]
group by productid
having productid < 3


-- 2. Zmodyfikuj zapytanie z punktu 1. tak aby podawało liczbę zamówionych 
-- jednostek produktu dla wszystkich produktów

select productid, sum(quantity) as "total quantity" from [Order Details]
group by productid


-- 3. Podaj wartość zamówienia dla każdego zamówienia, dla którego łączna 
-- liczba zamawianych jednostek produktów jest > 250 

select orderid, sum(unitprice*quantity*(1-discount)) as "order value"
from [Order Details]
group by orderid
having sum(quantity) > 250



-- Ćwiczenie 3

-- 1. Napisz polecenie, które oblicza sumaryczną ilość zamówionych towarów
-- i porządkuje wg productid i orderid oraz wykonuje kalkulacje rollup.

select productid, orderid, sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with rollup


-- 2. Zmodyfikuj zapytanie z punktu 1., tak aby ograniczyć wynik tylko do produktu o numerze 50.

select productid, orderid, sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with rollup
having productid = 50


-- 3. Jakie jest znaczenie wartości null w kolumnie productid i orderid?

-- oznacza to tyle, że obliczona jest suma wszystkich productid bądź orderid


-- 4. Zmodyfikuj polecenie z punktu 1. używając operator cube zamiast rollup. 
-- Użyj również funkcji GROUPING na kolumnach productid i orderid do 
-- rozróżnienia między sumarycznymi i szczegółowymi wierszami w zbiorze

select productid, grouping(productid), orderid, grouping(orderid),
sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with cube


-- 5. Które wiersze są podsumowaniami?
-- Które podsumowują według produktu, a które według zamówienia?

-- Podsumowaniami są wiersze, które w komórce productid lub orderid zawierają NULL.
-- Jeżeli NULL jest w orderid, to wiersz podsumowuje wg produktu, jeżeli NULL w productid, 
-- to wg zamówienia.

