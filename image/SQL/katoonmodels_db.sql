
/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

drop database if exists `katoonmodels_db`;
CREATE DATABASE `katoonmodels_db` DEFAULT CHARACTER SET utf8mb4;
USE `katoonmodels_db`;

DROP TABLE IF EXISTS manage_Author;
DROP TABLE IF EXISTS contain_Author;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Admin_Account;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Episode;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Katoon;

-- TABLE: Katoon
CREATE TABLE Katoon (
    katoon_ID INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    status VARCHAR(20),
    category VARCHAR(100),
    description TEXT,
    release_day VARCHAR(20),
    cover_image VARCHAR(255)
);

INSERT INTO Katoon VALUES
(1,'my body has been possessed by someone','Ongoing','Fantasy','lorem ipsum dolor sit amet, consectetur adipiscing elit','Monday','image/my body has been possessed by someone.jpg'),
(2,'my clueless love diary','Completed','Romance','lorem ipsum dolor sit amet','Tuesday','image/my clueless love diary.JPG'),
(3,'My Secretly Hot Husband','Ongoing','Romance','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','Wednesday','image/My Secretly Hot Husband.jpg'),
(4,'night owls summer skies','Completed','Slice of Life','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor','Thursday','image/night owls summer skies.png'),
(5,'omniscient reader','Ongoing','Fantasy','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam','Friday','image/omniscient reader.PNG'),
(6,'one husband is enough','Completed','Romance','lorem ipsum dolor sit amet, consectetur adipiscing elit','Saturday','image/one husband is enough.jpg'),
(7,'our secret alliance','Ongoing','Romance','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt','Sunday','image/our secret alliance.JPG'),
(8,'A Beast Tamed By The Villainess','Completed','Drama','lorem ipsum dolor sit amet','Monday','image/A Beast Tamed By The Villainess.jpg'),
(10,'sweet home','Completed','Horror','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore','Wednesday','image/sweet home.PNG'),
(11,'The First Night With The Duke','Ongoing','Romance','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','Friday','image/The First Night With The Duke.jpg'),
(12,'The Greatest Estate Developer','Completed','Comedy','lorem ipsum dolor sit amet','Tuesday','image/The Greatest Estate Developer.JPG'),
(13,'the little revenge plan of a villainess','Ongoing','Fantasy','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation','Thursday','image/the little revenge plan of a villainess.jpg'),
(14,'the mad bloodhound’s dying master','Completed','Action','lorem ipsum dolor sit amet, consectetur adipiscing elit','Saturday','image/the mad bloodhound_s dying master.jpg'),
(15,'the time limited villainess wishes for the f...','Ongoing','Fantasy','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat','Sunday','image/the time limited villainess wishes for the fall of the empire.jpg'),
(16,'to you who killed me','Completed','Drama','lorem ipsum dolor sit amet','Monday','image/to you who killed me.jpg'),
(17,'welcome to the rose mansion','Ongoing','Horror','lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','Thursday','image/welcome to the rose mansion.JPG'),
(18,'your letter','Completed','Romance','lorem ipsum dolor sit amet, consectetur adipiscing elit','Tuesday','image/your letter.JPG');

-- TABLE: Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(100),
    email VARCHAR(100),
    name VARCHAR(100),
    coin_info INT
);

INSERT INTO Users (password,email,name,coin_info) VALUES
('pass1','u1@mail.com','User1',100),
('pass2','u2@mail.com','User2',200),
('pass3','u3@mail.com','User3',150),
('pass4','u4@mail.com','User4',80),
('pass5','u5@mail.com','User5',60),
('pass6','u6@mail.com','User6',300),
('pass7','u7@mail.com','User7',500),
('pass8','u8@mail.com','User8',20),
('pass9','u9@mail.com','User9',90),
('pass10','u10@mail.com','User10',110);

