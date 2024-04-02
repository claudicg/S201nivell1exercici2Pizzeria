DROP DATABASE IF EXISTS pizzeria;

CREATE DATABASE pizzeria CHARACTER SET utf8mb4;

USE pizzeria;

CREATE TABLE provinces	(
	province_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    province_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE cities	(
	city_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    city_name VARCHAR(50) UNIQUE NOT NULL,
    province_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (province_id) REFERENCES provinces(province_id)
);


CREATE TABLE stores	(
	store_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY ,
    store_name VARCHAR(50) NOT NULL,
    road_type ENUM('Street', 'Avenue', 'Square') NOT NULL,
    road_name VARCHAR(50) NOT NULL,
    road_number INT UNSIGNED NOT NULL,
    postcode INT NOT NULL,
    telephone INT NOT NULL,
    city_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE employees	(
	employee_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    employee_lastname VARCHAR(50) NOT NULL,
    documentId VARCHAR(20) NOT NULL,
    telephone INT NOT NULL,
    job ENUM('Delivery', 'Cook') NOT NULL,
    store_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE customers	(
	customer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	customer_name VARCHAR(50) NOT NULL,
    customer_lastname VARCHAR(50) NOT NULL,
    road_type VARCHAR(50) NOT NULL,
    road_name VARCHAR(50) NOT NULL,
    road_number INT UNSIGNED NOT NULL,
    floor INT NOT NULL,
    door VARCHAR(6) NOT NULL,
    postcode INT NOT NULL,
	telephone INT UNSIGNED UNIQUE NOT NULL,
    city_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE products	(
	product_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_name VARCHAR(50) UNIQUE NOT NULL,
    product_type ENUM('Pizza', 'Burger', 'Drink') NOT NULL,
	product_description VARCHAR(255) NOT NULL,
    image VARCHAR(50) NOT NULL,
    unit_price FLOAT NOT NULL
);

CREATE TABLE pizza_categories		(
	pizza_category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	pizza_category ENUM('Vegetarian', 'Not Vegetarian', '----') NOT NULL
);

CREATE TABLE orders	(
	order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    store_id INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED NOT NULL,
    order_type ENUM('Pick-Up', 'Delivery') NOT NULL,
    order_time TIMESTAMP NOT NULL,
    total_amount FLOAT NOT NULL,
    delivery_person_id INT UNSIGNED NOT NULL,
    delivery_time TIMESTAMP NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (delivery_person_id) REFERENCES employees(employee_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE ordered_products	(
	ordered_product_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY ,
	order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    pizza_category_id INT UNSIGNED NOT NULL, 
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (pizza_category_id) REFERENCES pizza_categories(pizza_category_id)
);

/* provinces */

INSERT INTO provinces(province_name) VALUES ('Barcelona');

/* cities */

INSERT INTO cities(city_name, province_id) VALUES ('Badalona', 1);

/* store */

INSERT INTO stores(store_name, road_type, road_name, road_number, postcode, telephone, city_id)
VALUES ('Pizzas and American Burgers', 'Street', 'Major', 25, 08912, 645783219, 1);

/* Employees */

INSERT INTO employees(employee_name, employee_lastname, documentId, telephone, job, store_id)
VALUES ('Carlos', 'Corredor', '54854246R', 695287465, 'Cook', 1);
INSERT INTO employees(employee_name, employee_lastname, documentId, telephone, job, store_id)
VALUES ('Jordi', 'Labrador', '52678123S', 607392745, 'Delivery', 1);

/* Customer */

INSERT INTO customers(customer_name, customer_lastname, road_type, road_name, road_number, floor, door, postcode, telephone, city_id)
VALUES ('Josep', 'Corredor', 'Square', 'de la Plana', 7, 2, '1', 08912, 607863559, 1);
INSERT INTO customers(customer_name, customer_lastname, road_type, road_name, road_number, floor, door, postcode, telephone, city_id)
VALUES ('Oriol', 'Serra', 'Street', 'del Mar', 34, 1, 'A', 08912, 669432897, 1);
INSERT INTO customers(customer_name, customer_lastname, road_type, road_name, road_number, floor, door, postcode, telephone, city_id)
VALUES ('Carmen', 'Gallego', 'Street', 'Major', 65, 3, '2C', 08912, 645297845, 1);

/* Products */

INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Pizza Margarita', 'Pizza', 'Tomato sauce, mozzarella and basil', 'C:\users\pizzeria\Pictures\Pizza Margarita.jpg', 9.50);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Pizza Ham and cheese', 'Pizza', 'Tomato sauce, mozzarella and ham' , 'C:\users\pizzeria\Pictures\Pizza Ham&Cheese.jpg', 10.50);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Pizza four cheeses', 'Pizza', 'Tomato sauce, mozzarella, emmental, blue cheese, and goat cheese', 'C:\users\pizzeria\Pictures\Pizza 4Cheese.jpg', 11.50);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Classic Burger', 'Burger', 'Beef meat, cheese, bacon, onion, tomato, lettuce, pickles', 'C:\users\pizzeria\Pictures\BurgerCL.jpg', 12.50);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Double Cheese & bacon burger', 'Burger', 'Classic burger whith double cheese & bacon ', 'C:\users\pizzeria\Pictures\BurgerDOUBLE.jpg', 14);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Water 50 cl.', 'Drink', 'Bottle', 'C:\users\pizzeria\Pictures\water.jpg', 1.50);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Coke 33 cl.', 'Drink', 'Can', 'C:\users\pizzeria\Pictures\Coke.jpg', 2.50);
INSERT INTO products(product_name, product_type, product_description, image, unit_price)
VALUES ('Beer 33 cl.', 'Drink', 'Can', 'C:\users\pizzeria\Pictures\Beer.jpg', 3);

/* pizza_categories */

INSERT INTO pizza_categories(pizza_category) VALUES ('Vegetarian');
INSERT INTO pizza_categories(pizza_category) VALUES ('Not Vegetarian');
INSERT INTO pizza_categories(pizza_category) VALUES ('----');

/* orders */

INSERT INTO orders( store_id ,customer_id , order_type, order_time , total_amount, delivery_person_id , delivery_time )
VALUES (1, 1, 'Delivery', '2024-03-14 20:30:15', 25.50, 2, '2024-03-14 21:05:30');
INSERT INTO orders( store_id ,customer_id , order_type, order_time , total_amount, delivery_person_id , delivery_time )
VALUES (1, 2, 'Delivery', '2024-03-14 20:50:30', 30,50, 2, '2024-03-14 21:25:00');
INSERT INTO orders( store_id ,customer_id , order_type, order_time , total_amount, delivery_person_id , delivery_time )
VALUES (1, 3, 'Delivery', '2024-03-14 21:24:00', 68,5 , 2, '2024-03-14 22:01:30');


/* ordered_products */

INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (1, 1, 1, 2);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (1, 2, 2, 2);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (1, 7, 3, 2);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (1, 8, 3, 2);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (2, 4, 3, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (2, 5, 3, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (2, 7, 3, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (2, 6, 3, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (3, 1, 1, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (3, 2, 2, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (3, 4, 3, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (3, 5, 3, 1);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (3, 7, 3, 4);
INSERT INTO ordered_products(order_id, product_id, pizza_category_id , quantity) VALUES (3, 8, 3, 4);

/* queries */

SELECT SUM(orpr.quantity) AS Drinks_Sales
FROM ordered_products orpr, products pr, orders od, stores st, cities c
WHERE pr.product_type = 'Drink'
AND c.city_id = 1
AND pr.product_id = orpr.product_id
AND orpr.order_id = od.order_id
AND od.store_id = st.store_id
AND st.store_id = c.city_id;

SELECT COUNT(order_id) AS orders_delivered
FROM orders od, employees e
WHERE od.delivery_person_id = 2
AND od.delivery_person_id = e.employee_id;
 