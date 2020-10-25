use library

-- Æwiczenie 1 – wybieranie danych


-- 1. Napisz polecenie select, za pomoc¹ którego uzyskasz tytu³ i numer ksi¹¿ki

select title, title_no from title

-- 2. Napisz polecenie, które wybiera tytu³ o numerze 10

select title from title 
where title_no = 10

-- 3. Napisz polecenie, które wybiera numer czytelnika i karê dla tych czytelników,
-- którzy maj¹ kary miêdzy $8 a $9

select member_no, fine_assessed from loanhist
where fine_assessed between 8 and 9

-- 4. Napisz polecenie select, za pomoc¹ którego uzyskasz
-- numer ksi¹¿ki i autora dla wszystkich ksi¹¿ek, których
-- autorem jest Charles Dickens lub Jane Austen

select title_no, author from title
where author in ('Charles Dickens', 'Jane Austen')

-- 5. Napisz polecenie, które wybiera numer tytu³u i tytu³ dla
-- wszystkich rekordów zawieraj¹cych string „adventures” gdzieœ w tytule.

select title_no, title from title
where title like '%adventures%'

-- 6. Napisz polecenie, które wybiera numer czytelnika, karê
-- oraz zap³acon¹ karê dla wszystkich, którzy jeszcze nie zap³acili.

select member_no, isnull(fine_assessed, 0) - isnull(fine_waived, 0) as fine, fine_paid from loanhist
where fine_assessed is not null and fine_assessed - isnull(fine_waived, 0) - isnull(fine_paid, 0) > 0

-- 7. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.

select distinct city,state 
from adult



-- Æwiczenie 2 – manipulowanie wynikowym zbiorem


-- 1. Napisz polecenie, które wybiera wszystkie tytu³y z tablicy
-- title i wyœwietla je w porz¹dku alfabetycznym.

select title from title
order by title


-- 2. Napisz polecenie, które:
-- * wybiera numer cz³onka biblioteki, isbn ksi¹¿ki i wartoœæ naliczonej kary dla 
--   wszystkich wypo¿yczeñ, dla których naliczono karê
-- * stwórz kolumnê wyliczeniow¹ zawieraj¹c¹ podwojon¹ wartoœæ kolumny fine_assessed
-- * stwórz alias ‘double fine’ dla tej kolumny

select member_no, isbn, fine_assessed, fine_assessed*2 as 'double fine' from loanhist
where fine_assessed is not null and fine_assessed > 0


-- 3. Napisz polecenie, które:
-- * generuje pojedyncz¹ kolumnê, która zawiera kolumny: imiê
--   cz³onka biblioteki, inicja³ drugiego imienia i nazwisko dla
--   wszystkich cz³onków biblioteki, którzy nazywaj¹ siê Anderson
-- * nazwij tak powsta³¹ kolumnê „email_name”

select firstname + middleinitial + lastname as 'e-mail name' from member
where lastname like 'Anderson'

-- * zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych loginów e-mail”
--   utworzonych przez po³¹czenie imienia cz³onka biblioteki, z inicja³em drugiego 
--   imienia i pierwszymi dwoma literami nazwiska (wszystko ma³ymi literami)

select LOWER(firstname + middleinitial + SUBSTRING(lastname, 1, 2)) as 'e-mail name'
from member
where lastname like 'Anderson'


-- 4. Napisz polecenie, które wybiera title i title_no z tablicy title.
select 'The title is: ' + title + ', title number' + str(title_no) from title
-- error: ³aczenie varchar i int

-- inaczej:
select FORMATMESSAGE('The title is: %s, title number %d', title, title_no) from title


