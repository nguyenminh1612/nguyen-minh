-- Assignment 7 
-- Exercise 1: Write the trigger(s) to prevent the case that the end user to input invalid Project Modules information
USE projects;

DELIMITER $$
DROP TRIGGER IF EXISTS  t_info_users;$$
CREATE TRIGGER t_info_users
BEFORE INSERT ON Project_Modules
FOR EACH ROW
BEGIN
		DECLARE P_ProjectStartDate, P_ProjectCompletedOn DATE;
SELECT 
    p.ProjectStartDate, p.ProjectCompletedOn
INTO P_ProjectStartDate , P_ProjectCompletedOn FROM
    Projects p
WHERE
    ProjectID = NEW.ProjectID;
        IF NEW.ProjectModulesDate < P_ProjectStartDate THEN SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Ngày bắt đầu module phải bằng hoặc sau ngày bắt đầu dự án';
		END IF;
		IF NEW.ProjectModulesCompledOn > P_ProjectCompletedOn THEN SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Ngày hoàn thành module phải bằng hoặc trước ngày hoàn thành dự án';
        END IF;
END $$
DELIMITER ;

-- Test trigger
INSERT INTO Project_Modules (ModuleID,	ProjectID,	EmployeeID,	ProjectModulesDate,	ProjectModulesCompledOn,	ProjectModulesDescription)
VALUES						('MD07',	'Pj01',		'NV03',		'2019-04-01',		'2019-12-13',				'Hihi');
INSERT INTO Project_Modules (ModuleID,	ProjectID,	EmployeeID,	ProjectModulesDate,	ProjectModulesCompledOn,	ProjectModulesDescription)
VALUES						('MD08',	'Pj01',		'NV03',		'2019-04-03',		'2020-03-04',				'Hihi');
INSERT INTO Project_Modules (ModuleID,	ProjectID,	EmployeeID,	ProjectModulesDate,	ProjectModulesCompledOn,	ProjectModulesDescription)
VALUES						('MD10',	'Pj01',		'NV03',		'2019-04-04',		'2019-12-12',				'Hihi');
		
-- Exercise 2: In Assignment 3, write a VIEW to Query all the ET-passed trainees
USE fresher;
DROP VIEW IF EXISTS v_et;
CREATE OR REPLACE VIEW v_et AS
    SELECT *FROM fresher.trainee
    WHERE
        (ET_IQ + ET_Gmath) >= 20 
        AND ET_IQ >= 8
        AND ET_Gmath >= 8
        AND ET_English >= 18;
SELECT *FROM v_et;