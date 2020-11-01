use Northwind

-- Æwiczenie 1

-- 1. Napisz polecenie, które oblicza wartoœæ sprzeda¿y dla ka¿dego zamówienia i wynik
-- zwraca posortowany w malej¹cej kolejnoœci (wg wartoœci sprzeda¿y).

select orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc


-- 2. Zmodyfikuj zapytanie z punktu 1., tak aby zwraca³o pierwszych 10 wierszy

select TOP 10 orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc


-- 3. Zmodyfikuj zapytanie z punktu 2., tak aby zwraca³o 10 pierwszych
-- produktów wliczaj¹c równorzêdne. Porównaj wyniki.

select TOP 10 WITH TIES orderid, sum(UnitPrice*Quantity*(1-Discount)) as "sale value" 
from [order details]
group by OrderID
order by [sale value] desc



-- Æwiczenie 2

-- 1. Podaj liczbê zamówionych jednostek produktów dla produktów o identyfikatorze < 3

select productid, sum(quantity) as "total quantity" from [Order Details]
group by productid
having productid < 3


-- 2. Zmodyfikuj zapytanie z punktu 1. tak aby podawa³o liczbê zamówionych 
-- jednostek produktu dla wszystkich produktów

select productid, sum(quantity) as "total quantity" from [Order Details]
group by productid


-- 3. Podaj wartoœæ zamówienia dla ka¿dego zamówienia, dla którego ³¹czna 
-- liczba zamawianych jednostek produktów jest > 250 

select orderid, sum(unitprice*quantity*(1-discount)) as "order value"
from [Order Details]
group by orderid
having sum(quantity) > 250



-- Æwiczenie 3

-- 1. Napisz polecenie, które oblicza sumaryczn¹ iloœæ zamówionych towarów
-- i porz¹dkuje wg productid i orderid oraz wykonuje kalkulacje rollup.

select productid, orderid, sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with rollup


-- 2. Zmodyfikuj zapytanie z punktu 1., tak aby ograniczyæ wynik tylko do produktu o numerze 50.

select productid, orderid, sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with rollup
having productid = 50


-- 3. Jakie jest znaczenie wartoœci null w kolumnie productid i orderid?

-- oznacza to tyle, ¿e obliczona jest suma wszystkich productid b¹dŸ orderid


-- 4. Zmodyfikuj polecenie z punktu 1. u¿ywaj¹c operator cube zamiast rollup. 
-- U¿yj równie¿ funkcji GROUPING na kolumnach productid i orderid do 
-- rozró¿nienia miêdzy sumarycznymi i szczegó³owymi wierszami w zbiorze

select productid, grouping(productid), orderid, grouping(orderid),
sum(quantity) as "total quantity" 
from [Order Details]
group by productid, orderid
with cube
having productid = 50


-- 5. Które wiersze s¹ podsumowaniami?
-- Które podsumowuj¹ wed³ug produktu, a które wed³ug zamówienia?

-- Podsumowaniami s¹ wiersze, które w komórce productid lub orderid zawieraj¹ NULL.
-- Je¿eli NULL jest w orderid, to wiersz podsumowuje wg produktu, je¿eli NULL w productid, 
-- to wg zamówienia.

