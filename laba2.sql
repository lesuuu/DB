
CREATE TABLE book (
    name_book VARCHAR(200),
    birthday  DATE CHECK(birthday>1500)
    book_id INT PRIMARY KEY
);
CREATE TABLE reader (
    reader_name VARCHAR(200),
    phone VARCHAR (12),
    reader_id INT PRIMARY KEY
);
CREATE TABLE loan (
    loan_id INT PRIMARY KEY,
    reader_id INT, FOREIGN KEY (reader_id) REFERENCES reader(reader_id),
    book_id INT, FOREIGN KEY (book_id) REFERENCES book(book_id),
    issue_day DATE,
    planned_return_day DATE,
    actual_return_day DATE NULL
    
);
CREATE TABLE  autor (
    autor_name VARCHAR(200),
    autor_id INT PRIMARY KEY
);

CREATE TABLE  authorship ( 
    book_id INT, FOREIGN KEY (book_id) REFERENCES book(book_id),
    autor_id INT, FOREIGN KEY (autor_id) REFERENCES autor(autor_id)
);
INSERT INTO reader (reader_name, phone)
VALUES ('Анна Петрова','+79001112233' );
INSERT INTO reader (reader_name, phone)
VALUES ('Иван Соколов','+79002223344' );
INSERT INTO reader (reader_name, phone)
VALUES ('Мария Ким','+79003334455' );
INSERT INTO reader (reader_name, phone)
VALUES ('Олег Васильев','+79004445566' );
