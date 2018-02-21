CREATE TABLE PLACE(
name VARCHAR,
location VARCHAR,
rating int check (rating >= 0 and rating <= 5),/*DDL3 */
opening_hours varchar,
landmark VARCHAR,
museum VARCHAR,
CONSTRAINT check_null CHECK ((landmark is not null AND museum is null) OR (museum is not null AND landmark is null)),
PRIMARY KEY (name,location)
);


CREATE TABLE "USER"(
email_address VARCHAR CHECK (email_address LIKE '%_@__%.__%'),/*DDL4*/
PRIMARY KEY (email_address)
);

CREATE TABLE EMAIL(
id VARCHAR,
sender VARCHAR,
message VARCHAR,
date DATE,
PRIMARY KEY (ID),
user_email VARCHAR,
FOREIGN KEY (user_email) REFERENCES "USER"(email_address)
);

CREATE TABLE FAVORS (
place_name VARCHAR,
place_location VARCHAR,
user_email VARCHAR,
PRIMARY KEY (place_name,place_location,user_email),
FOREIGN KEY (place_name,place_location) REFERENCES PLACE(name,location),
FOREIGN KEY (user_email) REFERENCES "USER"(email_address)
);

CREATE TABLE FOLLOW(
follower VARCHAR,
followee VARCHAR,
is_approved BOOLEAN,
PRIMARY KEY(followee,follower),
FOREIGN KEY (followee) REFERENCES "USER"(email_address),
FOREIGN KEY (follower) REFERENCES "USER"(email_address)
);

CREATE TABLE TRIP(
destination VARCHAR,
start_date DATE,
end_date DATE,
user_email VARCHAR NOT NULL,
FOREIGN KEY (user_email) REFERENCES "USER"(email_address),
PRIMARY KEY (user_email,destination)
);

CREATE TABLE DAY_PLAN(
name VARCHAR,
date DATE,
trip_destination VARCHAR NOT NULL,
user_email VARCHAR,
FOREIGN KEY (trip_destination,user_email) REFERENCES trip(destination,user_email),
PRIMARY KEY (name,user_email,trip_destination)
);

CREATE TABLE "REFERENCES"(
sequence_nr VARCHAR,
place_name VARCHAR,
place_location VARCHAR,
day_plan_name VARCHAR,
trip_destination VARCHAR,
user_email VARCHAR,
PRIMARY KEY (place_name,place_location,day_plan_name,trip_destination,user_email),
FOREIGN KEY (place_name,place_location) REFERENCES PLACE(name,location),
FOREIGN KEY (day_plan_name,user_email,trip_destination) REFERENCES DAY_PLAN(name,user_email,trip_destination)
);

INSERT INTO place VALUES('The Tower of London', '51.508530, -0.076132' , 5 , '24 hours', 'landmark',null);
INSERT INTO place VALUES('Central Park', '40.785091, -73.968285' , 5 , '24 hours', 'landmark',null);
INSERT INTO place VALUES('National Museum of Military History', '42.688770, 23.351381' , 4 , '9:00 to 15:00', null ,'art exhibition');

INSERT INTO "USER" VALUES('bigman@gmail.com');
INSERT INTO "USER" VALUES('strongman@gmail.com');
INSERT INTO "USER" VALUES('mr.cool@gmail.com');

INSERT INTO EMAIL VALUES('BSQ123', 'reservation@reservation.com' ,'your reservation is been confirmed','2022-01-10', 'mr.cool@gmail.com');
INSERT INTO EMAIL VALUES('ABC123', 'reservation@reservation.com' ,'your reservation is been confirmed','2018-02-20', 'strongman@gmail.com');
INSERT INTO EMAIL VALUES('QSL123', 'reservation@reservation.com' ,'your reservation is been confirmed','2012-03-30', 'bigman@gmail.com');

INSERT INTO FAVORS VALUES('The Tower of London', '51.508530, -0.076132' ,'bigman@gmail.com');
INSERT INTO FAVORS VALUES('Central Park', '40.785091, -73.968285' ,'bigman@gmail.com');
INSERT INTO FAVORS VALUES('National Museum of Military History', '42.688770, 23.351381' , 'mr.cool@gmail.com');

INSERT INTO FOLLOW VALUES('strongman@gmail.com','bigman@gmail.com',TRUE);
INSERT INTO FOLLOW VALUES('strongman@gmail.com','mr.cool@gmail.com',TRUE);
INSERT INTO FOLLOW VALUES('bigman@gmail.com','mr.cool@gmail.com',TRUE);

INSERT INTO TRIP VALUES('London','2022-01-10','2022-01-20','mr.cool@gmail.com');
INSERT INTO TRIP VALUES('USA', '2018-02-20','2018-03-20','mr.cool@gmail.com');
INSERT INTO TRIP VALUES('Ireland','2012-03-20','2012-04-10', 'mr.cool@gmail.com');

INSERT INTO DAY_PLAN VALUES('day in London','2022-01-10','London', 'mr.cool@gmail.com');
INSERT INTO DAY_PLAN VALUES('day in USA' ,'2018-02-20','USA','mr.cool@gmail.com');
INSERT INTO DAY_PLAN VALUES('day to see museums' ,'2012-03-20','Ireland', 'mr.cool@gmail.com');

INSERT INTO "REFERENCES" VALUES('1','The Tower of London', '51.508530, -0.076132' ,'day in London' , 'London','mr.cool@gmail.com');
INSERT INTO "REFERENCES" VALUES('2','Central Park', '40.785091, -73.968285' ,'day in USA' , 'USA', 'mr.cool@gmail.com');
INSERT INTO "REFERENCES" VALUES('3','National Museum of Military History', '42.688770, 23.351381' , 'day to see museums' , 'Ireland','mr.cool@gmail.com');

