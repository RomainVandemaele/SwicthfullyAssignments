
--Challenge book list DB
CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    name TEXT,
    rating REAL

);

INSERT INTO books VALUES (1,"HP 1",4.5);
INSERT INTO books VALUES (2,"Butterfly",1.2);
INSERT INTO books VALUES (3,"HP 6",4.8);


--challenge box office hits database

CREATE TABLE movies (id INTEGER PRIMARY KEY, name TEXT, release_year INTEGER);
INSERT INTO movies VALUES (1, "Avatar", 2009);
INSERT INTO movies VALUES (2, "Titanic", 1997);
INSERT INTO movies VALUES (3, "Star Wars: Episode IV - A New Hope", 1977);
INSERT INTO movies VALUES (4, "Shrek 2", 2004);
INSERT INTO movies VALUES (5, "The Lion King", 1994);
INSERT INTO movies VALUES (6, "Disney's Up", 2009);

--selct all movies
SELECT * FROM movies;
--the movies that were released in the year 2000 or later, not before. Sort the results so that the earlier movies are listed first
SELECT *
FROM movies
WHERE release_year >=2000
ORDER BY release_year;

--First GROUP BY then AGGREGATE(ex SUM) then SELECT
--same select as in group by

--challenge TODO list DB stats

CREATE TABLE todo_list (id INTEGER PRIMARY KEY, item TEXT, minutes INTEGER);
INSERT INTO todo_list VALUES (1, "Wash the dishes", 15);
INSERT INTO todo_list VALUES (2, "vacuuming", 20);
INSERT INTO todo_list VALUES (3, "Learn some stuff on KA", 30);
--added a todo
INSERT INTO todo_list VALUES (4, "Take a shower", 20);
--total timle to finish
SELECT SUM(minutes) FROM todo_list;

--project Design store DB

--Create your own store! Your store should sell one type of things, like clothing or bikes, whatever you want your store to specialize in.
-- You should have a table for all the items in your store, and at least 5 columns for the kind of data you think you'd need to store. 
--You should sell at least 15 items, and use select statements to order your items by price and show at least one statistic about the items. 

CREATE TABLE bikes (
    id INTEGER PRIMARY KEY,
    brand TEXT,
    model TEXT,
    material TEXT,
    motor NUMERIC,
    price REAL,
);


INSERT INTO bikes(id,brand,model,material,motor,price) 
VALUES 
    (1,"canyon","CF SLX 8.0","CD",0,4120.50),
    (2,"canyon","roadlite 4","AL",0,699.0),
    (3,"canyon","roadlite:on 5","AL",1,2889),
    (4,"orbea","AVANT H40-D","AL",0,1119.2),
    (5,"orbea","AVANT H10","AL",0,847.25),
    (6,"scott","Contessa Speedster 25","CF",0,2489.6),
    (7,"scott","Contessa Speedster 15","AL",0,1119.2),
    (8,"BMC","Teammachine ALR Disc TWO","AL",0,1499.4),
    (9,"BMC","Teammachine SLR Five","AL",0,2879.50),
    (10,"BMC","Roadmachine 01 Five","CF",0,4319.50),
    (11,"cube","Attain SLX","AL",0,1669.0),
    (12,"cube","Agree C:62 Pro","CF",0,3349.4),
    (13,"BMC","Roadmachine AMP THREE","CF",1,3599.50),
    (14,"orbea","Gain D30i","AL",1,4499.50),
    (15,"scott","Addict eRide 20","CF",1,4899.50);


SELECT AVG(price)
FROM bikes
WHERE material="CF";

SELECT brand,AVG(price) AS avg
FROM bikes
GROUP BY price
ORDER BY avg;

SELECT material,AVG(price)
FROM bikes
WHERE motor = 1
GROUP BY material
ORDER BY price;



