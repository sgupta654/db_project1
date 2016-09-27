CREATE TABLE User (
/*  Name 				TYPE			NULL?		*/
	user_id				NUMBER,
	first_name			VARCHAR2(100) 	NOT NULL,
	last_name 			VARCHAR2(100)	NOT NULL.
	year_of_birth		INTEGER			,
	month_of_birth 		INTEGER			,
	day_of_birth		INTEGER			,
	gender 				VARCHAR2(100)
	PRIMARY KEY (user_id)
);

CREATE TABLE Friends (
/*  Name 				TYPE			NULL?		*/
	user1_id			NUMBER,
	user2_id			NUMBER,
	PRIMARY KEY (user1_id, user2_id),
	FOREIGN KEY (user1_id REFERENCES User 
					ON DELETE CASCADE),
	FOREIGN KEY (user2_id REFERENCES User
					ON DELETE CASCADE)
);

CREATE TABLE City (
/*  Name 				TYPE			NULL?		*/
	city_id  			INTEGER,
	city_name 			VARCHAR2(100)	NOT NULL,
	state_name			VARCHAR2(100)	NOT NULL,
	country_name		VARCHAR2(100)	NOT NULL,
	PRIMARY KEY (city_id)
);

CREATE TABLE User_Current_City (
/*  Name 				TYPE			NULL?		*/
	user_id 			NUMBER,
	current_city_id 	INTEGER,
	PRIMARY KEY (user_id, current_city_id),
	FOREIGN KEY (user_id REFERENCES User
					ON DELETE CASCADE),
	FOREIGN KEY (current_city_id REFERENCES City
					ON DELETE CASCADE)
);

CREATE TABLE User_Hometown_City (
/*  Name 				TYPE			NULL?		*/
	user_id 			NUMBER,
	hometown_city_id 	INTEGER,
	PRIMARY KEY (user_id, hometown_city_id),
	FOREIGN KEY (user_id REFERENCES User
					ON DELETE CASCADE),
	FOREIGN KEY (current_city_id REFERENCES City
					ON DELETE CASCADE)
);

CREATE TABLE Message (
/*  Name 				TYPE			NULL?		*/
	message_id			INTEGER, 
	sender_id			NUMBER			NOT NULL,
	receiver_id			NUMBER			NOT NULL,
	message_content 	VARCHAR(2000)	NOT NULL,
	sent_time  			TIMESTAMP		NOT NULL,
	/* Sender can send zero or more messages to different users */ 
	PRIMARY KEY (message_id)
	FOREIGN KEY (sender_id REFERENCES User
					ON DELETE CASCADE),
	FOREIGN KEY (receiver_id REFERENCES User
					ON DELETE CASCADE)
);

CREATE TABLE Program (
/*  Name 				TYPE			NULL?		*/
	program_id 			INTEGER,
	institution			VARCHAR(100)	NOT NULL,
	concentration		VARCHAR(100)	NOT NULL,
	degree 				VARCHAR(100)	NOT NULL,
	PRIMARY KEY (program_id)
);

CREATE TABLE Education (
/*  Name 				TYPE			NULL?		*/
	user_id 			NUMBER,
	program_id 			INTEGER,
	program_year		INTEGER			NOT NULL,
	/* A user can be a part of multiple programs */ 
	PRIMARY KEY (user_id, program_id),
	FOREIGN KEY (user_id REFERENCES User
					ON DELETE CASCADE),
	FOREIGN KEY (program_id REFERENCES Program
					ON DELETE CASCADE)
);

CREATE TABLE User_Event (
/*  Name 				TYPE			NULL?		*/
	event_id			NUMBER,
	event_creator_id	NUMBER			NOT NULL,
	event_name			VARCHAR(100)	NOT NULL,
	event_tagline		VARCHAR(100)	,
	event_description	VARCHAR(100)	NOT NULL,
	event_host			VARCHAR(100)	,
	event_type			VARCHAR(100)	NOT NULL,
	event_subtype		VARCHAR(100)	,
	event_location		VARCHAR(100)	NOT NULL,
	event_city_id		INTEGER			,
	event_start_time	TIMESTAMP		NOT NULL,
	event_end_time 		TIMESTAMP		NOT NULL,
	PRIMARY KEY	(event_id),
	FOREIGN KEY	(event_creator_id REFERENCES User
					ON DELETE CASCADE),
	FOREIGN KEY (event_city_id REFERENCES City
					ON DELETE CASCADE)
);

CREATE TABLE Participants (
/*  Name 				TYPE			NULL?		*/
	event_id   			NUMBER			,
	user_id 			NUMBER			,
	confirmation		VARCHAR(100)	NOT NULL,
	PRIMARY KEY	(event_id, user_id),
	FOREIGN KEY (event_id REFERENCES User_Event
					ON DELETE CASCADE),
	FOREIGN KEY (user_id REFERENCES User
					ON DELETE CASCADE)
);

CREATE TABLE Album (
/*  Name 				TYPE			NULL?		*/
	album_id			VARCHAR(100)	,
	album_owner_id		NUMBER			NOT NULL,
	album_name 			VARCHAR(100)	NOT NULL,
	album_created_time	TIMESTAMP		NOT NULL,
	album_modified_time	TIMESTAMP		NOT NULL,
	album_link 			VARCHAR(2000)	NOT NULL,
	album_visibility	VARCHAR(100)	NOT NULL,
	cover_photo_id		VARCHAR(100)	NOT NULL,
	PRIMARY KEY	(album_id),
	FOREIGN KEY (album_owner_id REFERENCES User
					ON DELETE CASCADE),
	FOREIGN KEY (cover_photo_id REFERENCES Photo
					ON DELETE CASCADE)
);

CREATE TABLE Photo (
/*  Name 				TYPE			NULL?		*/
	photo_id 			VARCHAR(100)	,
	album_id 			VARCHAR(100)	NOT NULL,
	photo_caption		VARCHAR(100)	NOT NULL,
	photo_create_time	TIMESTAMP		NOT NULL,
	photo_modified_time	TIMESTAMP		NOT NULL,
	photo_link			VARCHAR(2000)	NOT NULL,
	/* A photo can only belong to ONE album */
	PRIMARY KEY (photo_id, album_id),
	FOREIGN KEY (album_id REFERENCES Album
					ON DELETE CASCADE)
);

CREATE TABLE Tag (
/*  Name 				TYPE			NULL?		*/
	tag_photo_id		VARCHAR(100)	,
	tag_subject_id		NUMBER			,
	tag_create_time		TIMESTAMP		NOT NULL,
	tag_x				NUMBER			NOT NULL,
	tag_y				NUMBER			NOT NULL,
	/* User can only be tagged once in a picture */
	PRIMARY KEY (tag_photo_id, tag_subject_id),
	FOREIGN KEY (tag_subject_id REFERENCES User
					ON DELETE CASCADE)
);




