-- SQL – Assignment 5
USE `adventureworks`;
-- Exercise 1: Subquery
/* Questions 1: Viết 1 query lấy thông tin "Name" từ bảng Production.Product có name
của ProductSubcategory là 'Saddles'.
*/
SELECT 
    p.`Name`
FROM
    Product p
WHERE
    p.ProductSubcategoryID = (SELECT 
            ps.ProductSubcategoryID
        FROM
            ProductSubcategory ps
        WHERE
            ps.`Name` = 'Saddles');

-- Question 2: Thay đổi câu Query 1 để lấy được kết quả.
SELECT 
    p.`Name`
FROM
    Product p
WHERE
    p.ProductSubcategoryID IN (SELECT 
            ps.ProductSubcategoryID
        FROM
            ProductSubcategory ps
        WHERE
            ps.`Name` LIKE 'Bo%');

/* Question 3: Viết câu query trả về tất cả các sản phẩm có giá rẻ nhất (lowest ListPrice) và Touring
Bike (nghĩa là ProductSubcategoryID = 3)
*/
SELECT 
    p.`Name`
FROM
    Product p
WHERE
    p.ProductSubcategoryID = 3
        AND p.ListPrice = (SELECT 
            MIN(p.ListPrice)
        FROM
            Product p
        WHERE
            p.ProductSubcategoryID = 3);

-- Exercise 2: JOIN nhiều bảng
/* Question 1: Viết query lấy danh sách tên country và province được lưu trong
AdventureWorks2008sample database. 
*/
SELECT 
    cr.`name` AS country, sp.`name` AS province
FROM
    countryregion cr
        JOIN
    stateprovince sp ON cr.countryregioncode = sp.countryregioncode;
    
/* Question 2: Tiếp tục với câu query trước và thêm điều kiện là chỉ lấy country
Germany và Canada
*/
SELECT 
    cr.`name` AS Country, sp.`name` AS Province
FROM
    countryregion cr
        JOIN
    stateprovince sp ON cr.countryregioncode = sp.countryregioncode
WHERE
    cr.`name` IN ('germany' , 'canada');
    
/* Question 3: SalesOrderID, OrderDate and SalesPersonID. Từ bảng SalesPerson, chúng ta lấy cột
BusinessEntityID (là định danh của người sales), Bonus and the SalesYTD (là đã sale
được bao nhiêu người trong năm nay)
*/
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.SalesPersonID,
    sp.SalesPersonID AS `BusinessEntityID`,
    sp.Bonus,
    sp.SalesYTD
FROM
    SalesOrderHeader soh
        JOIN
    SalesPerson sp ON soh.SalesPersonID = sp.SalesPersonID;
 
/* Question 4: Sử dụng câu query, thêm cột JobTitle and xóa cột SalesPersonID và
BusinessEntityID.
*/
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    e.Title,
    sp.Bonus,
    sp.SalesYTD
FROM
    SalesOrderHeader soh
        JOIN
    SalesPerson sp ON soh.SalesPersonID = sp.SalesPersonID
        JOIN
    employee e ON sp.SalesPersonID = e.EmployeeID;