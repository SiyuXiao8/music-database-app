DROP DATABASE IF EXISTS musicapp; 
CREATE DATABASE musicapp;
USE musicapp;

CREATE TABLE record_label
(
	labelID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    foundedBy INT NOT NULL
);
INSERT INTO record_label (name, foundedBy)
	VALUES
    ('Sony Music Entertainment', 1929),
    ('Universal Music Publishing Group', 1972),
    ('Warner Music Group', 2003),
    ('Island Records', 1959),
    ('BMG Rights Management', 2008),
    ('ABC-Paramount Records', 1955),
    ('Virgin Records', 1972),
    ('Red Hill Records', 1995);
    
CREATE TABLE musician
(
	musicianID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    artist BOOLEAN NOT NULL,
    producer BOOLEAN NOT NULL,
    recordLabel INT,
    FOREIGN KEY(recordLabel) REFERENCES record_label(labelID)
		ON DELETE NO ACTION ON UPDATE NO ACTION
);
-- singer
INSERT INTO musician (name,artist,producer,recordLabel)
	VALUES
    ('Taylor Swift', True, True, 2),
    ('Drake', True, True, 2),
    ('Ed Sheeran', True, True, 3),
	('Beyoncee', True, True, 1),
    ('Westlife', True, True, 1),
    ('Justin Bieber', True, True, 4),
    ('Backstreet Boys', True, True, 5),
    ('Ed Sheeran', True, True,6),
    ('Mariah Carey', True, True, 7),
    ('Maite Perroni', True, True, 8);


CREATE TABLE song
(
	songID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    lyrics VARCHAR(2560) NOT NULL,
    releaseYear INT NOT NULL,
    genre ENUM('POP', 'RAP', 'R&B', 'ROCK', 'JAZZ', 'COUNTRY'),
    artistID INT,
	FOREIGN KEY (artistID) REFERENCES musician(musicianID)
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO song (name, lyrics, releaseYear, genre, artistID)
	VALUES
    ('Shake it off', "I stay out too late Got nothing in my brain That's what people say, mmm-mmm That's what people say, mmm-mmm I go on to many dates, ha-ha But I can't make them stay At least that's what people say, mmm-mmm That's what people say, mmm-mmm But I keep cruising Can't stop, won't stop moving It's like I got this music In my mind Saying, 'It's gonna be alright 'Cause the players gonna play, play, play, play, play And the haters gonna hate, hate, hate, hate, hate Baby, I'm just gonna shake, shake, shake, shake, shake Shake it off, I shake it off", 2014, 'POP', 1),
	('Shape of You', "The club isn't the best place to find a lover So the bar is where I go Me and my friends at the table doing shots Drinking fast and then we talk slow And you come over and start up a conversation with just me And trust me I'll give it a chance now Take my hand, stop, put Van the Man on the jukebox And then we start to dance, and now I'm singing like Girl, you know I want your love Your love was handmade for somebody like me Come on now, follow my lead I may be crazy, don't mind me Say, boy, let's not talk too much Grab on my waist and put that body on me Come on now, follow my lead Come, come on now, follow my lead", 2017, 'POP', 3),
	('One Dance', "Baby, I like your style Grips on your waist Front way, back way You know that I don't play Streets not safe But I never run away Even when I'm away Oti, oti, there's never much love when we go OT I pray to make it back in one piece I pray, I pray That's why I need a one dance Got a Hennessy in my hand One more time 'fore I go Higher powers taking a hold on me I need a one dance Got a Hennessy in my hand One more time 'fore I go Higher powers taking a hold on me", 2016, 'R&B', 2),
	("God's Plan", "Yeah, they wishin' and wishin' and wishin' and wishin' They wishin' on me, yuh I been movin' calm, don't start no trouble with me Tryna keep it peaceful is a struggle for me Don't pull up at 6 AM to cuddle with me You know how I like it when you lovin' on me I don't wanna die for them to miss me Yes, I see the things that they wishin' on me Hope I got some brothers that outlive me They gon' tell the story, sh*t was different with me God's plan, God's plan I hold back, sometimes I won't, yuh I feel good, sometimes I don't, ayy, don't I finessed down Weston Road, ayy, 'nessed Might go down a G-O-D, yeah, wait I go hard on Southside G, yuh, Way I make sure that north side eat", 2018, 'RAP', 2),
    ('Bad blood', "Cause baby, now we got bad blood You know it used to be mad love So take a look what you've done Cause baby, now we got bad blood (hey!)",2014, 'POP',1),
    ('Bad Habits', "One, two, three, four Ooh-ooh, ooh-ooh-ooh Every time you come around, you know I can't say no Every time the sun goes down, I let you take control",2021, 'POP', 3),
	('CUFF IT', " I feel like fallin' in love (fallin' love) I'm in the mood to fuck something up (tonight, I'm fucking something up, baby) I need some drink in my cup (I need a drink) Hey (pour me a drink) ",2022, 'R&B', 4),
	('Partition', "Lemme hear you say Hey Ms. Carter (Hey, Ms. Carter!) Say, Hey, Ms. Carter!(Hey, Ms. Carter!)Give me some!See me up in the club with fifty-eleven girls",2013, 'R&B', 4),
    ('My Love', " An empty street, an empty house A hole inside my heart I'm all alone, the rooms are getting smaller I wonder how, I wonder why ",2000, 'R&B', 5),
    ('You Raise Me Up', " When I am down and oh, my soul, so weary When troubles come and my heart burdened be And I am still and wait here in the silence Until you come and sit a while with me",2005, 'POP', 5),
    ('STAY', " I do the same thing, I told you that I never would I told you I changed, even when I knew I never could I know that I can't find nobody else as good as you I need you to stay, need you to stay, hey ",2021, 'POP', 6),
    ('Baby', "Oh-ooh-whoa-oh-oh-oh-oh Oh-ooh-whoa-oh-oh-oh-oh Oh-ooh-whoa-oh, oh-oh-oh-oh You know you love me (yo), I know you care",2010, 'POP', 6),
	('I Want It That Way', "-Yeah You are my fire The one desire Believe when I say",1999, 'POP', 7),
	('Shape of My Heart', "Yeah, yeah Baby, please try to forgive me Stay here don't put out the glow Hold me now don't bother",2000, 'R&B', 7),
	('Perfect', "I found a love, for me Darling, just dive right in and follow my lead Well, I found a girl, beautiful and sweet Oh, I never knew you were the someone waiting for me",2017, 'POP', 8),
	('Shape of You', "The club isn't the best place to find a lover So the bar is where I go Me and my friends at the table doing shots Drinking fast and then we talk slow",2017, 'POP', 8),
	('All I Want For Christmas Is You (SuperFestive!)', "I don't want a lot for Christmas There is just one thing I need I don't care about the presents underneath the Christmas tree I just want you for my own",2011, 'POP', 9),
	('When You Believe', " Many nights we prayed With no proof, anyone could hear In our hearts a hopeful song We barely understood",1998, 'R&B', 9),
	('Como Yo Te Quiero', "Con esa cara que ilumina el cielo Yo ya sé muy bien que hacer con tu boca Andan diciendo por ahí en la calle que tú estás loca Que debo hacer para al fin convencerte?",2018, 'POP', 10),
	('Inalcanzable', "Te siento tan distante y tan cerca a la vez Descifrando Tu silencio Y entonces me imagino dentro de tu piel",2007, 'POP', 10);

CREATE TABLE playlist
(
	playlistID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) UNIQUE
);
INSERT INTO playlist (name)
	VALUES
    ('recommendation'),
    ('user defined list 1'),
    ('user defined list 2');



