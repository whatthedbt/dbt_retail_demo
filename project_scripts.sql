-- Departments Table
CREATE OR REPLACE TABLE retail_db.retail_schema.departments (
    department_id INT PRIMARY KEY,
    department_name STRING
);

-- Categories Table
CREATE OR REPLACE TABLE retail_db.retail_schema.categories (
    category_id INT PRIMARY KEY,
    department_id INT REFERENCES departments(department_id),
    category_name STRING
);

-- Products Table
CREATE OR REPLACE TABLE retail_db.retail_schema.products (
    product_id INT PRIMARY KEY,
    category_id INT REFERENCES categories(category_id),
    product_name STRING,
    price DECIMAL(10, 2)
);

-- Customers Table
CREATE OR REPLACE TABLE retail_db.retail_schema.customers (
    customer_id INT PRIMARY KEY,
    customer_name STRING,
    email STRING,
    state STRING
);

-- Orders Table
CREATE OR REPLACE TABLE retail_db.retail_schema.orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date TIMESTAMP,
    status STRING
);

-- Order Items Table (Transactional Grain)
CREATE OR REPLACE TABLE retail_db.retail_schema.order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price DECIMAL(10, 2)
);

INSERT INTO retail_db.retail_schema.departments (department_id, department_name)
VALUES
    (1, 'Electronics'), (2, 'Home & Kitchen'), (3, 'Apparel'), (4, 'Toys & Games');


INSERT INTO retail_db.retail_schema.categories (category_id, department_id, category_name)
VALUES
    (1, 1, 'Mobile Phones'), (2, 1, 'Laptops'), (3, 2, 'Appliances'),
    (4, 2, 'Furniture'), (5, 3, 'Menswear'), (6, 4, 'Board Games');

    INSERT INTO retail_db.retail_schema.products (product_id, category_id, product_name, price)
VALUES
    (1, 1, 'iPhone 15', 999.00), (2, 2, 'MacBook Air', 1200.00),
    (3, 3, 'Air Fryer', 89.99), (4, 4, 'Office Chair', 150.00),
    (5, 5, 'Cotton T-Shirt', 25.00), (6, 6, 'Catan', 45.00);

INSERT INTO retail_db.retail_schema.customers (customer_id, customer_name, email, state) VALUES
    (1, 'John Doe', 'john@example.com', 'NY'),
    (2, 'Jane Smith', 'jane@example.com', 'CA'),
    (3, 'Bob Johnson', 'bob@example.com', 'TX'),
    (4, 'Alice Brown', 'alice@example.com', 'FL');

    INSERT INTO retail_db.retail_schema.orders (order_id, customer_id, order_date, status)
VALUES
    (1, 1, '2023-10-01 10:00:00', 'COMPLETED'),
    (2, 2, '2023-10-02 11:30:00', 'SHIPPED'),
    (3, 1, '2023-10-03 14:15:00', 'PROCESSING'),
    (4, 4, '2023-10-05 09:00:00', 'COMPLETED');


    INSERT INTO retail_db.retail_schema.order_items (order_item_id, order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 1, 999.00), (2, 1, 5, 2, 25.00),
    (3, 2, 2, 1, 1200.00), (4, 3, 3, 1, 89.99),
    (5, 4, 6, 2, 45.00), (6, 4, 4, 1, 150.00);

INSERT INTO retail_db.retail_schema.departments (department_id, department_name)
VALUES
    (5, 'Sports & Outdoors'), (6, 'Beauty & Health'), (7, 'Books');


INSERT INTO retail_db.retail_schema.categories (category_id, department_id, category_name)
VALUES
    (7, 5, 'Fitness Equipment'), (8, 5, 'Camping Gear'), 
    (9, 6, 'Skincare'), (10, 7, 'Fiction');
INSERT INTO retail_db.retail_schema.products (product_id, category_id, product_name, price)
VALUES
    (7, 7, 'Yoga Mat', 30.00), (8, 8, 'Sleeping Bag', 75.00),
    (9, 9, 'Moisturizer', 45.00), (10, 10, 'Hardcover Novel', 22.50);

