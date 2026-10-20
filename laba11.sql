CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255),
    team_members VARCHAR(1000)
);
--ошибка в том что в строке не могут идти через запятую имена участников для решения этой проблемы мы создадим две таблизы и третью связующую

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);

CREATE TABLE team_members (
    membrers_id INT PRIMARY KEY,
    member_name VARCHAR(255)
);

CREATE TABLE project_members (
    progect_id INT,
    members_id INT,
    PRIMARY KEY (project_id, members_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (members_id) REFERENCES team_members(members_id)
);


--2
CREATE TABLE EquipmentRentals (
    client_id INT,
    equipment_id INT,
    client_name VARCHAR(255),    -- Имя клиента
    client_email VARCHAR(255),   -- Email клиента
    equipment_name VARCHAR(255), -- Название оборудования
    rental_date DATE,            -- Дата аренды
    PRIMARY KEY (client_id, equipment_id)
);
--Избыточность данных, имя клиента и его email будут постоянно повторяться а потом будет сложно обновить данные нужно создать отдельные таблицы для данных и связать их

CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(500),
    client_email VARCHAR(255)
);


CREATE TABLE equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(500)
);

CREATE TABLE rentals (
    equipment_id INT, FOREIGN KEY,
    rental_date DATE,
    client_id INT, FOREIGN KEY,
    statuss VARCHAR(255) NULL
);


--3
CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    assignments_and_grades TEXT, -- Пример содержимого: '{"Quiz 1": 85, "Midterm": 92, "Essay": 88}'
    PRIMARY KEY (student_id, course_id)
);
--в 1 форме она нарушвет закон не позволяющий хранить много данных в одной строчке. по 2 форме эта таблица нарушает избыточность данных и проблему с их удалением или заменой 

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(500),
    student_email VARCHAR(255)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    profesor_id INT FOREIGN KEY,
);
CREATE TABLE professor (
    profesor_id INT PRIMARY KEY,
    professor_name VARCHAR(500)
);

CREATE TABLE assignments (
    assignments_id INT PRIMARY KEY,
    assignments_name VARCHAR(500)
);

CREATE TABLE assignments_and_grades (
    course_id INT FOREIGN KEY,
    student_id INT FOREIGN KEY,
    assignments INT FOREIGN KEY,
    grades VARCHAR(15)
);

--ПРАКТИКА 11  !!! 
--1
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author_name VARCHAR(255),
    publisher_id INT,
    publisher_name VARCHAR(255),    -- Название издательства
    publisher_city VARCHAR(100)     -- Город, в котором находится издательство
);
--publisher_name и publisher_city зависят от publisher_id а title и author_name зависият от book_id 


CREATE TABLE books (
    book_id INT PRIMARY KEY,
    tatle VARCHAR(500),
    autor_id INT PRIMARY KEY
);

CREATE TABLE autor (
    autor_id INT PRIMARY KEY,
    autor_name VARCHAR(255)
);

CREATE TABLE books_autors (
    book_id INT FOREIGN KEY,
    autor_id INT FOREIGN KEY
);
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(255),
    publisher_city VARCHAR(100)
);


--2
CREATE TABLE RaceResults (
    race_id INT,
    driver_id INT,
    car_model VARCHAR(100),      -- Модель автомобиля
    car_manufacturer VARCHAR(100), -- Производитель автомобиля
    finish_time TIME,
    PRIMARY KEY (race_id, driver_id)
);
--car_model зависит от car_manufacturer что бы это исправить это надо просто вынести в отдельную таблицу

--3
CREATE TABLE RoomBookings (
    booking_time DATETIME,
    room_name VARCHAR(100),
    event_name VARCHAR(255),
    event_type VARCHAR(50)
);
--event_type зависит от room_name это ошибка потому что создается избыточность информаци, нам придется каждый раз писать и тип 
--ивента и комнату, которые будут посторяться 
--что бы это исправить надо просто создать отдельную таблицу для комнат и типа мероприятий 

CREATE TABLE RoomBookings (
    booking_time DATETIME,
    event_name VARCHAR(255),
    event_type VARCHAR(50) FOREIGN KEY 
);

CREATE TABLE Event_room (
    room_name VARCHAR(100) NOT NULL,
    event_type VARCHAR(50) PRIMARY KEY
);








