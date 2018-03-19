/*
									in_class

\dt to show all thr tables in database
\c to go in  a database from special user (every user can have few database
\l show all databases
\d+ to show all table with attributes


in_class1=# create table student(
in_class1(# personnmr char(10),
in_class1(# name varchar,
in_class1(# birthdat DATE,
in_class1(# PRImARY KEY (personnmr));
CREATE TABLE


in_class1=# create table enrollment(
in_class1(# id integer primary key,
in_class1(# coursename varchar UNIQUE,
in_class1(# student char(10),
in_class1(# foreign key (student) references student(personnmr) on delete cascade);  //when deleting student delete also enrollment connected to that student


Generic key constraint UNIQUE(ATTS)
PK constraints PRIMARY KEY(afdsgd,sdfadgs)
FK constraints FOREIGN KEY(dsafas,asdasdf)dsafas references sadffa(fsdfa);

UNION
EXCEPT
INTERSECT
ALL 
IN  (IS LIKE LOOP)
ANY
DISTINCT
ORDER BY
WITH
HAVING
WITH AS

AGGREGATE FUNCTIONS:
COUNT, SUM, MAX, MIN, AVG

desc from highes to lowest





											BASIC SQL

*/
/*
 *Learned from
 *https://www.youtube.com/watch?v=7Vtl2WggqOg&t=1552s
 *AUTHER Sarkis George Sarkisan
 *Created on 15/01/2018
*/


--<to create a table>
CREATE TABLE gorceries (id INTEGER PRIMARY KEY, name TEXT , quantity INTEGER , Aisle INTEGER);

--to insert values in table
INSERT INTO groceries VALUES (1, "Bananas",4,7);
INSERT INTO groceries VALUES (2, "Peanut Butter" , 1 ,2);
INSERT INTO groceries VALUES (3, "Dark Chocolate Bars", 2  ,2);
INSERT INTO groceries VALUES (4, "Ice Cream" , 1 , 12);
INSERT INTO groceries VALUEs (5, "Cherries" , 6 , 2);
INSERT INTO groceries VVALUES (6, "CHoclate sytup" , 1, 4);

//to get an table base on names
SELECT name FROM groceries;

--to get all table information
SELECT * FROM groceries;

--to order an list base on specific colome
SELECT * FROM groceries ORDER BY aisle;

--to get items in specific colome in bigger than number
SELECT * FROM groceries WHERE aisle > 5 ORDER BY aisle:

-- to get the sum of specific colome
SELECT SUM(quantity) FROM groceries;

--to get the biggest number
SELECY MAX(quantity) FROM groceries;

--to get the sum of items in specifit colome and order it on specific colome
SELECT SUM(quantity) FROM groceries GROUP BY aisle; // this will give out only number of items in aisle witour thelling us wich aisle is wich

--to get the sum of items in specifit colome and give that colome and order it on specific colome
SELECT aisle , SUM(quantity) FROM groceries GROUP BY aisle;


--to create table 
CREATE TABLE exercise (id INTEFET PRIMARY KEY AUTOINCREMENT, type TEXT , minutes INTEGER, calores INTEGER, heart-rate INTEGER);

--to insert data in table 
-- another form of inserting values this will not specifie id inseted id will be autoincremented on it's own 
-- in case using old format we have to specify everything
INSERT INTO exercise (type, minutes, calories, heart_rate)VALUES("biking", 30,100,110);

INSERT INTO exercise  (type, minutes, calories, heart_rate)VALUES("biking",10,30,105);

INSERT INTO exercise  (type, minutes, calories, heart_rate) VALUES("dancing", 15,200,120);
INSERT INTO exercise  (type, minutes, calories, heart_rate) VALUES("tree climbing", 30,70,90);

INSERT INTO exercise  (type, minutes, calories, heart_rate) VALUES("tree climbing", 25,72,80);

INSERT INTO exercise  (type, minutes, calories, heart_rate) VALUES("rowing", 30,70,90);

INSERT INTO exercise  (type, minutes, calories, heart_rate) VALUES("hiking", 60,80,85);

