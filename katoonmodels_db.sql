
drop database if exists `katoonmodels_db`;
CREATE DATABASE `katoonmodels_db`;
USE `katoonmodels_db`;

-- DROP TABLE 
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

-- TABLE: Katoon
CREATE TABLE Katoon (
    katoon_ID INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    status VARCHAR(20),
    category VARCHAR(100),
    description VARCHAR(100)
);

INSERT INTO Katoon VALUES
(1,'Dragon Blaze','Ongoing','Action','Fire dragon'),
(2,'Love Signal','Completed','Romance','Love story'),
(3,'Cyber Hunt','Ongoing','Sci-Fi','AI world'),
(4,'Ghost House','Completed','Horror','Haunted'),
(5,'Sky Warriors','Ongoing','Fantasy','Flying war'),
(6,'Street Ball','Completed','Sport','Basketball life'),
(7,'Time Loop','Ongoing','Mystery','Time repeat'),
(8,'Dark Knight','Completed','Action','Dark hero'),
(9,'Ocean Tale','Ongoing','Adventure','Sea story'),
(10,'Magic School','Completed','Fantasy','Wizard life'),
(11,'Zombie City','Ongoing','Horror','Zombie world'),
(12,'Future War','Completed','Sci-Fi','Robot war'),
(13,'Heart Beat','Ongoing','Romance','Music love'),
(14,'Run Fast','Completed','Sport','Runner story'),
(15,'Lost World','Ongoing','Adventure','Unknown land'),
(16,'Shadow Game','Completed','Mystery','Secret game'),
(17,'Angel Wings','Ongoing','Fantasy','Angel story'),
(18,'Street Fight','Completed','Action','Fight gang'),
(19,'Deep Space','Ongoing','Sci-Fi','Space mission'),
(20,'Final Love','Completed','Romance','Last love');


-- TABLE: User

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    password VARCHAR(100),
    email VARCHAR(100),
    name VARCHAR(100),
    coin_info INT
);

-- INSERT INTO User VALUES
INSERT INTO User VALUES
(1,'pass1','u1@mail.com','User1',100),
(2,'pass2','u2@mail.com','User2',200),
(3,'pass3','u3@mail.com','User3',150),
(4,'pass4','u4@mail.com','User4',80),
(5,'pass5','u5@mail.com','User5',60),
(6,'pass6','u6@mail.com','User6',300),
(7,'pass7','u7@mail.com','User7',500),
(8,'pass8','u8@mail.com','User8',20),
(9,'pass9','u9@mail.com','User9',90),
(10,'pass10','u10@mail.com','User10',110),
(11,'pass11','u11@mail.com','User11',50),
(12,'pass12','u12@mail.com','User12',75),
(13,'pass13','u13@mail.com','User13',40),
(14,'pass14','u14@mail.com','User14',95),
(15,'pass15','u15@mail.com','User15',130),
(16,'pass16','u16@mail.com','User16',170),
(17,'pass17','u17@mail.com','User17',210),
(18,'pass18','u18@mail.com','User18',10),
(19,'pass19','u19@mail.com','User19',65),
(20,'pass20','u20@mail.com','User20',85);

-- TABLE: Author

CREATE TABLE Author (
    pen_name VARCHAR(100) UNIQUE,
    email VARCHAR(100) PRIMARY KEY,
    bank_account VARCHAR(100),
    phone CHAR(10),
    name VARCHAR(100)
);

INSERT INTO Author VALUES
('Pen1','a1@mail.com','111','0811111111','Author1'),
('Pen2','a2@mail.com','222','0822222222','Author2'),
('Pen3','a3@mail.com','333','0833333333','Author3'),
('Pen4','a4@mail.com','444','0844444444','Author4'),
('Pen5','a5@mail.com','555','0855555555','Author5'),
('Pen6','a6@mail.com','666','0866666666','Author6'),
('Pen7','a7@mail.com','777','0877777777','Author7'),
('Pen8','a8@mail.com','888','0888888888','Author8'),
('Pen9','a9@mail.com','999','0899999999','Author9'),
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

-- TABLE: Episode

