DROP DATABASE IF EXISTS customer_order_car;
CREATE DATABASE customer_order_car;
USE customer_order_car;

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    CustomerID	TINYINT AUTO_INCREMENT NOT NULL,
    Name 		VARCHAR(30),
    Phone 		VARCHAR(20),
    Email		VARCHAR(50),
    Address 	VARCHAR(50),
    Note 		VARCHAR(50),
-- Key
    PRIMARY KEY (CustomerID)
);

DROP TABLE IF EXISTS car;
CREATE TABLE car (
    CarID 	CHAR(5) NOT NULL,
    Maker	ENUM('HONDA', 'TOYOTA', 'NISSAN'),
    Model	VARCHAR(30),
    Year 	YEAR(4),
    Color	VARCHAR(20),
    Note	VARCHAR(30),
-- Key
    PRIMARY KEY (CarID)
);

DROP TABLE IF EXISTS car_order;
CREATE TABLE car_order (
    OrderID 		TINYINT AUTO_INCREMENT NOT NULL,
    CustomerID		TINYINT NOT NULL,
    CarID 			CHAR(5) NOT NULL,
    Amount 			TINYINT DEFAULT 1,
    SalePrice 		FLOAT,
    OrderDate 		DATE,
    DeliveryDate 	DATE,
    DeliveryAddress VARCHAR(30),
    Status 			ENUM('0', '1', '2') DEFAULT '0',
    Note VARCHAR(30),
-- Key
	PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID)	REFERENCES customer(CustomerID),
    FOREIGN KEY (CarID) 		REFERENCES car(CarID)
);

-- Question a
INSERT INTO customer(name, 					phone, 		email, 							address)
VALUES				('Nguyen Le Minh',		0347179633, 'nguyenminh.161298@gmail.com', 	'Bac Ninh'),
                    ('Nguyen Thu Huong',	0347179634, 'lethuhuong@gmail.com', 		'Ha Noi'),
                    ('Nguyen Thi Ngoc', 	0347179635, 'nguyenngoc@gmail.com', 		'Thanh Hoa'),
                    ('Nguyen Manh Hung', 	0347179636, 'manhhung@gmail.com', 			'Ha Noi'),
                    ('Cristiano Ronaldo', 	0946513245, 'ronaldo@gmail.com', 			'Portugal'),
                    ('Leonel Messi', 		094612349, 	'messi@gmail.com', 				'Barca'),
                    ('Tom Hiddleston', 		094612456, 	'tomh@gmail.com', 				'England'),
                    ('Calantha',			094612987, 	'calantha@gmail.com', 			'Poland'),
                    ('Elfleda', 			094612123, 	'elfleda@gmail.com', 			'Russia'),
                    ('Euphemia	', 			094612345, 	'euphemia@gmail.com', 			'Russia');
INSERT INTO car	(carid,		maker,		model,		year,	color,		note)
VALUES			('CAR01',	'HONDA',	'CR-V',		'2017','Black',		'Sedan'),
                ('CAR02',	'HONDA',	'City',		'2018','Grau',		'SUV'),
                ('CAR03',	'HONDA',	'Civic',	'2018','Black',		'Sedan'),
                ('CAR04',	'TOYOTA',	'Vios',		'2019','White',		'Sedan'),
                ('CAR05',	'TOYOTA',	'Yaris',	'2018','Red-black',	'Hatchback'),
                ('CAR06',	'TOYOTA',	'Camry',	'2019','Black',		'Sedan'),
                ('CAR07',	'TOYOTA',	'Fortuner',	'2016','White',		'SUV'),
                ('CAR08',	'NISSAN',	'Sunny',	'2015','Gray',		'Sedan'),
                ('CAR09',	'NISSAN',	'Teana',	'2016','Dark-red',	'Sedan'),
                ('CAR10',	'NISSAN',	'Navara',	'2016','Orange',	'Pick-up');
INSERT INTO car_order	(CustomerID,CarID,	Amount,		SalePrice,		OrderDate,		DeliveryDate,	DeliveryAddress,	Status)
VALUES					('1',		'CAR01','3',		'400000000',	'2019-10-20',	'2019-12-20',	'Ha Noi',			'1'),
						('2',		'CAR01','1',		'400000000',	'2019-11-16',	'2020-01-05',	'Ha Noi',			'1'),
                        ('3',		'CAR02','2',		'700000000',	'2019-06-16',	'2019-10-16',	'Ha Noi',			'1'),
                        ('1',		'CAR03','2',		'600000000',	'2018-07-20',	'2018-12-05',	'Bac Ninh',			'1'),
                        ('4',		'CAR05','1',		'1000000000',	'2018-09-20', 	Null,			'Ha Noi',			'2'),
                        ('5',		'CAR06','1',		'800000000',	'2019-06-20', 	'2020-01-20', 	'Ha Noi', 			'0');
-- Question b
SELECT 
    co.customerid,
    c.name,
    co.carid,
    SUM(co.amount) AS `So Luong Oto`
FROM
    customer c
        JOIN
    car_order co ON c.customerid = co.customerid
GROUP BY customerid
ORDER BY SUM(co.amount);

-- Question c
DELIMITER $$
DROP FUNCTION IF EXISTS maker_max_amount; $$
CREATE FUNCTION maker_max_amount()
RETURNS VARCHAR(30)
BEGIN
	DECLARE max_amount VARCHAR(30);
	SELECT maker INTO max_amount
    FROM car ca
    JOIN  car_order co ON ca.carid = co.carid
    WHERE SUM(amount) = max(sum(amount));
    RETURN max_amount;
END $$
DELIMIMTER;

SELECT maker_max_amount();
-- Question d
DELIMITER $$
DROP PROCEDURE IF EXISTS order_cancelled$$
CREATE PROCEDURE order_cancelled()
BEGIN
	DROP TABLE IF EXISTS temp_car_order;
    CREATE TEMPORARY TABLE temp_car_order
    (
		OrderID TINYINT PRIMARY KEY
    );
    INSERT INTO temp_car_order
    SELECT OrderID
    FROM car_order
    WHERE `Status` = '2';
	SELECT(SELECT count(`OrderID`) FROM temp_car_order) as order_cancelled;
    DELETE FROM car_order WHERE `status` = '2';
END; $$
DELIMITER ;

CALL order_cancelled();
-- Question e
DELIMITER $$
DROP PROCEDURE IF EXISTS order_car;$$
CREATE PROCEDURE order_car(IN CustomerID TINYINT)
BEGIN
	SELECT cu.name, orderid, amount, maker
    FROM car_order co JOIN car ca ON co.carid = ca.carid JOIN customer cu ON co.customerid = cu.customerid
    WHERE co.status = '0' AND CustomerID = co.CustomerID;
END; $$
DELIMITER ;

CALL order_car(5);

-- Question f
DELIMITER $$
DROP TRIGGER IF EXISTS validate_date;$$
CREATE TRIGGER validate_date
BEFORE INSERT ON car_order
FOR EACH ROW
BEGIN
		IF NEW.deliverydate < (NEW.orderdate + 15) THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ngày giao hàng phải lớn hơn ngày đặt hàng cộng 15 ngày';
        END IF;
END; $$
DELIMITER ;

INSERT INTO car_order(CustomerID,CarID,Amount,SalePrice,OrderDate,DeliveryDate,DeliveryAddress,Status)
VALUES ('5','CAR07','1','700000000','2020-01-05','2020-01-15','Ha Noi','0');