
CREATE TABLE book (
    isbn VARCHAR(200) PRIMARY KEY,
    publication_year int CHECK(publication_year > 1300),
    title VARCHAR(200)
);

CREATE TABLE reader (
    reader_name VARCHAR(200),
    phone VARCHAR (12),
    reader_id INT PRIMARY KEY
);
CREATE TABLE loan (
    loan_id SERIAL PRIMARY KEY,
    reader_id INT REFERENCES reader(reader_id),
    isbn VARCHAR(200) REFERENCES book(isbn),
    issue_day DATE,
    planned_return_day DATE,
    actual_return_day DATE NULL
    
);

CREATE TABLE  autor (
    autor_name VARCHAR(200),
    autor_id INT PRIMARY KEY
);

CREATE TABLE  authorship ( 
    isbn VARCHAR(200) REFERENCES book(isbn),
    autor_id INT, FOREIGN KEY (autor_id) REFERENCES autor(autor_id)
);

##читатели добавлены
INSERT INTO reader (reader_name, phone,reader_id) VALUES
('Васильева Мария','+79003335689',5 ),
('Анна Петрова','+79001112233',1),
('Иван Соколов','+79002223344',2 ),
('Мария Ким','+79003334455',3 ),
('Олег Васильев','+79004445566',4 );

INSERT INTO autor (autor_name,autor_id) VALUES
('Михаил Булгаков',1),
('Федор Достоевскиий',2 ),
('Лев Толстой',3 ),
('Илья Ильф',4 ),
('Аркадий Стругацкий',5 ),
('Борис Стругацкий',6 ),
('Евгений Петров',7 );
#авторы все есть
INSERT INTO book (isbn, title, publication_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);
#книги все есть
INSERT INTO authorship VALUES
('978-5-17-118366-8',1),
('978-5-389-06256-6',2),
('978-5-04-116716-3',3),
('978-5-699-12014-7',4),
('978-5-699-12014-7',7),
('978-5-389-03713-7',5),
('978-5-389-03713-7',6);
#связь книги авторы есть
INSERT INTO loan  VALUES
(DEFAULT, 2, '978-5-17-118366-8', '2026-09-01', '2026-09-15', NULL),
(DEFAULT,4,'978-5-04-116716-3','2016-05-11', '2017-01-01','2017-01-12'),
(DEFAULT,4,'978-5-389-06256-6','2023-07-14','2023-08-14','2023-08-10'),
(DEFAULT,3,'978-5-04-116716-3','2020-11-04','2020-12-04','2021-01-03' ),
(DEFAULT,4,'978-5-699-12014-7','2026-03-08','2026-04-08',NULL),
(DEFAULT,1,'978-5-389-03713-7', '2026-06-08','2026-07-13','2026-09-23');
#

UPDATE Readers
SET phone = '+79009998877'
WHERE full_name = 'Анна Петрова';

UPDATE Loans
SET actual_return_date = '2026-09-10'
WHERE loan_id = 1;
DELETE FROM reader
WHERE reader_name = 'Васильева Мария';