CREATE TABLE recommended_list
(
    playlistID INT,
    songs INT,
    FOREIGN KEY (songs) REFERENCES song(songID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (playlistID) REFERENCES playlist(playlistID)
		ON DELETE NO ACTION ON UPDATE NO ACTION
);
INSERT INTO recommended_list
	VALUES
    (1, 1),
    (1, 2);

CREATE TABLE users
(
	userID INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(256) NOT NULL UNIQUE,
    password VARCHAR(256) NOT NULL,
    age INT
);
INSERT INTO users (username, password, age)
	VALUES
    ('user1', '123456', 22),
    ('user2', '123456', 24);

CREATE TABLE user_list
(
    ownerID INT NOT NULL,
    playlistID INT,
    songs INT,
    FOREIGN KEY (songs) REFERENCES song(songID)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (playlistID) REFERENCES playlist(playlistID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ownerID) REFERENCES users(userID)
		ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO user_list (ownerID, playlistID, songs)
	VALUES  (1, 2, 2),
			(1, 2, 3),
			(2, 3, 1),
			(2, 3, 2),
			(2, 3, 3);
    
DROP PROCEDURE IF EXISTS userRegister;
DELIMITER $$
CREATE PROCEDURE userRegister(IN usernameWanted VARCHAR(256),IN age INT, IN password VARCHAR(256))
BEGIN
DECLARE s varchar(256);
IF EXISTS(SELECT userID FROM users WHERE username = usernameWANTED)
	THEN
		SET s = 'User already exists';
     SELECT s;
ELSE
     INSERT INTO users(username,age,password) 
        VALUES(usernameWanted,age, password);
        SET s =  "User Registered"; 
        SELECT s;
END IF;

END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS changePassword;
DELIMITER $$
CREATE PROCEDURE changePassword (IN usernameIN VARCHAR(256), IN passwordWanted VARCHAR(256))
BEGIN

UPDATE users
    SET password = passwordWanted
    WHERE username = usernameIN;
SELECT 'Password updated!';

END $$ 
DELIMITER ;

DROP PROCEDURE IF EXISTS login;
DELIMITER $$
CREATE PROCEDURE login(IN usernameIN VARCHAR(256), IN passwordIN VARCHAR(256)) 
BEGIN
IF NOT EXISTS(SELECT username, password FROM users WHERE username = usernameIN and password = passwordIN)
	THEN 
    SELECT 'Incorrect login information, please try again or restart the App to get a new account';
    
ELSE
	SELECT 'Login successful!';
END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS displaySongInUserlist;
DELIMITER $$
CREATE PROCEDURE displaySongInUserlist(IN userlistID INT, IN userID INT)
BEGIN 
SELECT S.songID, S.name, M.name AS singerName FROM user_list AS U JOIN song AS S 
	ON U.songs = S.songID JOIN musician AS M ON S.artistID = M.musicianID
    WHERE U.playlistID = userlistID
    ORDER BY songID;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS deleteSongFromUserlist;
DELIMITER $$
CREATE PROCEDURE deleteSongFromUserlist(IN ownerIDin INT, IN songIDin INT, IN userlistID INT)
BEGIN 

DELETE FROM user_list 
	where songs = songIDin
	AND ownerID = ownerIDin
    AND playlistID = userlistID;
SELECT 'Successfull deleted!';
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS searchSongByName;
DELIMITER $$
CREATE PROCEDURE searchSongByName (IN songName VARCHAR(256), IN userID INT)
BEGIN 
SELECT S.songID, S.name, S.lyrics, S.releaseYear, S.genre, M.name AS singerName
	From song AS S JOIN musician AS M ON S.artistID = M.musicianID
	WHERE S.name like CONCAT ('%', songName, '%');
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS displayArist;
DELIMITER $$
CREATE PROCEDURE displayArist ()
BEGIN 
SELECT musician.name, record_label.name FROM musician JOIN record_label ON musician.recordLabel = record_label.labelID;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS searchSongByArtist;
DELIMITER $$
CREATE PROCEDURE searchSongByArtist (IN artistName VARCHAR(256), IN userID INT)
BEGIN 
SELECT song.songID, song.name From song Join musician on song.artistID = musician.musicianID WHERE musician.name like CONCAT ('%', artistName, '%');
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS displayRecordLabel;
DELIMITER $$
CREATE PROCEDURE displayRecordLabel ()
BEGIN 
SELECT * FROM record_label;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS searchSongByRecord;
DELIMITER $$
CREATE PROCEDURE searchSongByRecord (IN recordID INT, IN userID INT)
BEGIN 
SELECT song.songID, song.name From song 
Join musician on song.artistID = musician.musicianID 
Join record_label on musician.recordLabel = record_label.labelID 
WHERE record_label.labelID = recordID;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS displayRecommendedList;
DELIMITER $$
CREATE PROCEDURE displayRecommendedList ()
BEGIN 
SELECT song.songID, song.name, musician.name AS singerName From song 
	JOIN recommended_list ON recommended_list.songs = song.songID
	JOIN musician ON song.artistID = musician.musicianID;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS createPlaylist;
DELIMITER $$
CREATE PROCEDURE createPlaylist (IN nameOfList VARCHAR(256), IN idOfOwnerID INT)
BEGIN 
DECLARE num INT;
	
	INSERT INTO playlist(name) VALUES(nameOfList); 
    -- select * from playList;
    SELECT max(playlistID) INTO num FROM playlist; -- 7
    CALL createUserPlaylist(idOfOwnerID,num); -- 
	SELECT "Playlist created successfully!"; 
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS createUserPlaylist;
DELIMITER $$
CREATE PROCEDURE createUserPlaylist(IN idOfOwnerID INT, IN idOfPlaylist INT)
BEGIN 
	INSERT INTO user_list(ownerID, playlistID) VALUES(idOfOwnerID, idOfPlaylist);
END $$
DELIMITER ;

-- add songs to addSongToPlaylist( songID, playListID)
DROP PROCEDURE IF EXISTS addSongToPlaylist;
DELIMITER $$
CREATE PROCEDURE addSongToPlaylist(IN idOfOwner INT,IN idOfPlaylist INT,IN idOfSong INT)
BEGIN 
	INSERT INTO user_list (ownerID, playlistID, songs) VALUES(idOfOwner,idOfPlaylist,idOfSong);
SELECT "Add successfull!"; 
END $$
DELIMITER ;

-- display current playlist that user owns
DROP PROCEDURE IF EXISTS displayCurrentlistOwn;
DELIMITER $$
CREATE PROCEDURE displayCurrentlistOwn(IN ownerID INT)
BEGIN
SELECT DISTINCT t.playlistID, t.name FROM
(SELECT p.playlistID, p.name FROM playlist AS p RIGHT OUTER JOIN
	user_list AS u USING(playlistID)
    WHERE u.ownerID = ownerID) AS t;

END $$
DELIMITER ;