CREATE TABLE if not exists Episode (
    episode_id INT PRIMARY KEY,
    rating INT,
    favorite INT,
    category VARCHAR(100),
    katoon_ID INT,
    user_id INT,
    pen_name VARCHAR(100),

    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (pen_name) REFERENCES Author(pen_name)
);

INSERT INTO Episode VALUES
-- Pen1
(0101, 5, 1, 'Action', 1, 1, 'Pen1'), (0102, 3, 0, 'Action', 1, 2, 'Pen1'), (0103, 4, 1, 'Action', 1, 3, 'Pen1'), (0104, 2, 0, 'Action', 1, 4, 'Pen1'), (0105, 5, 1, 'Action', 1, 5, 'Pen1'),
(0106, 4, 0, 'Action', 1, 6, 'Pen1'), (0107, 1, 0, 'Action', 1, 7, 'Pen1'), (0108, 5, 1, 'Action', 1, 8, 'Pen1'), (0109, 3, 1, 'Action', 1, 9, 'Pen1'), (0110, 4, 0, 'Action', 1, 10, 'Pen1'),
-- Pen2
(0201, 2, 0, 'Romance', 2, 1, 'Pen2'), (0202, 5, 1, 'Romance', 2, 2, 'Pen2'), (0203, 4, 1, 'Romance', 2, 3, 'Pen2'), (0204, 3, 0, 'Romance', 2, 4, 'Pen2'), (0205, 5, 1, 'Romance', 2, 5, 'Pen2'),
(0206, 1, 0, 'Romance', 2, 6, 'Pen2'), (0207, 4, 0, 'Romance', 2, 7, 'Pen2'), (0208, 5, 1, 'Romance', 2, 8, 'Pen2'), (0209, 2, 0, 'Romance', 2, 9, 'Pen2'), (0210, 3, 1, 'Romance', 2, 10, 'Pen2'),
-- Pen3
(0301, 5, 1, 'Sci-Fi', 3, 1, 'Pen3'), (0302, 4, 0, 'Sci-Fi', 3, 2, 'Pen3'), (0303, 3, 0, 'Sci-Fi', 3, 3, 'Pen3'), (0304, 5, 1, 'Sci-Fi', 3, 4, 'Pen3'), (0305, 2, 0, 'Sci-Fi', 3, 5, 'Pen3'),
(0306, 4, 1, 'Sci-Fi', 3, 6, 'Pen3'), (0307, 5, 1, 'Sci-Fi', 3, 7, 'Pen3'), (0308, 1, 0, 'Sci-Fi', 3, 8, 'Pen3'), (0309, 4, 0, 'Sci-Fi', 3, 9, 'Pen3'), (0310, 3, 1, 'Sci-Fi', 3, 10, 'Pen3'),
-- Pen4
(0401, 1, 0, 'Horror', 4, 1, 'Pen4'), (0402, 5, 1, 'Horror', 4, 2, 'Pen4'), (0403, 4, 0, 'Horror', 4, 3, 'Pen4'), (0404, 4, 1, 'Horror', 4, 4, 'Pen4'), (0405, 3, 0, 'Horror', 4, 5, 'Pen4'),
(0406, 5, 1, 'Horror', 4, 6, 'Pen4'), (0407, 2, 0, 'Horror', 4, 7, 'Pen4'), (0408, 4, 1, 'Horror', 4, 8, 'Pen4'), (0409, 5, 1, 'Horror', 4, 9, 'Pen4'), (0410, 3, 0, 'Horror', 4, 10, 'Pen4'),
-- Pen5
(0501, 5, 1, 'Fantasy', 5, 1, 'Pen5'), (0502, 2, 0, 'Fantasy', 5, 2, 'Pen5'), (0503, 4, 1, 'Fantasy', 5, 3, 'Pen5'), (0504, 3, 0, 'Fantasy', 5, 4, 'Pen5'), (0505, 5, 1, 'Fantasy', 5, 5, 'Pen5'),
(0506, 4, 0, 'Fantasy', 5, 6, 'Pen5'), (0507, 1, 0, 'Fantasy', 5, 7, 'Pen5'), (0508, 5, 1, 'Fantasy', 5, 8, 'Pen5'), (0509, 3, 1, 'Fantasy', 5, 9, 'Pen5'), (0510, 4, 0, 'Fantasy', 5, 10, 'Pen5'),
-- Pen6
(0601, 4, 1, 'Sport', 6, 1, 'Pen6'), (0602, 3, 0, 'Sport', 6, 2, 'Pen6'), (0603, 5, 1, 'Sport', 6, 3, 'Pen6'), (0604, 2, 0, 'Sport', 6, 4, 'Pen6'), (0605, 4, 0, 'Sport', 6, 5, 'Pen6'),
(0606, 5, 1, 'Sport', 6, 6, 'Pen6'), (0607, 3, 0, 'Sport', 6, 7, 'Pen6'), (0608, 1, 0, 'Sport', 6, 8, 'Pen6'), (0609, 5, 1, 'Sport', 6, 9, 'Pen6'), (0610, 4, 1, 'Sport', 6, 10, 'Pen6'),
-- Pen7
(0701, 3, 0, 'Mystery', 7, 1, 'Pen7'), (0702, 5, 1, 'Mystery', 7, 2, 'Pen7'), (0703, 4, 1, 'Mystery', 7, 3, 'Pen7'), (0704, 2, 0, 'Mystery', 7, 4, 'Pen7'), (0705, 5, 1, 'Mystery', 7, 5, 'Pen7'),
(0706, 1, 0, 'Mystery', 7, 6, 'Pen7'), (0707, 4, 0, 'Mystery', 7, 7, 'Pen7'), (0708, 5, 1, 'Mystery', 7, 8, 'Pen7'), (0709, 3, 0, 'Mystery', 7, 9, 'Pen7'), (0710, 4, 1, 'Mystery', 7, 10, 'Pen7'),
-- Pen8
(0801, 5, 1, 'Action', 8, 1, 'Pen8'), (0802, 4, 0, 'Action', 8, 2, 'Pen8'), (0803, 1, 0, 'Action', 8, 3, 'Pen8'), (0804, 3, 1, 'Action', 8, 4, 'Pen8'), (0805, 5, 1, 'Action', 8, 5, 'Pen8'),
(0806, 2, 0, 'Action', 8, 6, 'Pen8'), (0807, 4, 1, 'Action', 8, 7, 'Pen8'), (0808, 5, 1, 'Action', 8, 8, 'Pen8'), (0809, 3, 0, 'Action', 8, 9, 'Pen8'), (0810, 4, 0, 'Action', 8, 10, 'Pen8'),
-- Pen9
(0901, 2, 0, 'Adventure', 9, 1, 'Pen9'), (0902, 5, 1, 'Adventure', 9, 2, 'Pen9'), (0903, 4, 0, 'Adventure', 9, 3, 'Pen9'), (0904, 3, 1, 'Adventure', 9, 4, 'Pen9'), (0905, 5, 1, 'Adventure', 9, 5, 'Pen9'),
(0906, 1, 0, 'Adventure', 9, 6, 'Pen9'), (0907, 4, 1, 'Adventure', 9, 7, 'Pen9'), (0908, 5, 1, 'Adventure', 9, 8, 'Pen9'), (0909, 2, 0, 'Adventure', 9, 9, 'Pen9'), (0910, 4, 0, 'Adventure', 9, 10, 'Pen9'),
-- Pen10
(1001, 5, 1, 'Fantasy', 10, 1, 'Pen10'), (1002, 3, 0, 'Fantasy', 10, 2, 'Pen10'), (1003, 4, 1, 'Fantasy', 10, 3, 'Pen10'), (1004, 1, 0, 'Fantasy', 10, 4, 'Pen10'), (1005, 5, 1, 'Fantasy', 10, 5, 'Pen10'),
(1006, 4, 0, 'Fantasy', 10, 6, 'Pen10'), (1007, 2, 0, 'Fantasy', 10, 7, 'Pen10'), (1008, 5, 1, 'Fantasy', 10, 8, 'Pen10'), (1009, 4, 1, 'Fantasy', 10, 9, 'Pen10'), (1010, 3, 0, 'Fantasy', 10, 10, 'Pen10'),
-- Pen11
(1101, 4, 1, 'Horror', 11, 11, 'Pen11'), (1102, 1, 0, 'Horror', 11, 12, 'Pen11'), (1103, 5, 1, 'Horror', 11, 13, 'Pen11'), (1104, 3, 0, 'Horror', 11, 14, 'Pen11'), (1105, 4, 1, 'Horror', 11, 15, 'Pen11'),
(1106, 2, 0, 'Horror', 11, 16, 'Pen11'), (1107, 5, 1, 'Horror', 11, 17, 'Pen11'), (1108, 4, 0, 'Horror', 11, 18, 'Pen11'), (1109, 3, 1, 'Horror', 11, 19, 'Pen11'), (1110, 5, 1, 'Horror', 11, 20, 'Pen11'),
-- Pen12
(1201, 3, 0, 'Sci-Fi', 12, 11, 'Pen12'), (1202, 5, 1, 'Sci-Fi', 12, 12, 'Pen12'), (1203, 4, 1, 'Sci-Fi', 12, 13, 'Pen12'), (1204, 2, 0, 'Sci-Fi', 12, 14, 'Pen12'), (1205, 5, 1, 'Sci-Fi', 12, 15, 'Pen12'),
(1206, 4, 0, 'Sci-Fi', 12, 16, 'Pen12'), (1207, 1, 0, 'Sci-Fi', 12, 17, 'Pen12'), (1208, 5, 1, 'Sci-Fi', 12, 18, 'Pen12'), (1209, 3, 0, 'Sci-Fi', 12, 19, 'Pen12'), (1210, 4, 1, 'Sci-Fi', 12, 20, 'Pen12'),
-- Pen13
(1301, 5, 1, 'Romance', 13, 11, 'Pen13'), (1302, 2, 0, 'Romance', 13, 12, 'Pen13'), (1303, 4, 1, 'Romance', 13, 13, 'Pen13'), (1304, 5, 1, 'Romance', 13, 14, 'Pen13'), (1305, 3, 0, 'Romance', 13, 15, 'Pen13'),
(1306, 4, 1, 'Romance', 13, 16, 'Pen13'), (1307, 5, 1, 'Romance', 13, 17, 'Pen13'), (1308, 1, 0, 'Romance', 13, 18, 'Pen13'), (1309, 4, 0, 'Romance', 13, 19, 'Pen13'), (1310, 2, 0, 'Romance', 13, 20, 'Pen13'),
-- Pen14
(1401, 1, 0, 'Sport', 14, 11, 'Pen14'), (1402, 5, 1, 'Sport', 14, 12, 'Pen14'), (1403, 4, 0, 'Sport', 14, 13, 'Pen14'), (1404, 4, 1, 'Sport', 14, 14, 'Pen14'), (1405, 3, 0, 'Sport', 14, 15, 'Pen14'),
(1406, 5, 1, 'Sport', 14, 16, 'Pen14'), (1407, 2, 0, 'Sport', 14, 17, 'Pen14'), (1408, 5, 1, 'Sport', 14, 18, 'Pen14'), (1409, 4, 1, 'Sport', 14, 19, 'Pen14'), (1410, 3, 0, 'Sport', 14, 20, 'Pen14'),
-- Pen15
(1501, 5, 1, 'Adventure', 15, 11, 'Pen15'), (1502, 3, 0, 'Adventure', 15, 12, 'Pen15'), (1503, 4, 1, 'Adventure', 15, 13, 'Pen15'), (1504, 2, 0, 'Adventure', 15, 14, 'Pen15'), (1505, 5, 1, 'Adventure', 15, 15, 'Pen15'),
(1506, 4, 0, 'Adventure', 15, 16, 'Pen15'), (1507, 1, 0, 'Adventure', 15, 17, 'Pen15'), (1508, 5, 1, 'Adventure', 15, 18, 'Pen15'), (1509, 3, 1, 'Adventure', 15, 19, 'Pen15'), (1510, 4, 0, 'Adventure', 15, 20, 'Pen15'),
-- Pen16
(1601, 4, 1, 'Mystery', 16, 11, 'Pen16'), (1602, 2, 0, 'Mystery', 16, 12, 'Pen16'), (1603, 5, 1, 'Mystery', 16, 13, 'Pen16'), (1604, 3, 0, 'Mystery', 16, 14, 'Pen16'), (1605, 5, 1, 'Mystery', 16, 15, 'Pen16'),
(1606, 1, 0, 'Mystery', 16, 16, 'Pen16'), (1607, 4, 1, 'Mystery', 16, 17, 'Pen16'), (1608, 5, 1, 'Mystery', 16, 18, 'Pen16'), (1609, 2, 0, 'Mystery', 16, 19, 'Pen16'), (1610, 4, 0, 'Mystery', 16, 20, 'Pen16'),
-- Pen17
(1701, 3, 0, 'Fantasy', 17, 11, 'Pen17'), (1702, 5, 1, 'Fantasy', 17, 12, 'Pen17'), (1703, 4, 1, 'Fantasy', 17, 13, 'Pen17'), (1704, 2, 0, 'Fantasy', 17, 14, 'Pen17'), (1705, 5, 1, 'Fantasy', 17, 15, 'Pen17'),
(1706, 1, 0, 'Fantasy', 17, 16, 'Pen17'), (1707, 4, 0, 'Fantasy', 17, 17, 'Pen17'), (1708, 5, 1, 'Fantasy', 17, 18, 'Pen17'), (1709, 3, 1, 'Fantasy', 17, 19, 'Pen17'), (1710, 5, 1, 'Fantasy', 17, 20, 'Pen17'),
-- Pen18
(1801, 5, 1, 'Action', 18, 11, 'Pen18'), (1802, 4, 0, 'Action', 18, 12, 'Pen18'), (1803, 2, 0, 'Action', 18, 13, 'Pen18'), (1804, 3, 1, 'Action', 18, 14, 'Pen18'), (1805, 5, 1, 'Action', 18, 15, 'Pen18'),
(1806, 1, 0, 'Action', 18, 16, 'Pen18'), (1807, 4, 1, 'Action', 18, 17, 'Pen18'), (1808, 5, 1, 'Action', 18, 18, 'Pen18'), (1809, 3, 0, 'Action', 18, 19, 'Pen18'), (1810, 4, 1, 'Action', 18, 20, 'Pen18'),
-- Pen19
(1901, 2, 0, 'Sci-Fi', 19, 11, 'Pen19'), (1902, 5, 1, 'Sci-Fi', 19, 12, 'Pen19'), (1903, 4, 0, 'Sci-Fi', 19, 13, 'Pen19'), (1904, 3, 1, 'Sci-Fi', 19, 14, 'Pen19'), (1905, 5, 1, 'Sci-Fi', 19, 15, 'Pen19'),
(1906, 1, 0, 'Sci-Fi', 19, 16, 'Pen19'), (1907, 4, 1, 'Sci-Fi', 19, 17, 'Pen19'), (1908, 5, 1, 'Sci-Fi', 19, 18, 'Pen19'), (1909, 3, 0, 'Sci-Fi', 19, 19, 'Pen19'), (1910, 4, 0, 'Sci-Fi', 19, 20, 'Pen19'),
-- Pen20
(2001, 5, 1, 'Romance', 20, 11, 'Pen20'), (2002, 4, 0, 'Romance', 20, 12, 'Pen20'), (2003, 3, 1, 'Romance', 20, 13, 'Pen20'), (2004, 2, 0, 'Romance', 20, 14, 'Pen20'), (2005, 5, 1, 'Romance', 20, 15, 'Pen20'),
(2006, 4, 0, 'Romance', 20, 16, 'Pen20'), (2007, 1, 0, 'Romance', 20, 17, 'Pen20'), (2008, 5, 1, 'Romance', 20, 18, 'Pen20'), (2009, 3, 1, 'Romance', 20, 19, 'Pen20'), (2010, 4, 1, 'Romance', 20, 20, 'Pen20');

