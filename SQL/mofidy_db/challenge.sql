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



--project App impersonator