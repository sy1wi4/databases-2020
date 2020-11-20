-- W miejscu w którym możemy użyć nazwy tabeli, możemy użyć podzapytania
USE northwind

SELECT T.orderid, T.customerid
FROM ( SELECT orderid, customerid FROM orders ) AS T

-- zamiast:
select orderid, customerid from orders


-- Podzapytania skorelowane

-- Zewnętrzne zapytanie przekazuje dane do zapytania wenętrznego
-- Zapytanie wewnętrzne wykorzystuje te dane od wygenerowania wyniku
-- Zapytanie wewnętrzne zwraca ten wynik do zapytania zewnętrznego
-- Proces jest powtarzany dla każdego wiersza zapytania wewnętrznego

SELECT productname, unitprice,( SELECT AVG(unitprice)
	FROM products as p_wew
	WHERE p_zew.categoryid = p_wew.categoryid ) AS average
FROM products as p_zew


-- Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek 

-- bez podzapytnia:
select ProductID, max(quantity) as 'max qty'
from [Order Details]
group by ProductID

-- z podzapytaniem
select distinct productid, quantity
from [Order Details] as orders1
where quantity = 
	(select max(quantity)
	 from [Order Details] as orders2
	 where orders1.productid = orders2.productid)
order by productid


-- Operatory EXISTS, NOT EXISTS

-- Zewnętrzne zapytanie testuje wystąpienie (lub nie) zbioru
-- wynikowego określonego przez zapytanie wewnętrzne
-- zapytanie wewnętrzne zwraca TRUE lub FALSE

-- Zapytanie zwraca listę wszystkich pracowników którzy
-- złożyli zamówienie '9/5/97'

SELECT lastname, employeeid
FROM employees AS e
	WHERE EXISTS (SELECT * FROM orders AS o
	WHERE e.employeeid = o.employeeid
	AND o.orderdate = '9/5/97')


-- Operatory IN, NOT IN

-- Zewnętrzne zapytanie testuje wystąpienie elementu w
-- zbiorze (na liście) wygenerowanym przez zapytanie wewnętrzne 
-- zapytanie wewnętrzne zwraca zbiór elementów

SELECT lastname, employeeid
FROM employees AS e
	WHERE employeeid in (SELECT employeeid FROM orders AS o
	WHERE e.employeeid = o.employeeid
	AND o.orderdate = '9/5/97')