-- TABLE: Admin
CREATE TABLE Admin (
    email VARCHAR(100) PRIMARY KEY,
    fname VARCHAR(100),
    lname VARCHAR(100),
    age INT,
    address VARCHAR(100)
);

INSERT INTO Admin VALUES
('admin1@mail.com','A','One',30,'BKK'),
('admin2@mail.com','B','Two',28,'BKK'),
('admin3@mail.com','C','Three',35,'BKK'),
('admin4@mail.com','D','Four',40,'BKK'),
('admin5@mail.com','E','Five',29,'BKK');


-- TABLE: Admin_Account

CREATE TABLE Admin_Account (
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100),
    login_log DATE,
    role VARCHAR(50),
    admin_email VARCHAR(100),

    FOREIGN KEY (admin_email) REFERENCES Admin(email)
);

INSERT INTO Admin_Account VALUES
('admin01','pass','2024-01-01','super','admin1@mail.com'),
('admin02','pass','2024-01-02','normal','admin2@mail.com'),
('admin03','pass','2024-01-03','normal','admin3@mail.com'),
('admin04','pass','2024-01-04','super','admin4@mail.com'),
('admin05','pass','2024-01-05','normal','admin5@mail.com');


-- TABLE: Image

CREATE TABLE Image (
    image_id INT PRIMARY KEY,
    image_url BLOB,
    image_type VARCHAR(100)
);