--to get the table only with calories more than 50
-- and order them base on calories
SELECT * FROM exercise 	WHERE calories > 50 
			ORDER BY calories;

--to get the table calories biger than 50 and min bigger than 30 and order them base on id number
SELECT * FROM exercise 	WHERE calories > 50 
			AND minutes < 30 
			ORDER BY id;

--to get the table calories bigger then 50 or heart_rate bigger thna 100 and order by minutes
SELECT * FROM exercise 	WHERE calories > 50 
			OR heart_rate > 100 
			order by minutes;

--to get only outdoor ectivities there is 2 ways
-- FIRST
SELECT * FROM exercise 	WHERE type = "biking" 
			OR type = "hiking" 
			OR type = "tree climbing" 
			OR type = "rowing";
-- SECOND using *IN*
SELECT * FROM exercise 	WHERE type IN ("biking" , "hiking" , "tree climbing", "rowing");

-- to get ecerything excepte exfesifide type *NOT IN*
SELECT * FROM exercise 	WHERE type NOT IN ("biking" , "hiking" , "tree climbing", "rowing");

-- create new table doctor recomodated activivtes together with activities
CREATE TABLE drs_favorites (id INTEGER PRIMARY KEY , type TEXT , reason TEXT);

--inserting new data to drs_favorites
INSERT INTO drs_favorites(type, reason) VALUES ("biking", "Improves endurance and flexibility");
INSERT INTO drs_favorites(type , reason) VALUES ("hiking", "Increases cardiovascular health");

-- to get the table where the docter fevorite and my exrecise list using *IN*
SELECT * FROM exercise WHERE type IN (SELECT type FROM drs_favorites);

-- more complaxe one
SELECT * FROM exercise		WHERE( calories > 50 OR minutes < 30) 
				AND type IN (SELECT type FROM drs_favorites) 
				ORDER BY id;

--to get an inexact mach *not case sensitive* using **LIKE**
SELECT * FROM exercise 		WHERE type IN (SELCET type FROM drs_favorites WHERE reason LIKE "%cardiovascular%");

--to get how many calories burned in specific exercise *GROUP BY*
-- this will give sum of calories for every type and make them group and order them base on sum of calories
SELECT type, SUM(calories) FROM exercise 	GROUP BY type 
						ORDER BY SUM(calories);

--we can change the name of new calmoes resoltes of sum or.... by *AS*
SELECT type, SUM(calories)  AS total_calories 	FROM exercise_logs 
						GROUP BY type;

--to get how many calories burned in specific exercise *GROUP BY*
-- this will give sum of calories for every type and make them group and order them base on sum of calories
-- and show only activities that burn more that 150 calories in total *HAVING*
SELECT type , SUM(calories) AS total_calories FROM exercise 	GROUP BY type 
								HAVING total_calories > 150 
								ORDER BY SUM(calories);

-- to get the avarage form calories or minute *AVG*
SELECT type, AVG(calories) FROM exercise	GROUP BY type
						HAVING AVG(calories) > 70
						ORDER BY AVG(calories);



-- to get the excercises that we have than more than 2 times *COUNT*
SELECT type FROM excercise	GOUP BY type 
				HAVING COUNT(*) >= 2;

SELECT type,SUM(calories) FROM exercise	GROUP BY type 
					HAVING SUM(calories) > 100 
				    AND COUNT(*) >= 2;

--how many exercices that take the heart_rate above danger zone 220 - your age
SELECT COUNT(*) FROM exercise WHERE heart_rate > 220 - 25;

-- how many exercices that take the heart_rate between 50 and 90 %
SELECT COUNT (*) FROM exercise WHERE 	heart_rate >= ROUND (0.50 * (220-30)) 
				 	AND heart_rate <= ROUND (0.90 * (220 -30));


-- create new colome with *CASE* statment
SELECT type, heart_rate 
		CASE	WHEN heart_rate > 220-25 then "above max"
			WHEN heart_rate > ROUND(0.90 * (220 - 25)) THEN "above target"
			WHEN heart_rate  > ROUND (0.50 * (220-25)) THEN "within target"
			ELSE "below target"
			AND AS "hr_zone"
			FROM exercise;

