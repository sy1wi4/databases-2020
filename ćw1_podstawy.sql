use Northwind


-- Wybór kolumn - ćwiczenia


-- 1. Wybierz nazwy i adresy wszystkich klientów
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) from Customers

-- 2. Wybierz nazwiska i numery telefonów pracowników
select LastName, HomePhone from Employees

-- 3. Wybierz nazwy i ceny produktów
select ProductName, UnitPrice from Products

-- 4. Pokaż nazwy i opisy wszystkich kategorii produktów
select CategoryName, Description from Categories

-- 5. Pokaż nazwy i adresy stron www dostawców
select CompanyName,HomePage from Suppliers



-- Wybór wierszy - ćwiczenia


-- 1. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) 
from Customers 
where City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub Hiszpanii
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) 
from Customers 
where Country = 'France' or Country = 'Spain'

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20 a 30
select ProductName, UnitPrice from Products
where UnitPrice < 30 and UnitPrice > 20

-- 4. Wybierz nazwy i ceny produktów z kategorii ‘meat’
select CategoryID from Categories
where CategoryName like 'Meat%'

select ProductName, UnitPrice from Products
where CategoryID = 6

-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
select SupplierID from Suppliers
where CompanyName like 'Tokyo Traders'

select ProductName, UnitsInStock from Products
where SupplierID = 4

-- 6. Wybierz nazwy produktów których nie ma w magazynie
select ProductName from Products
where UnitsInStock = 0 
-- co z wycofanymi?



--Porównywanie napisów (stringów) - ćwiczenia


--1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
select * from products
where QuantityPerUnit like '%bottle%'

--2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
select LastName,Title from Employees
where LastName like '[B-L]%'

--3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
select LastName,Title from Employees
where LastName like '[BL]%'

-- 4.  Znajdź nazwy kategorii, które w opisie zawierają przecinek
select CategoryName from Categories
where Description like '%,%'

-- 5. Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’ 
select * from Customers
where CompanyName like '%Store%'



-- Zakres wartości - ćwiczenia


--1. Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
select * from Products
where UnitPrice < 10 or UnitPrice > 20 

-- albo
select * from Products 
where UnitPrice not between 10 and 20

-- 2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
select ProductName, UnitPrice from Products
where UnitPrice between 20.00 and 30.00



-- Warunki logiczne - ćwiczenie


--1. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
select CompanyName, Country from Customers
where Country like 'Japan' or Country like 'Italy'



-- wartości NULL - ćwiczenie


-- 1. Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer klienta dla wszystkich
--	  niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy jest Argentyna

select OrderID, OrderDate, CustomerID from Orders
where ShippedDate is NULL and ShipCountry like 'Argentina'



--- Sortowanie danych - ćwiczenia


-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie

select CompanyName, Country from Customers 
order by Country, CompanyName
--albo order by 2,1


-- 2. Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malejąco wg ceny

select CategoryID, ProductName, UnitPrice  from  Products
order by CategoryID, UnitPrice desc

-- 3. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Wielkiej Brytanii (UK) 
--    lub we Włoszech (Italy), wyniki posortuj tak jak w pkt 1

select CompanyName, Country from Customers
where Country like 'UK' or Country like 'Italy'
order by Country, CompanyName
