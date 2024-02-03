-- challenge karaoke song selector

CREATE TABLE songs (
    id INTEGER PRIMARY KEY,
    title TEXT,
    artist TEXT,
    mood TEXT,
    duration INTEGER,
    released INTEGER);
    
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Bohemian Rhapsody", "Queen", "epic", 60, 1975);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Let it go", "Idina Menzel", "epic", 227, 2013);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("I will survive", "Gloria Gaynor", "epic", 198, 1978);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Twist and Shout", "The Beatles", "happy", 152, 1963);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("La Bamba", "Ritchie Valens", "happy", 166, 1958);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("I will always love you", "Whitney Houston", "epic", 273, 1992);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Sweet Caroline", "Neil Diamond", "happy", 201, 1969);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Call me maybe", "Carly Rae Jepsen", "happy", 193, 2011);

--ex
SELECT title FROM songs;

SELECT title FROM songs WHERE mood = 'epic' OR released > 1990;

SELECT title
FROM songs
WHERE mood = 'epic' AND released > 1990 AND duration < 240;


-- challenge playlist maker

CREATE TABLE artists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    country TEXT,
    genre TEXT);

INSERT INTO artists (name, country, genre)
    VALUES ("Taylor Swift", "US", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Led Zeppelin", "US", "Hard rock");
INSERT INTO artists (name, country, genre)
    VALUES ("ABBA", "Sweden", "Disco");
INSERT INTO artists (name, country, genre)
    VALUES ("Queen", "UK", "Rock");
INSERT INTO artists (name, country, genre)
    VALUES ("Celine Dion", "Canada", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Meatloaf", "US", "Hard rock");
INSERT INTO artists (name, country, genre)
    VALUES ("Garth Brooks", "US", "Country");
INSERT INTO artists (name, country, genre)
    VALUES ("Shania Twain", "Canada", "Country");
INSERT INTO artists (name, country, genre)
    VALUES ("Rihanna", "US", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Guns N' Roses", "US", "Hard rock");
INSERT INTO artists (name, country, genre)
    VALUES ("Gloria Estefan", "US", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Bob Marley", "Jamaica", "Reggae");

CREATE TABLE songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    artist TEXT,
    title TEXT);

INSERT INTO songs (artist, title)
    VALUES ("Taylor Swift", "Shake it off");
INSERT INTO songs (artist, title)
    VALUES ("Rihanna", "Stay");
INSERT INTO songs (artist, title)
    VALUES ("Celine Dion", "My heart will go on");
INSERT INTO songs (artist, title)
    VALUES ("Celine Dion", "A new day has come");
INSERT INTO songs (artist, title)
    VALUES ("Shania Twain", "Party for two");
INSERT INTO songs (artist, title)
    VALUES ("Gloria Estefan", "Conga");
INSERT INTO songs (artist, title)
    VALUES ("Led Zeppelin", "Stairway to heaven");
INSERT INTO songs (artist, title)
    VALUES ("ABBA", "Mamma mia");
INSERT INTO songs (artist, title)
    VALUES ("Queen", "Bicycle Race");
INSERT INTO songs (artist, title)
    VALUES ("Queen", "Bohemian Rhapsody");
INSERT INTO songs (artist, title)
    VALUES ("Guns N' Roses", "Don't cry");
    
SELECT title FROM songs WHERE artist = "Queen";

SELECT name
FROM artists
WHERE genre="Pop";

SELECT title FROM songs
WHERE artist IN (
    SELECT name
    FROM artists
    WHERE genre="Pop"
);



--challenge : the wordiest author

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    author TEXT,
    title TEXT,
    words INTEGER);

--author with total words above 1 million
SELECT author, SUM(words) AS total_words
FROM books
GROUP BY author
HAVING total_words > 1000000;


--author with average words per work > 150 thousand
SELECT author, AVG(words) AS avg_words
FROM books
GROUP BY author
HAVING avg_words > 150000;


--challenge gradebook

CREATE TABLE student_grades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    number_grade INTEGER,
    fraction_completed REAL);


SELECT name, number_grade, ROUND(100*fraction_completed) AS percent_completed
FROM student_grades;

--number of student per grade
SELECT COUNT(*), 
CASE 
    WHEN ROUND(100*fraction_completed) > 90 THEN 'A' 
    WHEN ROUND(100*fraction_completed) > 80 THEN 'B' 
    WHEN ROUND(100*fraction_completed) > 70 THEN 'C'
    ELSE 'F' 
END AS "letter_grade"
FROM student_grades
GROUP BY "letter_grade";


--project data dig

CREATE TABLE pokemon(
  Number     INTEGER,
  Name       TEXT PRIMARY KEY,
  Type_1     TEXT,
  Type_2     TEXT,
  Total      INTEGER,
  HP         INTEGER,
  Attack     INTEGER,
  Defense    INTEGER,
  Sp_Atk     INTEGER,
  Sp_Def     INTEGER,
  Speed      INTEGER,
  Generation INTEGER,
  Legendary  TEXT
);

SELECT name, MAX(HP) FROM pokemon;

SELECT COUNT(*) FROM pokemon WHERE Legendary = 'True';

-- generation having more than 10 lmegendaries pk
SELECT generation,COUNT(*) AS nb_legandary
FROM pokemon 
WHERE Legendary = 'True'
GROUP BY generation
HAVING nb_legandary > 10;

SELECT generation,COUNT(*) AS nb_legendary
FROM pokemon 
WHERE Legendary = 'True'
GROUP BY generation
ORDER BY nb_legendary;

--select pokemon of gen 4 where therir attack is in range of the attack of gen 3 pokemon of type Water
SELECT name, Attack
FROM pokemon
WHERE Attack BETWEEN
(SELECT MIN(Attack) FROM pokemon WHERE generation = 3 AND (Type_1 = 'Water' OR Type_2 = 'Water'  ))
 AND
 (SELECT MAX(Attack) FROM pokemon WHERE generation = 3 AND (Type_1 = 'Water' OR Type_2 = 'Water'  ));
 AND generation = 4;


SELECT name, MAX(Attack) FROM pokemon; --190
SELECT name, AVG(Attack) FROM pokemon; -- 79

SELECT COUNT(*), 
CASE 
    WHEN Attack > ROUND(0.9*190) THEN 'A' 
    WHEN Attack > ROUND(0.7*190) THEN 'B' 
    WHEN Attack > ROUND(0.5*190) THEN 'C'
    WHEN Attack > (SELECT name, AVG(Attack) FROM pokemon) THEN 'D'
    ELSE 'F' 
END AS "attack_grade"
FROM pokemon
GROUP BY "attack_grade";




INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (1,'Bulbasaur','Grass','Poison',318,45,49,49,65,65,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (2,'Ivysaur','Grass','Poison',405,60,62,63,80,80,60,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (3,'Venusaur','Grass','Poison',525,80,82,83,100,100,80,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (3,'VenusaurMega Venusaur','Grass','Poison',625,80,100,123,122,120,80,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (4,'Charmander','Fire',NULL,309,39,52,43,60,50,65,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (5,'Charmeleon','Fire',NULL,405,58,64,58,80,65,80,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (6,'Charizard','Fire','Flying',534,78,84,78,109,85,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (6,'CharizardMega Charizard X','Fire','Dragon',634,78,130,111,130,85,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (6,'CharizardMega Charizard Y','Fire','Flying',634,78,104,78,159,115,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (7,'Squirtle','Water',NULL,314,44,48,65,50,64,43,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (8,'Wartortle','Water',NULL,405,59,63,80,65,80,58,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (9,'Blastoise','Water',NULL,530,79,83,100,85,105,78,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (9,'BlastoiseMega Blastoise','Water',NULL,630,79,103,120,135,115,78,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (10,'Caterpie','Bug',NULL,195,45,30,35,20,20,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (11,'Metapod','Bug',NULL,205,50,20,55,25,25,30,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (12,'Butterfree','Bug','Flying',395,60,45,50,90,80,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (13,'Weedle','Bug','Poison',195,40,35,30,20,20,50,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (14,'Kakuna','Bug','Poison',205,45,25,50,25,25,35,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (15,'Beedrill','Bug','Poison',395,65,90,40,45,80,75,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (15,'BeedrillMega Beedrill','Bug','Poison',495,65,150,40,15,80,145,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (16,'Pidgey','Normal','Flying',251,40,45,40,35,35,56,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (17,'Pidgeotto','Normal','Flying',349,63,60,55,50,50,71,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (18,'Pidgeot','Normal','Flying',479,83,80,75,70,70,101,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (18,'PidgeotMega Pidgeot','Normal','Flying',579,83,80,80,135,80,121,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (19,'Rattata','Normal',NULL,253,30,56,35,25,35,72,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (20,'Raticate','Normal',NULL,413,55,81,60,50,70,97,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (21,'Spearow','Normal','Flying',262,40,60,30,31,31,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (22,'Fearow','Normal','Flying',442,65,90,65,61,61,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (23,'Ekans','Poison',NULL,288,35,60,44,40,54,55,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (24,'Arbok','Poison',NULL,438,60,85,69,65,79,80,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (25,'Pikachu','Electric',NULL,320,35,55,40,50,50,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (26,'Raichu','Electric',NULL,485,60,90,55,90,80,110,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (27,'Sandshrew','Ground',NULL,300,50,75,85,20,30,40,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (28,'Sandslash','Ground',NULL,450,75,100,110,45,55,65,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (29,'Nidoran♀','Poison',NULL,275,55,47,52,40,40,41,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (30,'Nidorina','Poison',NULL,365,70,62,67,55,55,56,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (31,'Nidoqueen','Poison','Ground',505,90,92,87,75,85,76,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (32,'Nidoran♂','Poison',NULL,273,46,57,40,40,40,50,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (33,'Nidorino','Poison',NULL,365,61,72,57,55,55,65,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (34,'Nidoking','Poison','Ground',505,81,102,77,85,75,85,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (35,'Clefairy','Fairy',NULL,323,70,45,48,60,65,35,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (36,'Clefable','Fairy',NULL,483,95,70,73,95,90,60,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (37,'Vulpix','Fire',NULL,299,38,41,40,50,65,65,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (38,'Ninetales','Fire',NULL,505,73,76,75,81,100,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (39,'Jigglypuff','Normal','Fairy',270,115,45,20,45,25,20,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (40,'Wigglytuff','Normal','Fairy',435,140,70,45,85,50,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (41,'Zubat','Poison','Flying',245,40,45,35,30,40,55,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (42,'Golbat','Poison','Flying',455,75,80,70,65,75,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (43,'Oddish','Grass','Poison',320,45,50,55,75,65,30,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (44,'Gloom','Grass','Poison',395,60,65,70,85,75,40,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (45,'Vileplume','Grass','Poison',490,75,80,85,110,90,50,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (46,'Paras','Bug','Grass',285,35,70,55,45,55,25,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (47,'Parasect','Bug','Grass',405,60,95,80,60,80,30,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (48,'Venonat','Bug','Poison',305,60,55,50,40,55,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (49,'Venomoth','Bug','Poison',450,70,65,60,90,75,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (50,'Diglett','Ground',NULL,265,10,55,25,35,45,95,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (51,'Dugtrio','Ground',NULL,405,35,80,50,50,70,120,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (52,'Meowth','Normal',NULL,290,40,45,35,40,40,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (53,'Persian','Normal',NULL,440,65,70,60,65,65,115,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (54,'Psyduck','Water',NULL,320,50,52,48,65,50,55,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (55,'Golduck','Water',NULL,500,80,82,78,95,80,85,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (56,'Mankey','Fighting',NULL,305,40,80,35,35,45,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (57,'Primeape','Fighting',NULL,455,65,105,60,60,70,95,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (58,'Growlithe','Fire',NULL,350,55,70,45,70,50,60,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (59,'Arcanine','Fire',NULL,555,90,110,80,100,80,95,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (60,'Poliwag','Water',NULL,300,40,50,40,40,40,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (61,'Poliwhirl','Water',NULL,385,65,65,65,50,50,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (62,'Poliwrath','Water','Fighting',510,90,95,95,70,90,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (63,'Abra','Psychic',NULL,310,25,20,15,105,55,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (64,'Kadabra','Psychic',NULL,400,40,35,30,120,70,105,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (65,'Alakazam','Psychic',NULL,500,55,50,45,135,95,120,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (65,'AlakazamMega Alakazam','Psychic',NULL,590,55,50,65,175,95,150,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (66,'Machop','Fighting',NULL,305,70,80,50,35,35,35,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (67,'Machoke','Fighting',NULL,405,80,100,70,50,60,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (68,'Machamp','Fighting',NULL,505,90,130,80,65,85,55,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (69,'Bellsprout','Grass','Poison',300,50,75,35,70,30,40,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (70,'Weepinbell','Grass','Poison',390,65,90,50,85,45,55,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (71,'Victreebel','Grass','Poison',490,80,105,65,100,70,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (72,'Tentacool','Water','Poison',335,40,40,35,50,100,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (73,'Tentacruel','Water','Poison',515,80,70,65,80,120,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (74,'Geodude','Rock','Ground',300,40,80,100,30,30,20,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (75,'Graveler','Rock','Ground',390,55,95,115,45,45,35,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (76,'Golem','Rock','Ground',495,80,120,130,55,65,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (77,'Ponyta','Fire',NULL,410,50,85,55,65,65,90,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (78,'Rapidash','Fire',NULL,500,65,100,70,80,80,105,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (79,'Slowpoke','Water','Psychic',315,90,65,65,40,40,15,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (80,'Slowbro','Water','Psychic',490,95,75,110,100,80,30,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (80,'SlowbroMega Slowbro','Water','Psychic',590,95,75,180,130,80,30,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (81,'Magnemite','Electric','Steel',325,25,35,70,95,55,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (82,'Magneton','Electric','Steel',465,50,60,95,120,70,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (83,'Farfetch''d','Normal','Flying',352,52,65,55,58,62,60,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (84,'Doduo','Normal','Flying',310,35,85,45,35,35,75,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (85,'Dodrio','Normal','Flying',460,60,110,70,60,60,100,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (86,'Seel','Water',NULL,325,65,45,55,45,70,45,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (87,'Dewgong','Water','Ice',475,90,70,80,70,95,70,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (88,'Grimer','Poison',NULL,325,80,80,50,40,50,25,1,'False');
INSERT INTO pokemon(Number,Name,Type_1,Type_2,Total,HP,Attack,Defense,Sp_Atk,Sp_Def,Speed,Generation,Legendary) VALUES (89,'Muk','Poison',NULL,500,105,105,75,65,100,50,1,'False');