INSERT INTO retail_db.retail_schema.customers (customer_id, customer_name, email, state)
VALUES
    (5, 'Charlie Davis', 'charlie@example.com', 'WA'),
    (6, 'Diana Prince', 'diana@example.com', 'NJ'),
    (7, 'Ethan Hunt', 'ethan@example.com', 'IL'),
    (8, 'Fiona Apple', 'fiona@example.com', 'OR');

INSERT INTO retail_db.retail_schema.orders (order_id, customer_id, order_date, status)
VALUES
    (5, 5, '2023-11-12 18:00:00', 'SHIPPED'),
    (6, 3, '2023-11-02 13:00:00', 'CANCELLED'),
    (7, 1, '2023-11-29 22:00:00', 'COMPLETED'),
    (8, 2, '2023-11-10 01:00:00', 'PROCESSING'),
    (9, 8, '2023-11-23 08:00:00', 'PROCESSING'),
    (10, 2, '2023-11-20 06:00:00', 'COMPLETED');

INSERT INTO retail_db.retail_schema.order_items (order_item_id, order_id, product_id, quantity, unit_price)
VALUES
    (7, 9, 6, 1, 45.00), (8, 7, 5, 2, 25.00),
    (9, 3, 7, 1, 30.00), (10, 2, 5, 3, 25.00),
    (11, 9, 3, 1, 89.99), (12, 2, 1, 3, 999.00),
    (13, 3, 6, 1, 45.00), (14, 3, 1, 2, 999.00),
    (15, 5, 4, 3, 150.00);

    -- More Orders
INSERT INTO retail_db.retail_schema.orders (order_id, customer_id, order_date, status)
VALUES 
    (11, 9, '2023-12-01 10:00:00', 'COMPLETED'),
    (12, 10, '2023-12-02 11:30:00', 'PENDING'),
    (13, 11, '2023-12-03 14:15:00', 'RETURNED'),
    (14, 12, '2023-12-05 09:00:00', 'COMPLETED'),
    (15, 1, '2023-12-06 16:45:00', 'CANCELLED');

-- More Order Items
INSERT INTO retail_db.retail_schema.order_items (order_item_id, order_id, product_id, quantity, unit_price)
VALUES 
    (16, 11, 11, 4, 150.00), (17, 11, 12, 1, 85.00),
    (18, 12, 13, 5, 0.99), (19, 13, 14, 2, 5.50),
    (20, 14, 15, 1, 19.99), (21, 14, 1, 1, 999.00),
    (22, 15, 2, 1, 1200.00);

    -- More Products
INSERT INTO retail_db.retail_schema.products (product_id, category_id, product_name, price)
VALUES 
    (11, 11, 'All-Season Tire', 150.00), (12, 12, 'Dash Cam', 85.00),
    (13, 13, 'Organic Bananas', 0.99), (14, 14, 'Greek Yogurt', 5.50),
    (15, 1, 'Smartphone Case', 19.99);

-- More Customers
INSERT INTO retail_db.retail_schema.customers (customer_id, customer_name, email, state)
VALUES 
    (9, 'George Miller', 'george@example.com', 'TX'),
    (10, 'Hannah Abbot', 'hannah@example.com', 'CA'),
    (11, 'Ian Wright', 'ian@example.com', 'NY'),
    (12, 'Julia Roberts', 'julia@example.com', 'FL');

    -- More Departments
INSERT INTO retail_db.retail_schema.departments (department_id, department_name)
VALUES 
    (8, 'Automotive'), (9, 'Groceries');

-- More Categories
INSERT INTO retail_db.retail_schema.categories (category_id, department_id, category_name)
VALUES 
    (11, 8, 'Tires & Wheels'), (12, 8, 'Car Electronics'),
    (13, 9, 'Produce'), (14, 9, 'Dairy & Eggs');



insert into retail_db.retail_schema.customers(customer_id, customer_name,state) values(13,'Muhammad khan', 'NY');


create database dbt_retail;

truncate table retail_db.retail_schema.products;


