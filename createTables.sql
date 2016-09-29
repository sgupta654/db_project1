CREATE TABLE USERS (
/*  NAME 				TYPE			NULL?		*/
	USER_ID				NUMBER,
	FIRST_NAME			VARCHAR2(100) 	NOT NULL,
	LAST_NAME 			VARCHAR2(100)	NOT NULL,
	YEAR_OF_BIRTH		INTEGER,
	MONTH_OF_BIRTH 		INTEGER,
	DAY_OF_BIRTH		INTEGER,
	GENDER 				VARCHAR2(100),
	PRIMARY KEY (USER_ID)
);

CREATE TABLE FRIENDS (
/*  NAME 				TYPE			NULL?		*/
	USER1_ID			NUMBER,
	USER2_ID			NUMBER,
	PRIMARY KEY (USER1_ID, USER2_ID),
	FOREIGN KEY (USER1_ID) REFERENCES USERS,
	FOREIGN KEY (USER2_ID) REFERENCES USERS
);

/*
CREATE TRIGGER friends_order
BEFORE INSERT ON FRIENDS
FOR EACH ROW BEGIN
WHEN(NEW.USER1_ID > NEW.USER2_ID)
BEGIN
	INSERT INTO FRIENDS VALUES(:NEW.USER2_ID, :NEW.USER1_ID);
END;
/
*/

/*
CREATE TRIGGER friends_rm_duplicates BEFORE INSERT ON FRIENDS
FOR EACH ROW BEGIN
	SET @low_id := IF(NEW.USER1_ID < NEW.USER2_ID, NEW.USER1_ID, NEW.USER2_ID);
	SET @high_id := IF(NEW.USER1_ID > NEW.USER2_ID, NEW.USER1_ID, NEW.USER2_ID);
	SET NEW.USER1_ID = @low_id;
	SET NEW.USER2_ID = @high_id;
END;
/
*/

CREATE TABLE CITIES (
/*  NAME 				TYPE			NULL?		*/
	CITY_ID  			INTEGER,
	CITY_NAME 			VARCHAR2(100),
	STATE_NAME			VARCHAR2(100),
	COUNTRY_NAME		VARCHAR2(100),
	PRIMARY KEY (CITY_ID)
);

CREATE SEQUENCE city_id_seq START WITH 1 INCREMENT BY 1 CACHE 20;

CREATE OR REPLACE TRIGGER city_id_increment 
BEFORE INSERT ON CITIES
FOR EACH ROW
BEGIN
	SELECT city_id_seq.nextval 
	INTO :NEW.CITY_ID 
	FROM dual;
END;
/

CREATE TABLE USER_CURRENT_CITY (
/*  NAME 				TYPE			NULL?		*/
	USER_ID 			NUMBER,
	CURRENT_CITY_ID 	INTEGER,
	PRIMARY KEY (USER_ID),
	FOREIGN KEY (USER_ID) REFERENCES USERS,
	FOREIGN KEY (CURRENT_CITY_ID) REFERENCES CITIES
);

CREATE TABLE USER_HOMETOWN_CITY (
/*  NAME 				TYPE			NULL?		*/
	USER_ID 			NUMBER,
	HOMETOWN_CITY_ID 	INTEGER,
	PRIMARY KEY (USER_ID),
	FOREIGN KEY (USER_ID) REFERENCES USERS,
	FOREIGN KEY (HOMETOWN_CITY_ID) REFERENCES CITIES
);

CREATE TABLE MESSAGE (
/*  NAME 				TYPE			NULL?		*/
	MESSAGE_ID			INTEGER, 
	SENDER_ID			NUMBER			NOT NULL,
	RECEIVER_ID			NUMBER			NOT NULL,
	MESSAGE_CONTENT 	VARCHAR(2000)	NOT NULL,
	SENT_TIME  			TIMESTAMP		NOT NULL,
	/* SENDER CAN SEND ZERO OR MORE MESSAGES TO DIFFERENT USERS */ 
	PRIMARY KEY (MESSAGE_ID),
	FOREIGN KEY (SENDER_ID) REFERENCES USERS,
	FOREIGN KEY (RECEIVER_ID) REFERENCES USERS
);

CREATE TABLE PROGRAMS (
/*  NAME 				TYPE			NULL?		*/
	PROGRAM_ID 			INTEGER,
	INSTITUTION			VARCHAR(100),
	CONCENTRATION		VARCHAR(100),
	DEGREE 				VARCHAR(100),
	PRIMARY KEY (PROGRAM_ID)
);

CREATE SEQUENCE program_id_seq
START WITH 1
INCREMENT BY 1
CACHE 20;

CREATE OR REPLACE TRIGGER program_id_increment 
BEFORE INSERT ON PROGRAMS
FOR EACH ROW
BEGIN
	SELECT program_id_seq.nextval 
	INTO :NEW.PROGRAM_ID 
	FROM dual;
