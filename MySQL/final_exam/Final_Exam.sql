DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management;
USE student_management;

-- Question a
DROP TABLE IF EXISTS Student;
CREATE TABLE Student
(
	RN 		INT NOT NULL,
    Name 	VARCHAR(50),
    Age 	TINYINT,
    Gender 	BIT,
-- KEY
	PRIMARY KEY (RN)
);

DROP TABLE IF EXISTS Subject;
CREATE TABLE Subject
(
	sID 	TINYINT NOT NULL,
    sName 	VARCHAR(50),
-- KEY
	PRIMARY KEY (sID)
);

DROP TABLE IF EXISTS StudentSubject;
CREATE TABLE StudentSubject
(
	RN 		INT NOT NULL,
    sID 	TINYINT NOT NULL,
    Mark 	FLOAT,
    Date 	DATE,
-- Key
	FOREIGN KEY (RN) 	REFERENCES Student(RN) 	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sID) 	REFERENCES Subject(sID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Student
VALUES	('001',	'Nguyen Le Minh',	'22',	0),
		('002',	'Nguyen Manh Hung',	'22',	0),
        ('003',	'Nguyen Thu Huong',	'22',	1),
        ('004',	'Nguyen Thi Ngoc',	'22',	1);
INSERT INTO Subject
VALUES	('01',	'MySQL'),
		('02',	'Java'),
        ('03',	'C#'),
        ('04',	'ASP .NET');
INSERT INTO StudentSubject
VALUES	('001',	'01',	'10',	'2020-01-08'),
		('001',	'02',	'5',	'2020-01-08'),
        ('002',	'01',	'8',	'2020-01-08'),
        ('003',	'03',	'8',	'2019-12-25'),
        ('004',	'01',	'7',	'2020-01-08'),
        ('004',	'03',	'6',	'2019-12-30');
        
-- Question b
-- a.
SELECT 
    su.sNAME
FROM
    Subject su
WHERE
    su.sID NOT IN (SELECT ss.sID FROM StudentSubject ss);
    
-- b.
SELECT 
    sNAME
FROM
    Subject su
WHERE
    su.sID IN (SELECT ss.sID
				FROM StudentSubject ss
				GROUP BY ss.sID
				HAVING COUNT(ss.sID) > 1);
        
-- Question c
DROP VIEW IF EXISTS StudentInfo;
CREATE VIEW StudentInfo AS
    SELECT 
        ss.RN,
        ss.sID,
        st.Name,
        st.Age,
        CASE st.Gender
            WHEN 0 THEN 'MALE'
            WHEN 1 THEN 'Female'
            ELSE 'Unknown'
        END AS Gender,
        su.sName,
        ss.Mark,
        ss.Date
    FROM
        StudentSubject ss
            JOIN
        Student st ON ss.RN = st.RN
            JOIN
        Subject su ON ss.sID = su.sID;
SELECT *FROM StudentInfo;

-- Question d
-- a.
DELIMITER $$
DROP TRIGGER IF EXISTS CasUpdate$$
CREATE TRIGGER CasUpdate
BEFORE UPDATE ON Subject
FOR EACH ROW
BEGIN
    UPDATE StudentSubject
    SET sID = NEW.sID
    WHERE sID = OLD.siD;
END; $$
DELIMITER ;

UPDATE Subject SET sID = '5' WHERE sID = '3';

-- b.
DELIMITER $$
DROP TRIGGER IF EXISTS CasDel$$
CREATE TRIGGER CasDel
BEFORE DELETE ON Subject 
FOR EACH ROW
BEGIN
END; $$
DELIMITER ;

DELETE FROM Subject WHERE sID = 1;

-- Question e
DELIMITER $$
DROP PROCEDURE IF EXISTS Delete_InfoStudent$$
CREATE PROCEDURE Delete_InfoStudent(IN StName VARCHAR(50), IN SsMark FLOAT)
BEGIN
	DELETE FROM StudentSubject
    WHERE Mark < SsMark;
	DELETE FROM Student 
WHERE
    Name = StName;
    IF Stname = '*' THEN 
    DELETE FROM Student;
    END IF;
END; $$
DELIMITER ;

CALL Delete_InfoStudent('Nguyen Le Minh','6');
CALL Delete_InfoStudent('*',0);