INSERT INTO Image VALUES
(1,LOAD_FILE('/image_path/image_fileName.png'),'cover'),
(2,LOAD_FILE('/image_path/image_fileName.png'),'profile'),
(3,'img3.jpg','cover'),
(4,'img4.jpg','profile'),
(5,'img5.jpg','cover'),
(6,'img6.jpg','profile'),
(7,'img7.jpg','cover'),
(8,'img8.jpg','profile'),
(9,'img9.jpg','cover'),
(10,'img10.jpg','profile'),
(11,'img11.jpg','cover'),
(12,'img12.jpg','profile'),
(13,'img13.jpg','cover'),
(14,'img14.jpg','profile'),
(15,'img15.jpg','cover'),
(16,'img16.jpg','profile'),
(17,'img17.jpg','cover'),
(18,'img18.jpg','profile'),
(19,'img19.jpg','cover'),
(20,'img20.jpg','profile');

-- TABLE: Transaction

CREATE TABLE Transaction (
    user_id INT,
    amount_money DECIMAL(10,2),
    tran_date DATE,

    PRIMARY KEY (user_id, tran_date),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

INSERT INTO Transaction VALUES
(1,50,'2024-01-01'),
(2,100,'2024-01-02'),
(3,75,'2024-01-03'),
(4,60,'2024-01-04'),
(5,40,'2024-01-05'),
(6,120,'2024-01-06'),
(7,200,'2024-01-07'),
(8,30,'2024-01-08'),
(9,90,'2024-01-09'),
(10,110,'2024-01-10'),
(11,55,'2024-01-11'),
(12,70,'2024-01-12'),
(13,35,'2024-01-13'),
(14,95,'2024-01-14'),
(15,130,'2024-01-15'),
(16,170,'2024-01-16'),
(17,210,'2024-01-17'),
(18,20,'2024-01-18'),
(19,65,'2024-01-19'),
(20,85,'2024-01-20');

-- TABLE: contain_Author

CREATE TABLE contain_Author (
    katoon_ID INT,
    user_id INT,
    pen_name VARCHAR(100),

    PRIMARY KEY (katoon_ID, user_id, pen_name),

    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (pen_name) REFERENCES Author(pen_name)
);

INSERT INTO contain_Author VALUES
(1,1,'Pen1'),
(2,2,'Pen2'),
(3,3,'Pen3'),
(4,4,'Pen4'),
(5,5,'Pen5'),
(6,6,'Pen6'),
(7,7,'Pen7'),
(8,8,'Pen8'),
(9,9,'Pen9'),
(10,10,'Pen10'),
(11,11,'Pen11'),
(12,12,'Pen12'),
(13,13,'Pen13'),
(14,14,'Pen14'),
(15,15,'Pen15'),
(16,16,'Pen16'),
(17,17,'Pen17'),
(18,18,'Pen18'),
(19,19,'Pen19'),
(20,20,'Pen20');

-- TABLE: manage_Author

CREATE TABLE manage_Author (
    katoon_ID INT,
    username VARCHAR(100),

    PRIMARY KEY (katoon_ID, username),

    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (username) REFERENCES Admin_Account(username)
);

INSERT INTO manage_Author VALUES
(1,'admin01'),
(2,'admin02'),
(3,'admin03'),
(4,'admin04'),
(5,'admin05');