END;
/

CREATE TABLE EDUCATION (
/*  NAME 				TYPE			NULL?		*/
	USER_ID 			NUMBER,
	PROGRAM_ID 			INTEGER,
	PROGRAM_YEAR		INTEGER,
	/* A USER CAN BE A PART OF MULTIPLE PROGRAMS */ 
	PRIMARY KEY (USER_ID, PROGRAM_ID, PROGRAM_YEAR),
	FOREIGN KEY (USER_ID) REFERENCES USERS,
	FOREIGN KEY (PROGRAM_ID) REFERENCES PROGRAMS
);

CREATE TABLE USER_EVENTS (
/*  NAME 				TYPE			NULL?		*/
	EVENT_ID			NUMBER,
	EVENT_CREATOR_ID	NUMBER			NOT NULL,
	EVENT_NAME			VARCHAR(100)	NOT NULL,
	EVENT_TAGLINE		VARCHAR(100),
	EVENT_DESCRIPTION	VARCHAR(100),
	EVENT_HOST			VARCHAR(100)	NOT NULL,
	EVENT_TYPE			VARCHAR(100)	NOT NULL,
	EVENT_SUBTYPE		VARCHAR(100)	NOT NULL,
	EVENT_LOCATION		VARCHAR(100),
	EVENT_CITY_ID		INTEGER,
	EVENT_START_TIME	TIMESTAMP		NOT NULL,
	EVENT_END_TIME 		TIMESTAMP		NOT NULL,
	PRIMARY KEY	(EVENT_ID),
	FOREIGN KEY	(EVENT_CREATOR_ID) REFERENCES USERS,
	FOREIGN KEY (EVENT_CITY_ID) REFERENCES CITIES
);

CREATE TABLE PARTICIPANTS (
/*  NAME 				TYPE			NULL?		*/
	EVENT_ID   			NUMBER,
	USER_ID 			NUMBER,
	CONFIRMATION		VARCHAR(100)	NOT NULL,
	PRIMARY KEY	(EVENT_ID, USER_ID),
	FOREIGN KEY (EVENT_ID) REFERENCES USER_EVENTS,
	FOREIGN KEY (USER_ID) REFERENCES USERS
);

CREATE TABLE ALBUMS (
/*  NAME 				TYPE			NULL?		*/
	ALBUM_ID			VARCHAR(100),
	ALBUM_OWNER_ID		NUMBER			NOT NULL,
	ALBUM_NAME 			VARCHAR(100)	NOT NULL,
	ALBUM_CREATED_TIME	TIMESTAMP		NOT NULL,
	ALBUM_MODIFIED_TIME	TIMESTAMP		NOT NULL,
	ALBUM_LINK 			VARCHAR(2000),
	ALBUM_VISIBILITY	VARCHAR(100)	NOT NULL,
	COVER_PHOTO_ID		VARCHAR(100)	NOT NULL	UNIQUE,
	PRIMARY KEY	(ALBUM_ID),
	FOREIGN KEY (ALBUM_OWNER_ID) REFERENCES USERS
);

CREATE TABLE PHOTOS (
/*  NAME 				TYPE			NULL?		*/
	PHOTO_ID 			VARCHAR(100),
	ALBUM_ID 			VARCHAR(100)	NOT NULL,
	PHOTO_CAPTION		VARCHAR(100),
	PHOTO_CREATE_TIME	TIMESTAMP		NOT NULL,
	PHOTO_MODIFIED_TIME	TIMESTAMP		NOT NULL,
	PHOTO_LINK			VARCHAR(2000),
	/* A PHOTO CAN ONLY BELONG TO ONE ALBUM */
	PRIMARY KEY (PHOTO_ID),
	FOREIGN KEY (ALBUM_ID) REFERENCES ALBUMS
);

ALTER TABLE ALBUMS ADD CONSTRAINT CV_ID_REFS_PHOTOS FOREIGN KEY (COVER_PHOTO_ID) REFERENCES PHOTOS INITIALLY DEFERRED DEFERRABLE;

CREATE TABLE TAGS (
/*  NAME 				TYPE			NULL?		*/
	TAG_PHOTO_ID		VARCHAR(100),
	TAG_SUBJECT_ID		NUMBER,
	TAG_CREATE_TIME		TIMESTAMP		NOT NULL,
	TAG_X				NUMBER			NOT NULL,
	TAG_Y				NUMBER			NOT NULL,
	/* USER CAN ONLY BE TAGGED ONCE IN A PICTURE */
	PRIMARY KEY (TAG_PHOTO_ID, TAG_SUBJECT_ID),
	FOREIGN KEY (TAG_PHOTO_ID) REFERENCES PHOTOS,
	FOREIGN KEY (TAG_SUBJECT_ID) REFERENCES USERS
);





