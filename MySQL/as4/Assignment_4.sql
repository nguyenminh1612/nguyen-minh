-- SQL – Assignment 4
-- Exercise 1:
-- Question 1: Create the tables
DROP DATABASE IF EXISTS Department_manager;
CREATE DATABASE IF NOT EXISTS Department_manager;
USE Department_manager;

CREATE TABLE Department (
    Department_Number	VARCHAR(10)	 NOT NULL,
    Department_Name 	VARCHAR(50) NOT NULL,

-- Key
    PRIMARY KEY (Department_Number)
);

CREATE TABLE Employee_Table (
    Employee_Number 		VARCHAR(10)	 NOT NULL,
    Employee_Name 			VARCHAR(50)	 NOT NULL,
    Department_Number 		VARCHAR(10)	 NOT NULL,
    
-- Key
    PRIMARY KEY (Employee_Number),
    FOREIGN KEY (Department_Number) REFERENCES Department (Department_Number)
);

CREATE TABLE Employee_Skill_Table (
    Employee_Number 		VARCHAR(10)	 NOT NULL,
    Skill_Code 				VARCHAR(50),
    Date_Registered 		DATE		 NOT NULL,
-- Key
    FOREIGN KEY (Employee_Number) REFERENCES Employee_Table (Employee_Number)
);

-- Question 2: Add at least 10 records into created table
INSERT INTO Department	(Department_Number, Department_Name)
VALUES					('D001',			'General Meeting of Shareholders'),
						('D002',			'Administrative Council'),
                        ('D003',			'General manager'),
                        ('D004',			'Deputy General Manager'),
                        ('D005',			'Technical'),
                        ('D006',			'Financial'),
                        ('D007',			'Security'),
                        ('D008',			'Business'),
                        ('D009',			'Accouting'),
                        ('D010',			'Representative');

INSERT INTO Employee_Table	(Employee_Number,	Employee_Name,		Department_Number)
VALUES						('E001',			'Nguyen Le Minh',	'D001'),
							('E002',			'Nguyen Manh Hung',	'D002'),
							('E003',			'Le Thu Huong',		'D002'),
                            ('E004',			'Nguyen Bang Ngoc',	'D002'),
                            ('E005',			'Nguyen Ngoc Duy',	'D002'),
                            ('E006',			'Cristiano Ronaldo','D004'),
                            ('E007',			'Lionel Messi',		'D005'),
                            ('E008',			'Lady Gaga',		'D006'),
                            ('E009',			'Lalisa Manoban',	'D008'),
                            ('E010',			'Jennie Kim',		'D009'),
                            ('E011',			'Nancy McDonie',	'D010'),
                            ('E012',			'Joao Felix',		'D003'),
                            ('E013',			'Mohamed Salah',	'D007'),
                            ('E014',			'Sergio Ramos',		'D007'),
                            ('E015',			'Virgil van Dijk',	'D007'),
                            ('E016',			'NGolo Kante',		'D007');

INSERT INTO Employee_Skill_Table	(Employee_Number,	Skill_Code,	Date_Registered)
VALUES								('E001',			'MySQL',			'2019-12-5'),
									('E002',			'Java',				'2019-6-20'),
                                    ('E003',			'MySQL',			'2019-12-6'),
                                    ('E001',			'Java',				'2019-11-10'),
                                    ('E002',			'MySQL',			'2019-12-5'),
                                    ('E004',			'Sql Servere',		'2019-7-20'),
                                    ('E006',			'Heading',			'2016-12-20'),
                                    ('E006',			'Knuckle',			'2017-11-19'),
                                    ('E006',			'Sprint',			'2018-10-16'),
                                    ('E016',			'Destroyer',		'2019-12-10'),
                                    ('E015',			'Build Up',			'2019-7-13'),
                                    ('E016',			'Box-to-box',		'2018-10-10');
                                    
-- Question 3: Query all Employee (include: name) who has Java skill
SELECT 
    et.Employee_Number, et.Employee_Name, est.Skill_Code
FROM
    Employee_Table et
        JOIN
    Employee_Skill_Table est ON et.Employee_Number = est.Employee_Number
WHERE
    est.Skill_Code = 'Java';

-- Question 4: Query all department which has more than 3 employee
SELECT 
    d.Department_Number,
    d.Department_Name,
    COUNT(et.Employee_Number) AS `Number of Employees`
FROM
    Department d,
    Employee_Table et
WHERE
    d.Department_Number = et.Department_Number
GROUP BY d.Department_Number
HAVING `Number of Employees` > 3;

-- Question 5: Query all employee of each department.
SELECT 
    et.Department_Number,
    d.Department_Name,
    et.Employee_Number,
    et.Employee_Name
FROM
    Department d,
    Employee_Table et
WHERE
    d.Department_Number = et.Department_Number
GROUP BY et.Employee_Number
ORDER BY et.Department_Number;

-- Question 6: Query all Employee (include: name) who has more than 1 skills.
SELECT 
    et.Employee_Number,
    et.Employee_Name,
    COUNT(s.Employee_Number) AS `Number of Skills`
FROM
    Employee_Skill_Table s,
    Employee_Table et
WHERE
    s.Employee_Number = et.Employee_Number
GROUP BY et.Employee_Number
HAVING `Number of Skills` > 1;