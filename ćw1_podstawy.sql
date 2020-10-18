use Northwind


-- Wybór kolumn - æwiczenia


-- 1. Wybierz nazwy i adresy wszystkich klientów
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) from Customers

-- 2. Wybierz nazwiska i numery telefonów pracowników
select LastName, HomePhone from Employees

-- 3. Wybierz nazwy i ceny produktów
select ProductName, UnitPrice from Products

-- 4. Poka¿ nazwy i opisy wszystkich kategorii produktów
select CategoryName, Description from Categories

-- 5. Poka¿ nazwy i adresy stron www dostawców
select CompanyName,HomePage from Suppliers



-- Wybór wierszy - æwiczenia


-- 1. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby w Londynie
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) 
from Customers 
where City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby we Francji lub w Hiszpanii
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) 
from Customers 
where Country = 'France' or Country = 'Spain'

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20 a 30
select ProductName, UnitPrice from Products
where UnitPrice < 30 and UnitPrice > 20

-- 4. Wybierz nazwy i ceny produktów z kategorii ‘meat’
select CategoryID from Categories
where CategoryName like 'Meat%'

select ProductName, UnitPrice from Products
where CategoryID = 6

-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmê ‘Tokyo Traders’
select SupplierID from Suppliers
where CompanyName like 'Tokyo Traders'

select ProductName, UnitsInStock from Products
where SupplierID = 4

-- 6. Wybierz nazwy produktów których nie ma w magazynie
select ProductName from Products
where UnitsInStock = 0 
-- co z wycofanymi?



--Porównywanie napisów (stringów) - æwiczenia


--1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
select * from products
where QuantityPerUnit like '%bottle%'

--2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê z zakresu od B do L
select LastName,Title from Employees
where LastName like '[B-L]%'

--3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê B lub L
select LastName,Title from Employees
where LastName like '[BL]%'

-- 4.  ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinek
select CategoryName from Categories
where Description like '%,%'

-- 5. ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ miejscu s³owo ‘Store’ 
select * from Customers
where CompanyName like '%Store%'



-- Zakres wartoœci - æwiczenia


--1. Szukamy informacji o produktach o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20
select * from Products
where UnitPrice < 10 or UnitPrice > 20 

-- albo
select * from Products 
where UnitPrice not between 10 and 20

-- 2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00
select ProductName, UnitPrice from Products
where UnitPrice between 20.00 and 30.00



-- Warunki logiczne - æwiczenie


--1. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan) lub we W³oszech (Italy)
select CompanyName, Country from Customers
where Country like 'Japan' or Country like 'Italy'



-- wartoœci NULL - æwiczenie


-- 1. Napisz instrukcjê select tak aby wybraæ numer zlecenia, datê zamówienia, numer klienta dla wszystkich
--	  niezrealizowanych jeszcze zleceñ, dla których krajem odbiorcy jest Argentyna

select OrderID, OrderDate, CustomerID from Orders
where ShippedDate is NULL and ShipCountry like 'Argentina'



--- Sortowanie danych - æwiczenia


-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj wed³ug kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie

select CompanyName, Country from Customers 
order by Country, CompanyName
--albo order by 2,1


-- 2. Wybierz informacjê o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malej¹co wg ceny

select CategoryID, ProductName, UnitPrice  from  Products
order by CategoryID, UnitPrice desc

-- 3. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Wielkiej Brytanii (UK) 
--    lub we W³oszech (Italy), wyniki posortuj tak jak w pkt 1

select CompanyName, Country from Customers
where Country like 'UK' or Country like 'Italy'
order by Country, CompanyName
