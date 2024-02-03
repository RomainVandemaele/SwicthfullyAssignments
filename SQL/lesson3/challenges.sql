--challenge Bobby's hobbies

CREATE TABLE persons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER);

CREATE table hobbies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    name TEXT);


INSERT INTO persons (name, age) VALUES ("Fizzy Mococo", 28);
INSERT INTO hobbies (person_id, name) VALUES (5, "bau bau");

SELECT P.name, H.name
FROM persons P JOIN  hobbies H  ON P.id = H.person_id;

SELECT P.name, H.name
FROM persons P JOIN  hobbies H  ON P.id = H.person_id
WHERE P.name = 'Bobby McBobbyFace';

--challenge Customer's orders

CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    item TEXT,
    price REAL);


SELECT C.name, C.email, O.item, O.price
FROM customers C LEFT OUTER JOIN orders O ON C.id = O.customer_id;


SELECT C.name, C.email, SUM(O.price) AS total
FROM customers C LEFT OUTER JOIN orders O ON C.id = O.customer_id
GROUP BY C.name
ORDER BY total DESC; 

--challenge Sequels in SQL

CREATE TABLE movies (id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    released INTEGER,
    sequel_id INTEGER);

SELECT m.title, s.title
FROM movies m LEFT OUTER JOIN movies s ON m.sequel_id = s.id;

--challenge FrienBook

CREATE TABLE persons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullname TEXT,
    age INTEGER);

CREATE table hobbies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    name TEXT);

CREATE table friends (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person1_id INTEGER,
    person2_id INTEGER);


SELECT p.fullname, h.name
FROM persons p JOIN hobbies h ON p.id = h.person_id;

SELECT p1.fullname, p2.fullname
FROM friends f
JOIN persons p1 ON f.person1_id = p1.id 
JOIN persons p2 ON f.person2_id = p2.id;

--project Famous people 

CREATE TABLE movie_stars (
    star_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullname TEXT,
    age INTEGER,
    spouse_id INTEGER
);

INSERT INTO movie_stars(fullname,age,spouse_id) VALUES
("Brad Pitt",45,2), 
("Angelina Jolie",42,1),
("Chris Pratt",49,NULL),
("Leonardo Dicaprio",37,NULL);

CREATE TABLE movies (
    movie_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    release_year INTEGER,
    star_id1 INTEGER,
    star_id2 INTEGER
);

INSERT INTO movies(name,release_year,star_id1,star_id2) VALUES  
("Mr. and Mrs Smith",2005,1,2),
("Gardian of the galaxy",2014,3,NULL),
("Catch me if you can",2002,4,NULL);

--couples
SELECT s1.fullname, s2.fullname
FROM movie_stars s1 JOIN movie_stars s2 ON s1.spouse_id = s2.star_id;

--couples and movies where they play together
SELECT s1.fullname, s2.fullname, m.title
FROM movie_stars s1 
JOIN movie_stars s2 ON s1.spouse_id = s2.star_id
JOIN movies m ON (m.star_id1 = s1.star_id AND m.star_id2 = s2.star_id) OR (m.star_id1 = s2.star_id AND m.star_id2 = s1.star_id);


