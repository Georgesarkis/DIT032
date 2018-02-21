CREATE TABLE "user"(
Email_address VARCHAR PRIMARY KEY,
CHECK (Email_address LIKE  '%_@__%.__%')
);

CREATE TABLE email(
	id VARCHAR PRIMARY KEY,
	date DATE,
	message VARCHAR,
	sender VARCHAR,
	user_email VARCHAR,
	FOREIGN KEY (user_email) REFERENCES "user"(Email_address)
);
 
 CREATE TABLE follow(
 	is_approved BOOLEAN,
	first_user VARCHAR,
	approves_user VARCHAR,
	FOREIGN KEY (first_user) REFERENCES "user"(Email_address),
	FOREIGN KEY (approves_user) REFERENCES "user"(Email_address),
	PRIMARY KEY (first_user,approves_user)
);

CREATE TABLE place(
	rating SMALLINT,
	CHECK (0 < rating and rating < 6),
	opening_hour VARCHAR,
	CHECK (opening_hour LIKE'__:__'),
	Location_long FLOAT,
	Location_lat FLOAT,
	name VARCHAR,
	PRIMARY KEY (name,location_long,location_lat),
	museum_current_ex VARCHAR
);
	

CREATE TABLE favors(
	user_email VARCHAR,
	place VARCHAR,
	Location_long FLOAT,
	Location_lat FLOAT,
	FOREIGN KEY (user_email) REFERENCES "user"(Email_address),
	FOREIGN KEY (place,location_long,location_lat)REFERENCES place(name,location_long,location_lat),
	PRIMARY KEY (
);

CREATE TABLE trip(
	user_email VARCHAR NOT NULL,
	place VARCHAR,
	location_lat FLOAT,
	location_long FLOAT,
	start_date DATE,
	end_date DATE, 
	FOREIGN KEY (place,location_long,location_lat)REFERENCES place(name,location_long,location_lat),
	FOREIGN KEY (user_email) REFERENCES "user"(email_address)
);

//after this doesnt work

CREATE TABLE day_plan (
	name VARCHAR,
	date DATE, 
	trip VARCHAR NOT NULL,
	trip_loc_long FLOAT,
	trip_loc_lat FLOAT,
	FOREIGN KEY (trip, trip_loc_long,trip_loc_lat) REFERENCES place(name,location_long,location_lat),
	FOREIGN KEY (name) REFERENCES place(name)
);

CREATE TABLE "references"(
	sequence_ne INTEGER,
	place VARCHAR,
	location_lat FLOAT,
	location_long FLOAT,
	day_plan VARCHAR,
	FOREIGN KEY (place,location_long,location_lat)REFERENCES place(name,location_long,location_lat),
	FOREIGN KEY (day_plan) REFERENCES day_plan(place_name)
);