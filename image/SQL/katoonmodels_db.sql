-- ============================================================
-- DATABASE
-- ============================================================
DROP DATABASE IF EXISTS `katoonmodels_db`;
CREATE DATABASE `katoonmodels_db`;
USE `katoonmodels_db`;

-- ============================================================
-- DROP TABLES (foreign key order)
-- ============================================================
DROP TABLE IF EXISTS manage_Author;
DROP TABLE IF EXISTS contain_Author;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Admin_Account;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Episode;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Katoon;

-- ============================================================
-- TABLE: Katoon
-- เพิ่ม release_day และ cover_image ที่ server.js ต้องใช้
-- ใช้ AUTO_INCREMENT เพื่อรองรับ POST /api/katoons
-- ============================================================
CREATE TABLE Katoon (
    katoon_ID   INT PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(200) NOT NULL,
    status      VARCHAR(20),
    category    VARCHAR(100),
    description TEXT,
    release_day VARCHAR(20),
    cover_image VARCHAR(500)
);

INSERT INTO Katoon (katoon_ID, title, status, category, description, release_day, cover_image) VALUES
(1,  'my body has been possessed by someone',         'Ongoing',   'Fantasy',      'A girl wakes up one day to find a mysterious spirit sharing her body — and it has its own agenda.',         'Monday',    '/image/covers/possessed.jpg'),
(2,  'my clueless love diary',                        'Completed', 'Romance',      'A hopeless romantic keeps a secret diary about her feelings for her dense best friend.',                      'Tuesday',   '/image/covers/clueless_love.jpg'),
(3,  'My Secretly Hot Husband',                       'Ongoing',   'Romance',      'She married a plain-looking man for convenience — then he takes off his glasses.',                           'Wednesday', '/image/covers/hot_husband.jpg'),
(4,  'night owls summer skies',                       'Completed', 'Slice of Life','Two night-shift workers fall in love under the stars of a small seaside town.',                              'Thursday',  '/image/covers/night_owls.jpg'),
(5,  'omniscient reader',                             'Ongoing',   'Fantasy',      'A man who has read every chapter of a web novel suddenly finds himself living inside its story.',            'Friday',    '/image/covers/omniscient.jpg'),
(6,  'one husband is enough',                         'Completed', 'Romance',      'After a whirlwind divorce, she swore one husband was enough — until he showed up at her new office.',        'Saturday',  '/image/covers/one_husband.jpg'),
(7,  'our secret alliance',                           'Ongoing',   'Romance',      'Two rival student council presidents strike a secret deal — and feelings were never part of the agreement.', 'Sunday',    '/image/covers/secret_alliance.jpg'),
(8,  'A Beast Tamed By The Villainess',               'Completed', 'Drama',        'The kingdom\'s most feared knight kneels only before the woman everyone calls a villain.',                   'Monday',    '/image/covers/beast_villainess.jpg'),
(9,  'The Villainess Reverses the Hourglass',         'Ongoing',   'Fantasy',      'Executed and sent back in time, she will rewrite every page of her tragic story.',                          'Wednesday', '/image/covers/hourglass.jpg'),
(10, 'sweet home',                                    'Completed', 'Horror',       'Ordinary residents of an apartment building fight to survive as monsters emerge from within themselves.',    'Wednesday', '/image/covers/sweet_home.jpg'),
(11, 'The First Night With The Duke',                 'Ongoing',   'Romance',      'A reader of a romance novel wakes up as the extra who spends one night with the cold duke.',                'Friday',    '/image/covers/first_night.jpg'),
(12, 'The Greatest Estate Developer',                 'Completed', 'Comedy',       'A civil engineering student reincarnates into a fantasy world and decides to revolutionise its real estate.','Tuesday',  '/image/covers/estate_dev.jpg'),
(13, 'the little revenge plan of a villainess',       'Ongoing',   'Fantasy',      'Framed and disgraced, she returns from exile with a smile and a very detailed revenge spreadsheet.',        'Thursday',  '/image/covers/revenge_plan.jpg'),
(14, 'the mad bloodhound\'s dying master',            'Completed', 'Action',       'A legendary hunter refuses to let his battle-crazed partner die — even at the cost of his own life.',      'Saturday',  '/image/covers/bloodhound.jpg'),
(15, 'the time limited villainess wishes for the future', 'Ongoing', 'Fantasy',   'Given only thirty days to live, the villainess decides to spend them making everyone around her happy.',    'Sunday',    '/image/covers/time_limited.jpg'),
(16, 'to you who killed me',                          'Completed', 'Drama',        'A letter arrives from a dead woman — addressed to the person who loved her most.',                           'Monday',    '/image/covers/killed_me.jpg'),
(17, 'welcome to the rose mansion',                   'Ongoing',   'Horror',       'Guests at an elegant mansion slowly realise the roses in the garden are blooming a little too red.',         'Thursday',  '/image/covers/rose_mansion.jpg'),
(18, 'your letter',                                   'Completed', 'Romance',      'She finds a box of unsent letters in her late grandmother\'s attic — all addressed to a stranger.',         'Tuesday',   '/image/covers/your_letter.jpg');

