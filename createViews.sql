/*
DESC USER_INFORMATION
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 USER_ID					    VARCHAR2(100)
 FIRST_NAME					    VARCHAR2(100)
 LAST_NAME					    VARCHAR2(100)
 YEAR_OF_BIRTH					    NUMBER(38)
 MONTH_OF_BIRTH 				    NUMBER(38)
 DAY_OF_BIRTH					    NUMBER(38)
 GENDER 					    VARCHAR2(100)
 CURRENT_CITY					    VARCHAR2(100)
 CURRENT_STATE					    VARCHAR2(100)
 CURRENT_COUNTRY				    VARCHAR2(100)
 HOMETOWN_CITY					    VARCHAR2(100)
 HOMETOWN_STATE 				    VARCHAR2(100)
 HOMETOWN_COUNTRY				    VARCHAR2(100)
 INSTITUTION_NAME				    VARCHAR2(100)
 PROGRAM_YEAR					    NUMBER(38)
 PROGRAM_CONCENTRATION				    CHAR(100)
 PROGRAM_DEGREE 				    VARCHAR2(100)
*/
CREATE VIEW VIEW_USER_INFORMATION (


);

/*
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 USER1_ID					    VARCHAR2(100)
 USER2_ID					    VARCHAR2(100)
*/
CREATE VIEW VIEW_ARE_FRIENDS (USER1_ID, USER2_ID) AS 
	(SELECT CAST(USER1_ID AS VARCHAR2(100)), CAST(USER2_ID AS VARCHAR2(100))
	 FROM FRIENDS);


/*
Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 ALBUM_ID					    VARCHAR2(100)
 OWNER_ID					    VARCHAR2(100)
 COVER_PHOTO_ID 				    VARCHAR2(100)
 ALBUM_NAME					    VARCHAR2(100)
 ALBUM_CREATED_TIME				    TIMESTAMP(6)
 ALBUM_MODIFIED_TIME				    TIMESTAMP(6)
 ALBUM_LINK					    VARCHAR2(2000)
 ALBUM_VISIBILITY				    VARCHAR2(100)
 PHOTO_ID					    VARCHAR2(100)
 PHOTO_CAPTION					    VARCHAR2(2000)
 PHOTO_CREATED_TIME				    TIMESTAMP(6)
 PHOTO_MODIFIED_TIME				    TIMESTAMP(6)
 PHOTO_LINK					    VARCHAR2(2000)

 CREATE TABLE ALBUMS (
/*  NAME 				TYPE			NULL?		
	ALBUM_ID			VARCHAR(100),
	ALBUM_OWNER_ID		NUMBER			NOT NULL,
	ALBUM_NAME 			VARCHAR(100)	NOT NULL,
	ALBUM_CREATED_TIME	TIMESTAMP		NOT NULL,
	ALBUM_MODIFIED_TIME	TIMESTAMP		NOT NULL,
	ALBUM_LINK 			VARCHAR(2000)	NOT NULL,
	ALBUM_VISIBILITY	VARCHAR(100)	NOT NULL,
	COVER_PHOTO_ID		VARCHAR(100)	NOT NULL	UNIQUE,
	PRIMARY KEY	(ALBUM_ID),
	FOREIGN KEY (ALBUM_OWNER_ID) REFERENCES USERS ON DELETE CASCADE
);
 */
CREATE VIEW VIEW_PHOTO_INFORMATION (ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME,
	ALBUM_LINK, ALBUM_VISIBILITY, PHOTO_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK) AS
	(SELECT CAST(A.ALBUM_ID AS VARCHAR2(100)), CAST(A.ALBUM_OWNER_ID AS VARCHAR2(100)),  )
	FROM ALBUMS AS A,


);

/*
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 PHOTO_ID					    VARCHAR2(100)
 TAG_SUBJECT_ID 				    VARCHAR2(100)
 TAG_CREATED_TIME				    TIMESTAMP(6)
 TAG_X_COORDINATE				    NUMBER
 TAG_Y_COORDINATE				    NUMBER

 CREATE TABLE TAGS (
/*  NAME 				TYPE			NULL?		
	TAG_PHOTO_ID		VARCHAR(100),
	TAG_SUBJECT_ID		NUMBER,
	TAG_CREATE_TIME		TIMESTAMP		NOT NULL,
	TAG_X				NUMBER			NOT NULL,
	TAG_Y				NUMBER			NOT NULL,
	/* USER CAN ONLY BE TAGGED ONCE IN A PICTURE 
	PRIMARY KEY (TAG_PHOTO_ID, TAG_SUBJECT_ID),
	FOREIGN KEY (TAG_PHOTO_ID) REFERENCES PHOTOS ON DELETE CASCADE,
	FOREIGN KEY (TAG_SUBJECT_ID) REFERENCES USERS ON DELETE CASCADE
);
 */
CREATE VIEW VIEW_TAG_INFORMATION (PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE) AS
	(SELECT TAG_PHOTO_ID, CAST(TAG_SUBJECT_ID AS VARCHAR2(100)), CAST(TAG_CREATED_TIME AS TIMESTAMP(6)), TAG_X, TAG_Y
		FROM TAGS);

/*
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 EVENT_ID					    VARCHAR2(100)
 EVENT_CREATOR_ID				    VARCHAR2(100)
 EVENT_NAME					    VARCHAR2(100)
 EVENT_TAGLINE					    VARCHAR2(1000)
 EVENT_DESCRIPTION				    VARCHAR2(4000)
 EVENT_HOST					    VARCHAR2(100)
 EVENT_TYPE					    VARCHAR2(100)
 EVENT_SUBTYPE					    VARCHAR2(100)
 EVENT_LOCATION 				    VARCHAR2(200)
 EVENT_CITY					    VARCHAR2(100)
 EVENT_STATE					    VARCHAR2(100)
 EVENT_COUNTRY					    VARCHAR2(100)
 EVENT_START_TIME				    TIMESTAMP(6)
 EVENT_END_TIME 				    TIMESTAMP(6)
 */
CREATE VIEW VIEW_EVENT_INFORMATION (


);