SELECT COUNT(*) , 
		CASE	WHEN heart_rate > 220-25 then "above max"
			WHEN heart_rate > ROUND(0.90 * (220 - 25)) THEN "above target"
			WHEN heart_rate  > ROUND (0.50 * (220-25)) THEN "within target"
			ELSE "below target"
			AND AS "hr_zone"
			FROM exercise	GROUP BY hr_zone;


-- JOINING TABLE
--new exercise
--Create new table
CREATE TABLE students (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, birthdate TEXT);

--insert values to table
INSERT INTO students (first_name, last_name, email,phone,birthdate) values("Peter","peter@gmail.com", "555-6666", "2002-06-24");
INSERT INTO students (first_name, last_name, email,phone,birthdate) values("Alice","alice@gmail.com", "555-7777", "2001-04-01");

--create new table
CREATE TABEL  student_grades (id INTEGER PRIMARY KEY, student_id INTEGER, text TEXT, grade INTEGER);

--insert values
INSERT INTP student_grades(student_id,test , grades) VALUES (1,"Nutrition",95);
INSERT INTP student_grades(student_id,test , grades) VALUES (2,"Nutrition",92);
INSERT INTP student_grades(student_id,test , grades) VALUES (1,"Chemistry",85);
INSERT INTP student_grades(student_id,test , grades) VALUES (2,"Chemistry",95);

--to give all table
SELECT * FROM student_grades;

--to combine 2 table so id in students is the same as student_id in student_grades
--there is few one the simples one is *CROSS JOIN* but less usefull
--to create new table with all data from 2 table
SELECT * FROM student_grades, students;

--Second way is called *INNER JOIN* this is easy and works but this is not the best practice
SELECT* FROM student_grades, students WHERE students_grades.student_id = students.id;

--thierd one is *EXPLICIT INNER JOIN - JOIN * * good this about JOIN you can still use GROUP BY, ORDER BY, WHERE......
SELECT first_name, last_name, email,test, grade FROM students
		JOIN student_grades
		ON students.id = student_grades.student_id
		WHERE grade > 90;

--what happen if there is 2 collomes with the same name in different table , in this case the SQL will not know which one to take and to avoid it we should specify from where it come
SELECT students.first_name, students.last_name, students.email,student_grades.test, student_grades.grade FROM students
		JOIN student_grades
		ON students.id = student_grades.student_id
		WHERE grade > 90;

--more ways to combine tables
--create new table
CREATE TABLE student_projects(id INTEGER PRIMARY KEY, student_id INTEGER,title TEXT);
INSERT INTO student_projects (studen_id, title) VALUES(1, "Carrotopault");

SELECTstudents.first_name, students.last_name, student_projects.title FROM students
									JOIN student_projects
									ON students.id = student_projects.student_id;

--to even get the studetns that have not any project that SQL take them of the list when comparing, we can do that by *OUTER JOIN* this will give NULL for students without project
SELECT students.first_name, students.last_name, student_projects.title FROM students
									LEFT OUTER JOIN student_projects
									ON students.id = student_projects.student_id;

--changing row with delete and change
--new exercise
--create table and insert data
CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT);
CREATE TABLE diary_logs(id INTEGER PRIMARY KEY,user_id INTEGER, date TEXT, content TEXT);

INSERT INTO (user_id,date,content) VALUES (1,"2015-04-01","jiber jaber");
INSERT INTO (user_id,date,content) VALUES (1,"2015-04-02","jaber jiber");

--to modify the data
 UPDATE diary_logs SET content = "it's the first day of university" WHERE id = 1; //this is safest way or we can say user_id = 1 AND date = 2015-04-01

--to delete data
DELETE FROM diary_logs WHERE id = 1; //never use delete to be more safe, use delete BOOLEAN attribute from FALSE to TRUE


--altering tables after creation
-- 45:55
























--https://www.khanacademy.org/computer-programming/new-sql-script/6050809153257472