-- ============================================================
-- TABLE: User  (ชื่อ User ไม่ใช่ Users — server.js แก้แล้ว)
-- ============================================================
CREATE TABLE User (
    user_id  INT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(100),
    email    VARCHAR(100),
    name     VARCHAR(100),
    coin_info INT DEFAULT 0
);

INSERT INTO User (user_id, password, email, name, coin_info) VALUES
(1, 'pass1', 'u1@mail.com', 'User1', 100),
(2, 'pass2', 'u2@mail.com', 'User2', 200),
(3, 'pass3', 'u3@mail.com', 'User3', 150),
(4, 'pass4', 'u4@mail.com', 'User4',  80),
(5, 'pass5', 'u5@mail.com', 'User5',  60),
(6, 'pass6', 'u6@mail.com', 'User6', 300),
(7, 'pass7', 'u7@mail.com', 'User7', 500),
(8, 'pass8', 'u8@mail.com', 'User8',  20),
(9, 'pass9', 'u9@mail.com', 'User9',  90),
(10,'pass10','u10@mail.com','User10',110),
(11,'pass11','u11@mail.com','User11', 50),
(12,'pass12','u12@mail.com','User12', 75),
(13,'pass13','u13@mail.com','User13', 40),
(14,'pass14','u14@mail.com','User14', 95),
(15,'pass15','u15@mail.com','User15',130),
(16,'pass16','u16@mail.com','User16',170),
(17,'pass17','u17@mail.com','User17',210),
(18,'pass18','u18@mail.com','User18', 10),
(19,'pass19','u19@mail.com','User19', 65),
(20,'pass20','u20@mail.com','User20', 85);

-- ============================================================
-- TABLE: Author
-- ============================================================
CREATE TABLE Author (
    pen_name     VARCHAR(100) UNIQUE,
    email        VARCHAR(100) PRIMARY KEY,
    bank_account VARCHAR(100),
    phone        CHAR(10),
    name         VARCHAR(100)
);

INSERT INTO Author VALUES
('Pen1', 'a1@mail.com', '111','0811111111','Author1'),
('Pen2', 'a2@mail.com', '222','0822222222','Author2'),
('Pen3', 'a3@mail.com', '333','0833333333','Author3'),
('Pen4', 'a4@mail.com', '444','0844444444','Author4'),
('Pen5', 'a5@mail.com', '555','0855555555','Author5'),
('Pen6', 'a6@mail.com', '666','0866666666','Author6'),
('Pen7', 'a7@mail.com', '777','0877777777','Author7'),
('Pen8', 'a8@mail.com', '888','0888888888','Author8'),
('Pen9', 'a9@mail.com', '999','0899999999','Author9'),
('Pen10','a10@mail.com','1010','0810101010','Author10'),
('Pen11','a11@mail.com','1111','0811111112','Author11'),
('Pen12','a12@mail.com','1212','0812121212','Author12'),
('Pen13','a13@mail.com','1313','0813131313','Author13'),
('Pen14','a14@mail.com','1414','0814141414','Author14'),
('Pen15','a15@mail.com','1515','0815151515','Author15'),
('Pen16','a16@mail.com','1616','0816161616','Author16'),
('Pen17','a17@mail.com','1717','0817171717','Author17'),
('Pen18','a18@mail.com','1818','0818181818','Author18'),
('Pen19','a19@mail.com','1919','0819191919','Author19'),
('Pen20','a20@mail.com','2020','0820202020','Author20');

