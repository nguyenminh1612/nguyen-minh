-- SQL - Assignment 2
-- Exercise 1: Design a table
DROP DATABASE IF EXISTS fresher;
CREATE DATABASE fresher;
USE fresher;

-- Question 1: Create the tables
DROP TABLE IF EXISTS Trainee;
CREATE TABLE Trainee (
	`TraineeID`			INT				NOT NULL AUTO_INCREMENT,
    `Full_Name`			VARCHAR(50)		NOT NULL,
    `Birth_Date`		DATE			NOT NULL,
    `Gender`			ENUM('Male','Female','Unknown')	NOT NULL,
    `ET_IQ`				TINYINT			NOT NULL	CHECK(`ET_IQ` 		BETWEEN 0 AND 20),
    `ET_Gmath`			TINYINT			NOT NULL	CHECK(`ET_Gmath` 	BETWEEN 0 AND 20),
    `ET_English`		TINYINT			NOT NULL	CHECK(`ET_English` 	BETWEEN 0 AND 50),
    `Training_Class`	VARCHAR(10)		NOT NULL,
    `Evaluation_Notes`	VARCHAR(255),
    
-- Primary key
    PRIMARY KEY (`TraineeID`)
);

-- Question 2: Change the table TRAINEE to add one more field named VTI_Account which is a not-null &unique field
ALTER TABLE Trainee ADD COLUMN `VTI_Account` VARCHAR(30) NOT NULL UNIQUE;

-- Exercise 2: Data Types
CREATE TABLE Ex2 (
    `ID` 			INT 		NOT NULL AUTO_INCREMENT,
    `Name`			VARCHAR(30) NOT NULL,
    `Code` 			CHAR(5)		NOT NULL,
    `ModifiedDate` 	TIMESTAMP	NOT NULL,
    
-- Primary key
    PRIMARY KEY (`ID`)
);

-- Exercise 3: Data Types (2)
CREATE TABLE ex3 (
    `ID` 			INT 		NOT NULL AUTO_INCREMENT,
    `Name` 			VARCHAR(30) NOT NULL,
    `Birthdate` 	DATE 		NOT NULL,
    `Gender` 		BIT,
    `IsDeleteFlag`	BIT 		NOT NULL,
    
-- Primary key
    PRIMARY KEY (`ID`)
);