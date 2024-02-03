--challeng dynamic documents

CREATE table documents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    content TEXT,
    author TEXT);

UPDATE documents SET author = 'Jackie Draper' WHERE author = 'Jackie Paper';
DELETE FROM documents WHERE title = "Things I'm Afraid Of";
SELECT * FROM documents;


--challenge clothing alterations

CREATE TABLE clothes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT,
    design TEXT);
    
INSERT INTO clothes (type, design)
    VALUES ("dress", "pink polka dots");
INSERT INTO clothes (type, design)
    VALUES ("pants", "rainbow tie-dye");
INSERT INTO clothes (type, design)
    VALUES ("blazer", "black sequin");

ALTER TABLE clothes ADD price INTEGER;
SELECT * FROM clothes;

UPDATE clothes SET price = id*10;
SELECT * FROM clothes;

INSERT INTO clothes(type,design,price) VALUES ("shirt","plain brown",23);
SELECT * FROM clothes;



--project App impersonator

CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    zip_code TEXT,
    phone_number TEXT,
    password INTEGER NOT NULL,
    points INTEGER DEFAULT 0,
);


INSERT INTO users(first_name, last_name, zip_code, phone_number, password,points) VALUES
("Luis","Guardamagna","1000","0485963214","8745",12),
("Zacharia","Acherki","1000","0495963214","8745",142),
("Morgane","Van bets","1000","0481963214","8745",1),
("Audrey","Joachim","1000","0485958214","8745",0),
("Maelle","Berthet","1052","0485961414","8745",54),
("LLouis","Fitdevole","9874","0485963214","8745",458),
("Victor","Firkowski","1080","0465683214","8745",36),
("Luis","Guardamagna","3600","0485813214","8745",0);

SELECT * FROM users;
UPDATE users SET zip_code = "1090" WHERE phone_number = "0465683214";
SELECT * FROM users;
DELETE FROM users WHERE id = 8; 
SELECT * FROM users;