-- ============================================================
-- TABLE: Episode
-- ============================================================
CREATE TABLE Episode (
    episode_id INT PRIMARY KEY,
    rating     INT,
    favorite   INT,
    category   VARCHAR(100),
    katoon_ID  INT,
    user_id    INT,
    pen_name   VARCHAR(100),

    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (user_id)   REFERENCES User(user_id),
    FOREIGN KEY (pen_name)  REFERENCES Author(pen_name)
);

INSERT INTO Episode VALUES
(101,5,1,'Fantasy',1,1,'Pen1'),(102,3,0,'Fantasy',1,2,'Pen1'),(103,4,1,'Fantasy',1,3,'Pen1'),(104,2,0,'Fantasy',1,4,'Pen1'),(105,5,1,'Fantasy',1,5,'Pen1'),
(201,2,0,'Romance',2,1,'Pen2'),(202,5,1,'Romance',2,2,'Pen2'),(203,4,1,'Romance',2,3,'Pen2'),(204,3,0,'Romance',2,4,'Pen2'),(205,5,1,'Romance',2,5,'Pen2'),
(301,5,1,'Romance',3,6,'Pen3'),(302,4,0,'Romance',3,7,'Pen3'),(303,3,0,'Romance',3,8,'Pen3'),(304,5,1,'Romance',3,9,'Pen3'),(305,2,0,'Romance',3,10,'Pen3'),
(401,1,0,'Slice of Life',4,1,'Pen4'),(402,5,1,'Slice of Life',4,2,'Pen4'),(403,4,0,'Slice of Life',4,3,'Pen4'),(404,4,1,'Slice of Life',4,4,'Pen4'),(405,3,0,'Slice of Life',4,5,'Pen4'),
(501,5,1,'Fantasy',5,6,'Pen5'),(502,2,0,'Fantasy',5,7,'Pen5'),(503,4,1,'Fantasy',5,8,'Pen5'),(504,3,0,'Fantasy',5,9,'Pen5'),(505,5,1,'Fantasy',5,10,'Pen5'),
(601,4,1,'Romance',6,11,'Pen6'),(602,3,0,'Romance',6,12,'Pen6'),(603,5,1,'Romance',6,13,'Pen6'),(604,2,0,'Romance',6,14,'Pen6'),(605,4,0,'Romance',6,15,'Pen6'),
(701,3,0,'Romance',7,16,'Pen7'),(702,5,1,'Romance',7,17,'Pen7'),(703,4,1,'Romance',7,18,'Pen7'),(704,2,0,'Romance',7,19,'Pen7'),(705,5,1,'Romance',7,20,'Pen7'),
(801,5,1,'Drama',8,1,'Pen8'),(802,4,0,'Drama',8,2,'Pen8'),(803,1,0,'Drama',8,3,'Pen8'),(804,3,1,'Drama',8,4,'Pen8'),(805,5,1,'Drama',8,5,'Pen8'),
(901,2,0,'Fantasy',9,6,'Pen9'),(902,5,1,'Fantasy',9,7,'Pen9'),(903,4,0,'Fantasy',9,8,'Pen9'),(904,3,1,'Fantasy',9,9,'Pen9'),(905,5,1,'Fantasy',9,10,'Pen9'),
(1001,1,0,'Horror',10,11,'Pen10'),(1002,5,1,'Horror',10,12,'Pen10'),(1003,4,0,'Horror',10,13,'Pen10'),(1004,4,1,'Horror',10,14,'Pen10'),(1005,3,0,'Horror',10,15,'Pen10'),
(1101,4,1,'Romance',11,16,'Pen11'),(1102,1,0,'Romance',11,17,'Pen11'),(1103,5,1,'Romance',11,18,'Pen11'),(1104,3,0,'Romance',11,19,'Pen11'),(1105,4,1,'Romance',11,20,'Pen11'),
(1201,3,0,'Comedy',12,1,'Pen12'),(1202,5,1,'Comedy',12,2,'Pen12'),(1203,4,1,'Comedy',12,3,'Pen12'),(1204,2,0,'Comedy',12,4,'Pen12'),(1205,5,1,'Comedy',12,5,'Pen12'),
(1301,5,1,'Fantasy',13,6,'Pen13'),(1302,2,0,'Fantasy',13,7,'Pen13'),(1303,4,1,'Fantasy',13,8,'Pen13'),(1304,5,1,'Fantasy',13,9,'Pen13'),(1305,3,0,'Fantasy',13,10,'Pen13'),
(1401,1,0,'Action',14,11,'Pen14'),(1402,5,1,'Action',14,12,'Pen14'),(1403,4,0,'Action',14,13,'Pen14'),(1404,4,1,'Action',14,14,'Pen14'),(1405,3,0,'Action',14,15,'Pen14'),
(1501,5,1,'Fantasy',15,16,'Pen15'),(1502,3,0,'Fantasy',15,17,'Pen15'),(1503,4,1,'Fantasy',15,18,'Pen15'),(1504,2,0,'Fantasy',15,19,'Pen15'),(1505,5,1,'Fantasy',15,20,'Pen15'),
(1601,4,1,'Drama',16,1,'Pen16'),(1602,2,0,'Drama',16,2,'Pen16'),(1603,5,1,'Drama',16,3,'Pen16'),(1604,3,0,'Drama',16,4,'Pen16'),(1605,5,1,'Drama',16,5,'Pen16'),
(1701,3,0,'Horror',17,6,'Pen17'),(1702,5,1,'Horror',17,7,'Pen17'),(1703,4,1,'Horror',17,8,'Pen17'),(1704,2,0,'Horror',17,9,'Pen17'),(1705,5,1,'Horror',17,10,'Pen17'),
(1801,5,1,'Romance',18,11,'Pen18'),(1802,4,0,'Romance',18,12,'Pen18'),(1803,2,0,'Romance',18,13,'Pen18'),(1804,3,1,'Romance',18,14,'Pen18'),(1805,5,1,'Romance',18,15,'Pen18');

