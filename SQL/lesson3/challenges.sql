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


--challenge Sequels in SQL

--challenge FrienBook


--project Famous people
