-- SQL – Assignment 6
-- Exercise 1: 
-- Questions a: Tạo table với các ràng buộc và kiểu dữ liệu và thêm ít nhất 3 bản ghi vào mỗi table
DROP DATABASE IF EXISTS projects;
CREATE DATABASE projects;
USE projects;
CREATE TABLE IF NOT EXISTS Employee
(
	EmployeeID 				VARCHAR(10) NOT NULL,
    EmployeeLastName 		VARCHAR(50),
    EmployeeFistName 		VARCHAR(50),
    EmployeeHireDate 		DATE 		NOT NULL,
-- EmployeeStatus: Nếu "1" là vẫn đang làm việc, "0" là đã nghỉ
    EmployeeStatus 			TINYINT 	NOT NULL DEFAULT '1',
    SupervisorID 			VARCHAR(10),
    SocialSecurityNumber 	VARCHAR(10) NOT NULL,
-- Key
	PRIMARY KEY (EmployeeID),
    FOREIGN KEY (SupervisorID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE IF NOT EXISTS Projects
(
	ProjectID 			VARCHAR(10) NOT NULL,
    EmployeeID 			VARCHAR(10) NOT NULL,
    ProjectName 		VARCHAR(50) NOT NULL,
    ProjectStartDate 	DATE 		NOT NULL,
    ProjectDescription 	TEXT,
    ProjectDetailt 		TEXT,
    ProjectCompletedOn 	DATE,
-- Key
	PRIMARY KEY (ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE IF NOT EXISTS Project_Modules
(
	ModuleID 				VARCHAR(10) NOT NULL,
    ProjectID 				VARCHAR(10) NOT NULL,
    EmployeeID 				VARCHAR(10) NOT NULL,
    ProjectModulesDate 		DATE 		NOT NULL,
    ProjectModulesCompledOn DATE,
    ProjectModulesDescription TEXT,
-- Key
	PRIMARY KEY (ModuleID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE IF NOT EXISTS Work_Done
(
	WorkDoneID 			VARCHAR(10) NOT NULL,
    EmployeeID 			VARCHAR(10) NOT NULL,
    ModuleID 			VARCHAR(10) NOT NULL,
    WorkDoneDate 		DATE,
    WorkDoneDescription TEXT,
-- Workdonestatus: Nếu "1" là vẫn đang làm, "0" là đã hoàn thành
    WorkDoneStatus 		TINYINT 	NOT NULL DEFAULT(1),
-- Key
	PRIMARY KEY (WorkDoneID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ModuleID) REFERENCES Project_Modules(ModuleID)
);

-- Insert dữ liệu vào database Projects
INSERT INTO Employee(EmployeeID, EmployeeLastName, EmployeeFistName, EmployeeHireDate, EmployeeStatus, SupervisorID, SocialSecurityNumber)
VALUES				('NV01'	   , 'Minh'			 , 'Nguyen Le'	   , '2019/10/10'	 , '1'			 , NULL		   , '125814175'),
					('NV02'	   , 'Ngoc'			 , 'Nguyen Bang'   , '2019/10/10'	 , '1'			 , 'NV01'	   , '125814176'),
                    ('NV03'	   , 'Huong'		 , 'Nguyen Thu'	   , '2019/10/10'	 , '0'		 	 , 'NV01'	   , '125814177'),
                    ('NV04'    , 'Hung'			 , 'Nguyen Manh'   , '2019/10/10'	 , '0'			 , 'NV01'	   , '125814178'),
                    ('NV05'	   , 'Ronaldo'		 , 'Cristiano'	   , '2019/12/30'	 , '1'			 , 'NV01'	   , '121415321');
INSERT INTO Projects(ProjectID, EmployeeID, ProjectName			, ProjectStartDate, ProjectDescription, ProjectDetailt, ProjectCompletedOn)
VALUES				('Pj01'	  , 'NV02'	  , 'Quan ly ban hang'	, '2019/04/04'	  , NULL			  , NULL		  , '2020/3/3'),
					('Pj02'	  , 'NV01'	  , 'Quan ly nhan vien'	, '2019/04/04'	  , NULL			  , NULL		  , '2019/6/6'),
                    ('Pj03'	  , 'NV03'	  , 'Quan ly cua hang'	, '2019/04/04'	  , NULL			  , NULL		  , '2019/5/5'),
                    ('Pj04'	  , 'NV03'	  , 'Quan ly thu vien'	, '2018/04/04'	  , NULL			  , NULL		  , '2019/6/6');
INSERT INTO Project_Modules	(ModuleID, ProjectID, EmployeeID, ProjectModulesDate, ProjectModulesCompledOn, ProjectModulesDescription)
VALUES						('MD01'	 , 'Pj01'	, 'NV01'	, '2020/3/1'		, Null					 , 'Dang thuc hien'),
							('MD02'	 , 'Pj01'	, 'NV02'	, '2020/2/2'		, NULL			 		 , 'Dang thuc hien'),
                            ('MD03'	 , 'Pj02'	, 'NV03'	, '2018/12/12'		, '2018/12/30'			 , NULL),
                            ('MD04'	 , 'Pj02'	, 'NV01'	, '2018/10/10'		, '2018/10/5'			 , NULL),
                            ('MD05'	 , 'Pj03'	, 'NV02'	, '2018/9/9'		, '2019/1/15'			 , NULL),
                            ('MD06'	 , 'Pj03'	, 'NV03'	, '2018/8/8'		, '2018/10/3'			 , NULL);
INSERT INTO Work_Done(WorkDoneID, EmployeeID, ModuleID, WorkDoneDate, WorkDoneDescription, WorkDoneStatus)
VALUES				 ('WD01'	, 'NV01'	, 'MD01'  , NULL		, NULL				 , '1'),
					 ('WD02'	, 'NV02'	, 'MD01'  , NULL		, NULL				 , '1'),
                     ('WD03'	, 'NV03'	, 'MD02'  , '2019/11/11', NULL				 , '0'),
                     ('WD04'	, 'NV04'	, 'MD02'  , '2019/11/05', NULL				 , '0'),
                     ('WD05'	, 'NV01'	, 'MD03'  , '2019/1/1'	, NULL				 , '0'),
                     ('WD06'	, 'NV02'	, 'MD03'  , '2019/1/5'	, NULL				 , '0'),
                     ('WD07'	, 'NV03'	, 'MD04'  , '2018/12/5'	, NULL				 , '0'),
                     ('WD08'	, 'NV04'	, 'MD04'  , '2018/12/30', NULL				 , '0'),
                     ('WD09'	, 'NV01'	, 'MD05'  , '2019/1/25'	, NULL				 , '0'),
                     ('WD10'	, 'NV02'	, 'MD05'  , '2019/2/1'	, NULL				 , '0'),
                     ('WD11'	, 'NV03'	, 'MD06'  , '2019/1/3'	, NULL				 , '0'),
                     ('WD12'	, 'NV04'	, 'MD06'  , '2019/3/2'	, NULL				 , '0');
                     
/* Questions b: Viết stored procedure (không có parameter) để Remove tất cả thông tin
project đã hoàn thành sau 3 tháng kể từ ngày hiện. In số lượng record đã
remove từ các table liên quan trong khi removing
*/
DROP PROCEDURE IF EXISTS Proc_remove_pj;
DELIMITER $$
CREATE PROCEDURE Proc_remove_pj()
BEGIN
-- Tạo bảng tạm projects để đếm số projects sẽ bị xoá
	DROP TABLE IF EXISTS temp_projects;
	CREATE TEMPORARY TABLE temp_projects
    (
		ProjectID VARCHAR(10) PRIMARY KEY
	);
    INSERT INTO	temp_projects 
	SELECT	ProjectID
    FROM	Projects
    WHERE	ProjectID IN ( SELECT ProjectID
							WHERE SUBDATE(CURDATE(),INTERVAL 90 DAY) >= ProjectCompletedOn);
	SELECT ProjectID as `Projects Deleted` FROM temp_projects;
    
-- Tạo bảng tạm modules
    DROP TABLE IF EXISTS temp_modules;
	CREATE TEMPORARY TABLE temp_modules
    (
		ModuleID VARCHAR(10) PRIMARY KEY
	);
    INSERT INTO temp_modules
	SELECT		ModuleID
    FROM		Project_Modules
    WHERE		ProjectID IN (SELECT ProjectID FROM temp_projects);
	SELECT ModuleID as `Modules Deleted` FROM temp_modules;

-- Tạo bảng tạm workdone
    DROP TABLE IF EXISTS temp_workdone;
	CREATE TEMPORARY TABLE temp_workdone
    (
		WorkDoneID VARCHAR(10) PRIMARY KEY
	);
    INSERT INTO	temp_workdone 
	SELECT		WorkDoneID
    FROM		Work_Done
    WHERE		ModuleID IN (SELECT ModuleID FROM temp_modules);
	SELECT WorkDoneID as `WorkDones Deleted` FROM temp_workdone;
    
-- Đếm số work_done, modules và projects bị xoá
	SELECT	(SELECT COUNT(WorkDoneID)	FROM temp_workdone)	AS Number_workdoneId_rm,
			(SELECT COUNT(ModuleID)		FROM temp_modules)	AS Number_module_rm,
			(SELECT COUNT(ProjectID)	FROM temp_projects)	AS Number_project_rm;
            
-- Xoá lần lượt các work_done rồi đến modules rồi đến projects
	DELETE FROM work_done		WHERE WorkDoneID	IN (SELECT *FROM temp_workdone);
	DELETE FROM project_modules	WHERE ModuleID		IN (SELECT *FROM temp_modules);
	DELETE FROM projects		WHERE ProjectID		IN (SELECT *FROM temp_projects);
END$$
DELIMITER ;
-- Gọi thủ tục xoá projects đã hoàn thành > 3 tháng
CALL Proc_remove_pj();

-- Question c: Viết stored procedure (có parameter) để in ra các module đang được thực hiện
DROP PROCEDURE IF EXISTS module_processing;
DELIMITER $$
CREATE PROCEDURE module_processing()
BEGIN
	SELECT *FROM project_modules pm
    WHERE pm.ProjectModulesCompledOn IS NULL;
END$$
DELIMITER ;
-- Gọi thủ tục module_processing
CALL module_processing();

/* Question d: Viết hàm (có parameter) trả về thông tin 1 nhân viên ĐÃ tham gia làm mặc
dù không ai giao việc cho nhân viên đó (trong bảng Works) 
(Nghĩa là nhân viên này có trong bảng Employee nhưng không có trong bảng Work_done)
- Return ra thông tin 1 nhân viên -> Bảng => Không dùng được function
*/
DROP PROCEDURE IF EXISTS not_assign;
DELIMITER $$
CREATE PROCEDURE not_assign()
BEGIN
	SELECT *FROM Employee e
    WHERE e.EmployeeID NOT IN (SELECT EmployeeID FROM Work_done);
END$$
DELIMITER ;
-- Gọi thủ tục not assign
CALL not_assign();

-- Assignment 7 
-- Exercise 1: Write the trigger(s) to prevent the case that the end user to input invalid Project Modules information
DROP TRIGGER IF EXISTS  t_info_users;
DELIMITER $$
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
VALUES						('MD09',	'Pj01',		'NV03',		'2019-04-04',		'2019-12-12',				'Hihi');