-- ============================================================
-- TABLE: Admin
-- ============================================================
CREATE TABLE Admin (
    email   VARCHAR(100) PRIMARY KEY,
    fname   VARCHAR(100),
    lname   VARCHAR(100),
    age     INT,
    address VARCHAR(100)
);

INSERT INTO Admin VALUES
('admin1@mail.com','A','One',  30,'BKK'),
('admin2@mail.com','B','Two',  28,'BKK'),
('admin3@mail.com','C','Three',35,'BKK'),
('admin4@mail.com','D','Four', 40,'BKK'),
('admin5@mail.com','E','Five', 29,'BKK');

-- ============================================================
-- TABLE: Admin_Account
-- ============================================================
CREATE TABLE Admin_Account (
    username    VARCHAR(100) PRIMARY KEY,
    password    VARCHAR(100),
    login_log   DATE,
    role        VARCHAR(50),
    admin_email VARCHAR(100),

    FOREIGN KEY (admin_email) REFERENCES Admin(email)
);

INSERT INTO Admin_Account VALUES
('admin01','pass','2024-01-01','super', 'admin1@mail.com'),
('admin02','pass','2024-01-02','normal','admin2@mail.com'),
('admin03','pass','2024-01-03','normal','admin3@mail.com'),
('admin04','pass','2024-01-04','super', 'admin4@mail.com'),
('admin05','pass','2024-01-05','normal','admin5@mail.com');

-- ============================================================
-- TABLE: Image  (ลบ LOAD_FILE ออก — ใช้ path string แทน)
-- ============================================================
CREATE TABLE Image (
    image_id   INT PRIMARY KEY AUTO_INCREMENT,
    image_url  VARCHAR(500),
    image_type VARCHAR(100)
);

