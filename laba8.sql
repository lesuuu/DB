CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers (customer_id, full_name, email, registration_date, recommended_by) VALUES
(1, 'Иван Иванов', 'ivan.ivanov@example.com', '2023-01-15', NULL),
(2, 'Мария Петрова', 'maria.petrova@example.com', '2023-02-20', 1),
(3, 'Алексей Смирнов', 'alex.smirnov@example.com', '2023-03-10', 1),
(4, 'Елена Васильева', 'elena.v@example.com', '2023-04-01', 2),
(5, 'Андрей Николаев', 'andrey.n@example.com', '2023-05-01', NULL);

INSERT INTO Products (product_name, category, price) VALUES
('Смартфон', 'Электроника', 70000.00),
('Ноутбук', 'Электроника', 120000.00),
('Кофемашина', 'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги', 1500.00),
('Фен', 'Бытовая техника', 4500.00),
('Пылесос', 'Бытовая техника', 15000.00);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-05-10', 'Доставлен'),
(2, '2024-05-12', 'В обработке'),
(1, '2024-05-15', 'Отправлен'),
(3, '2024-05-16', 'Доставлен');

INSERT INTO Order_Items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 70000.00),  -- Иван купил Смартфон
(1, 4, 2, 1400.00),   -- и 2 книги
(2, 2, 1, 120000.00), -- Мария купила Ноутбук
(3, 3, 1, 25000.00),  -- Иван купил Кофемашину
(4, 1, 1, 70000.00),  -- Алексей купил Смартфон
(4, 5, 1, 4500.00);

-- Практика 8 
-- 1
SELECT
    c.full_name,
    o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;
-- 2
SELECT
    c.full_name,
    o.order_id,
    o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
-- 3

SELECT p.product_name, oi.quantity, oi.price_per_unit FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.order_id = 1;
--4

SELECT full_name
FROM Customers 
WHERE customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    JOIN Order_items oi  ON o.order_id = oi.order_id
    JOIN Products p  ON oi.product_id = p.product_id
    WHERE p.product_name = 'Смартфон'
);
--5
SELECT product_name, price 
FROM products 
WHERE  price > (SELECT AVG(price) FROM Products);
 --6
 SELECT o.order_id
 from orders o
 WHERE EXISTS (
    SELECT 1
    from order_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE oi.order_id = o.order_id AND price > 100000 
 );
--7 1
SELECT full_name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
LEFT JOIN order_items oi  ON oi.order_id = o.order_id
LEFT JOIN products p ON p.product_id = oi.product_id AND p.product_name = 'Ноутбук'
WHERE p.product_id is NULL;
--7 2
SELECT full_name
FROM Customers c
WHERE customer_id NOT IN (
    SELECT o.customer_id
    FROM Orders o
    JOIN Order_items oi  ON o.order_id = oi.order_id
    JOIN Products p  ON oi.product_id = p.product_id
    WHERE p.product_name = 'Ноутбук'
);
--8
SELECT p.product_name
FROM order_items oi
RIGHT JOIN products p ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;
--9
SELECT c.full_name, p.product_name, oi.quantity
FROM customers c
FULL OUTER JOIN orders o ON o.customer_id = c.customer_id
FULL OUTER JOIN order_items oi  ON oi.order_id = o.order_id
FULL OUTER JOIN products p ON p.product_id = oi.product_id;
--10
SELECT c.full_name
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi  ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE p.price = (SELECT MAX(price) FROM Products);
--11
SELECT c.full_name, p.category 
FROM customers c
CROSS JOIN (
SELECT category
FROM products ) p;

--12
--Используя `SELF JOIN` на таблице `Customers`, выведите список покупателей и тех, 
--кто их порекомендовал. Результат должен содержать два столбца: `new_customer` (имя нового покупателя) и `recommended_by`
-- (имя того, кто его порекомендовал).
SELECT 
   niw.full_name as niw_customer,
   rec.full_name as recommended_by
from customers niw 
JOIN customers rec on niw.recommended_by = rec.customer_id;