-- TABLE: Author
CREATE TABLE Author (
    pen_name VARCHAR(100) PRIMARY KEY,
    email VARCHAR(100),
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
('Pen10','a10@mail.com','1010','0810101010','Author10');

-- TABLE: Episode
CREATE TABLE Episode (
    episode_id INT PRIMARY KEY,
    rating INT,
    favorite INT,
    category VARCHAR(100),
    katoon_ID INT,
    user_id INT,
    pen_name VARCHAR(100),
    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (pen_name) REFERENCES Author(pen_name)
);

INSERT INTO Episode VALUES
(101,5,1,'Action',1,1,'Pen1'),
(102,3,0,'Action',1,2,'Pen1'),
(103,4,1,'Action',1,3,'Pen1'),
(104,2,0,'Action',1,4,'Pen1'),
(105,5,1,'Action',1,5,'Pen1'),
(201,2,0,'Romance',2,1,'Pen2'),
(202,5,1,'Romance',2,2,'Pen2'),
(203,4,1,'Romance',2,3,'Pen2'),
(204,3,0,'Romance',2,4,'Pen2'),
(205,5,1,'Romance',2,5,'Pen2');

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
('admin5@mail.com','E','Five',29,'BKK'),
('admin6@mail.com','F','Six',31,'BKK'),
('admin7@mail.com','G','Seven',27,'BKK'),
('admin8@mail.com','H','Eight',33,'BKK'),
('admin9@mail.com','I','Nine',26,'BKK'),
('admin10@mail.com','J','Ten',38,'BKK');

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
('admin05','pass','2024-01-05','normal','admin5@mail.com'),
('admin06','pass','2024-01-06','normal','admin6@mail.com'),
('admin07','pass','2024-01-07','super','admin7@mail.com'),
('admin08','pass','2024-01-08','normal','admin8@mail.com'),
('admin09','pass','2024-01-09','normal','admin9@mail.com'),
('admin10','pass','2024-01-10','super','admin10@mail.com');

-- TABLE: Image
CREATE TABLE Image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(255),
    image_type VARCHAR(100)
);

INSERT INTO Image (image_url,image_type) VALUES
('images/my body has been possessed by someone.jpg','cover'),
('images/my clueless love diary.JPG','cover'),
('images/My Secretly Hot Husband.jpg','cover'),
('images/night owls summer skies.png','cover'),
('images/omniscient reader.PNG','cover'),
('images/one husband is enough.jpg','cover'),
('images/our secret alliance.JPG','cover'),
('images/A Beast Tamed By The Villainess.jpg','cover'),
('images/sweet home.PNG','cover'),
('images/your letter.JPG','cover');

-- TABLE: Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount_money DECIMAL(10,2),
    tran_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Transactions (user_id,amount_money,tran_date) VALUES
(1,50,'2024-01-01'),
(2,100,'2024-01-02'),
(3,75,'2024-01-03'),
(4,60,'2024-01-04'),
(5,40,'2024-01-05'),
(6,120,'2024-01-06'),
(7,200,'2024-01-07'),
(8,30,'2024-01-08'),
(9,90,'2024-01-09'),
(10,110,'2024-01-10');

-- TABLE: contain_Author
CREATE TABLE contain_Author (
    katoon_ID INT,
    user_id INT,
    pen_name VARCHAR(100),
    PRIMARY KEY (katoon_ID,user_id,pen_name),
    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
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
(10,10,'Pen10'),
(11,1,'Pen1');

-- TABLE: manage_Author
CREATE TABLE manage_Author (
    katoon_ID INT,
    username VARCHAR(100),
    PRIMARY KEY (katoon_ID,username),
    FOREIGN KEY (katoon_ID) REFERENCES Katoon(katoon_ID),
    FOREIGN KEY (username) REFERENCES Admin_Account(username)
);

INSERT INTO manage_Author VALUES
(1,'admin01'),
(2,'admin02'),
(3,'admin03'),
(4,'admin04'),
(5,'admin05'),
(6,'admin06'),
(7,'admin07'),
(8,'admin08'),
(10,'admin09'),
(11,'admin10');