INSERT INTO Image (image_id, image_url, image_type) VALUES
(1, '/image/covers/possessed.jpg',     'cover'),
(2, '/image/covers/clueless_love.jpg', 'cover'),
(3, '/image/covers/hot_husband.jpg',   'cover'),
(4, '/image/covers/night_owls.jpg',    'cover'),
(5, '/image/covers/omniscient.jpg',    'cover'),
(6, '/image/covers/one_husband.jpg',   'cover'),
(7, '/image/covers/secret_alliance.jpg','cover'),
(8, '/image/covers/beast_villainess.jpg','cover'),
(9, '/image/covers/hourglass.jpg',     'cover'),
(10,'/image/covers/sweet_home.jpg',    'cover'),
(11,'/image/covers/first_night.jpg',   'cover'),
(12,'/image/covers/estate_dev.jpg',    'cover'),
(13,'/image/covers/revenge_plan.jpg',  'cover'),
(14,'/image/covers/bloodhound.jpg',    'cover'),
(15,'/image/covers/time_limited.jpg',  'cover'),
(16,'/image/covers/killed_me.jpg',     'cover'),
(17,'/image/covers/rose_mansion.jpg',  'cover'),
(18,'/image/covers/your_letter.jpg',   'cover');

-- ============================================================
-- TABLE: Transaction
-- ============================================================
CREATE TABLE Transaction (
    user_id      INT,
    amount_money DECIMAL(10,2),
    tran_date    DATE,

    PRIMARY KEY (user_id, tran_date),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

INSERT INTO Transaction VALUES
(1, 50.00, '2024-01-01'),(2,100.00,'2024-01-02'),(3, 75.00,'2024-01-03'),
(4, 60.00, '2024-01-04'),(5, 40.00,'2024-01-05'),(6,120.00,'2024-01-06'),
(7,200.00, '2024-01-07'),(8, 30.00,'2024-01-08'),(9, 90.00,'2024-01-09'),
(10,110.00,'2024-01-10'),(11,55.00,'2024-01-11'),(12,70.00,'2024-01-12'),
(13,35.00, '2024-01-13'),(14,95.00,'2024-01-14'),(15,130.00,'2024-01-15'),
(16,170.00,'2024-01-16'),(17,210.00,'2024-01-17'),(18,20.00,'2024-01-18'),
(19,65.00, '2024-01-19'),(20,85.00,'2024-01-20');

-- ============================================================
-- TABLE: contain_Author
-- ============================================================
CREATE TABLE contain_Author (
    katoon_ID INT,
    user_id   INT,
    pen_name  VARCHAR(100),

    PRIMARY KEY (katoon_ID, user_id, pen_name),
    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (user_id)   REFERENCES User(user_id),
    FOREIGN KEY (pen_name)  REFERENCES Author(pen_name)
);

INSERT INTO contain_Author VALUES
(1,1,'Pen1'),(2,2,'Pen2'),(3,3,'Pen3'),(4,4,'Pen4'),(5,5,'Pen5'),
(6,6,'Pen6'),(7,7,'Pen7'),(8,8,'Pen8'),(9,9,'Pen9'),(10,10,'Pen10'),
(11,11,'Pen11'),(12,12,'Pen12'),(13,13,'Pen13'),(14,14,'Pen14'),(15,15,'Pen15'),
(16,16,'Pen16'),(17,17,'Pen17'),(18,18,'Pen18');

-- ============================================================
-- TABLE: manage_Author
-- ============================================================
CREATE TABLE manage_Author (
    katoon_ID INT,
    username  VARCHAR(100),

    PRIMARY KEY (katoon_ID, username),
    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (username)  REFERENCES Admin_Account(username)
);

INSERT INTO manage_Author VALUES
(1,'admin01'),(2,'admin02'),(3,'admin03'),(4,'admin04'),(5,'admin05'),
(6,'admin01'),(7,'admin02'),(8,'admin03'),(9,'admin04'),(10,'admin05');


USE katoonmodels_db;
SHOW TABLES;
SELECT * FROM Admin_Account;
katoonmodels_db.sql
17 KB