
CREATE TABLE book (
    isbn VARCHAR(200),
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
    reader_id INT, FOREIGN KEY (reader_id) REFERENCES reader(reader_id),
    isbn INT, FOREIGN KEY (isbn) REFERENCES book(isbn),
    issue_day DATE,
    planned_return_day DATE,
    actual_return_day DATE NULL
    
);
CREATE TABLE  autor (
    autor_name VARCHAR(200),
    autor_id INT PRIMARY KEY
);
DROP TABLE loan CASCADE;
CREATE TABLE  authorship ( 
    book_id INT, FOREIGN KEY (isbn) REFERENCES book(isbn),
    autor_id INT, FOREIGN KEY (autor_id) REFERENCES autor(autor_id)
);
INSERT INTO reader (reader_name, phone,reader_id) VALUES
('Анна Петрова','+79001112233',1),
('Иван Соколов','+79002223344',2 ),
('Мария Ким','+79003334455',3 ),
('Олег Васильев','+79004445566',4 );
INSERT INTO autor (autor_name,autor_id) VALUES
('Михаил Булгаков',1),
('Федор Достоевскиий',2 ),
('Лев Толстой',3 ),
('Илья Ильф',4 ),
('Аркадий Стругацкий',5 );

INSERT INTO book (isbn, title, publication_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);

INSERT INTO loan  VALUES
(DEFAULT,978-5-17-118366-8, '2026-09-01', '2026-09-15', NULL),
(DEFAULT,9,978-5-04-116716-3, ),
(DEFAULT,978-5-389-06256-6,2 ),
(DEFAULT,978-5-04-116716-3,3 ),
(DEFAULT,978-5-699-12014-7,4 ),
(DEFAULT,978-5-389-03713-7,5 );
