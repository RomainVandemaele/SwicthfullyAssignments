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

