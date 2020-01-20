-- SQL - Assignment 3
-- Exercise 1: Continuing with Fresher Training Management Database 
-- Question 1: Add at least 10 records into created table
USE fresher;
INSERT INTO trainee (`Full_Name`, 			`Birth_Date`, 	`Gender`, 	`ET_IQ`,	`ET_Gmath`,	`ET_English`,	`Training_Class`,	`VTI_Account`)
VALUES				('Nguyen Le Minh',		'1998-12-16',	'Male',		16,			16,			40,				'VTI02',			'leminh'),
					('Nguyen Bang Ngoc',	'1998-12-12',	'Female',	16,			12,			45,				'VTI02',			'bangngoc'),
					('Nguyen Manh Hung',	'1998-10-2',	'Male',		20,			20,			50,				'VTI02',			'manhhung'),
					('Nguyen Ngoc Duy',		'1996-10-2',	'Male',		20,			20,			50,				'VTI02'	,			'ngocduy'),
					('Cristiano Ronaldo',	'1985-2-5',		'Male',		10,			10,			20,				'Juventus',			'ronaldo'),
					('Lionel Messi',		'1987-6-24',	'Male',		10,			5,			15,				'Barcelona',		'messi'),
					('Alex Ferguson',		'1941-12-31',	'Male',		5,			5,			40,				'Manu',				'alexf'),
					('Lady Gaga',			'1986-3-28',	'Unknown',	20,			15,			30,				'VTI03',			'ladygaga'),
					('Lalisa Manoban',		'1997-3-27',	'Female',	13,			14,			30,				'BlackPink',		'lisa'),
					('Jennie Kim',			'1996-1-16',	'Female',	8,			20,			30,				'BlackPink',		'jennie');
                    
-- Question 2: Query all the trainees who is passed the entry test, group them into different birth months    
SELECT 
    MONTH(Birth_Date) AS `Month of Birth`,
    GROUP_CONCAT(Full_Name SEPARATOR ', ') AS `Full Name`
FROM
    trainee
GROUP BY MONTH(Birth_Date);

-- Question 3:  Query the trainee who has the longest name.
SELECT 
    TraineeID,
    Full_Name,
    Birth_Date,
    Gender,
    LENGTH(Full_Name) AS `Name Length`
FROM
    trainee
WHERE
    LENGTH(Full_name) = (SELECT 
            MAX(LENGTH(full_name))
        FROM
            trainee);

-- Question 4:  Query all the ET-passed trainees.
SELECT 
    traineeid,
    full_name,
    birth_date,
    gender,
    et_iq,
    et_gmath,
    (et_iq + et_gmath) AS `Total`,
    et_english
FROM
    trainee
WHERE
    (et_iq + et_gmath) >= 20 AND et_iq >= 8
        AND et_gmath >= 8
        AND et_english >= 18;
        
-- Question 5: delete information of trainee who has TraineeID = 3
DELETE FROM trainee 
WHERE
    traineeid = 3;
    
-- Question 6: trainee who has TraineeID = 5 move "2" class. Let update information into database
UPDATE trainee 
SET 
    `training_class` = '2'
WHERE
    `traineeid` = '5';