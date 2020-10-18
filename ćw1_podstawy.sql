use Northwind


-- Wyb�r kolumn - �wiczenia


-- 1. Wybierz nazwy i adresy wszystkich klient�w
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) from Customers

-- 2. Wybierz nazwiska i numery telefon�w pracownik�w
select LastName, HomePhone from Employees

-- 3. Wybierz nazwy i ceny produkt�w
select ProductName, UnitPrice from Products

-- 4. Poka� nazwy i opisy wszystkich kategorii produkt�w
select CategoryName, Description from Categories

-- 5. Poka� nazwy i adresy stron www dostawc�w
select CompanyName,HomePage from Suppliers



-- Wyb�r wierszy - �wiczenia


-- 1. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) 
from Customers 
where City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w Hiszpanii
select CompanyName, FullAddress = (Address + ', ' + City + ', ' + PostalCode) 
from Customers 
where Country = 'France' or Country = 'Spain'

-- 3. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20 a 30
select ProductName, UnitPrice from Products
where UnitPrice < 30 and UnitPrice > 20

-- 4. Wybierz nazwy i ceny produkt�w z kategorii �meat�
select CategoryID from Categories
where CategoryName like 'Meat%'

select ProductName, UnitPrice from Products
where CategoryID = 6

-- 5. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� �Tokyo Traders�
select SupplierID from Suppliers
where CompanyName like 'Tokyo Traders'

select ProductName, UnitsInStock from Products
where SupplierID = 4

-- 6. Wybierz nazwy produkt�w kt�rych nie ma w magazynie
select ProductName from Products
where UnitsInStock = 0 
-- co z wycofanymi?



--Por�wnywanie napis�w (string�w) - �wiczenia


--1. Szukamy informacji o produktach sprzedawanych w butelkach (�bottle�)
select * from products
where QuantityPerUnit like '%bottle%'

--2. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� z zakresu od B do L
select LastName,Title from Employees
where LastName like '[B-L]%'

--3. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� B lub L
select LastName,Title from Employees
where LastName like '[BL]%'

-- 4.  Znajd� nazwy kategorii, kt�re w opisie zawieraj� przecinek
select CategoryName from Categories
where Description like '%,%'

-- 5. Znajd� klient�w, kt�rzy w swojej nazwie maj� w kt�rym� miejscu s�owo �Store� 
select * from Customers
where CompanyName like '%Store%'



-- Zakres warto�ci - �wiczenia


--1. Szukamy informacji o produktach o cenach mniejszych ni� 10 lub wi�kszych ni� 20
select * from Products
where UnitPrice < 10 or UnitPrice > 20 

-- albo
select * from Products 
where UnitPrice not between 10 and 20

-- 2. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00
select ProductName, UnitPrice from Products
where UnitPrice between 20.00 and 30.00



-- Warunki logiczne - �wiczenie


--1. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Japonii (Japan) lub we W�oszech (Italy)
select CompanyName, Country from Customers
where Country like 'Japan' or Country like 'Italy'



-- warto�ci NULL - �wiczenie


-- 1. Napisz instrukcj� select tak aby wybra� numer zlecenia, dat� zam�wienia, numer klienta dla wszystkich
--	  niezrealizowanych jeszcze zlece�, dla kt�rych krajem odbiorcy jest Argentyna

select OrderID, OrderDate, CustomerID from Orders
where ShippedDate is NULL and ShipCountry like 'Argentina'



--- Sortowanie danych - �wiczenia


-- 1. Wybierz nazwy i kraje wszystkich klient�w, wyniki posortuj wed�ug kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie

select CompanyName, Country from Customers 
order by Country, CompanyName
--albo order by 2,1


-- 2. Wybierz informacj� o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malej�co wg ceny

select CategoryID, ProductName, UnitPrice  from  Products
order by CategoryID, UnitPrice desc

-- 3. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Wielkiej Brytanii (UK) 
--    lub we W�oszech (Italy), wyniki posortuj tak jak w pkt 1

select CompanyName, Country from Customers
where Country like 'UK' or Country like 'Italy'
order by Country, CompanyName
