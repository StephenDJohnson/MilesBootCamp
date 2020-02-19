--Write a query to return a “report” of all users and their roles
Select EmployeeName, RoleName, RoleDescription, TavernName FROM Employees e
JOIN Roles r on (r.RoleID = e.RoleID)
JOIN Taverns t on (t.TavernID = e.TavernID)

--Write a query to return all classes and the count of guests that hold those classes

Select ClassName, Count(*) ClassName --NOTE - ALIAS IS NOT WORKING HERE, NOTS SURE WHY.
FROM 
	GuestClass gc
	JOIN Class c on (c.ClassID = gc.ClassID)
	GROUP BY ClassName

--Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
	--Function inputs the level and returns a string with the Level Classification
IF OBJECT_ID (N'dbo.LevelDescr',N'IF') Is Not NULL
DROP FUNCTION dbo.LevelDescr;
GO
CREATE FUNCTION dbo.LevelDescr (@level int)
RETURNS varchar(50)
AS   
BEGIN  
    DECLARE @ret int;
	DECLARE @lev varchar(50);  
    SELECT @ret = (@level)
     IF (@ret <=3)
        SET @lev = 'Beginner'; 
	IF (@ret BETWEEN 4 AND 5)
        SET @lev = 'Intermediate'; 
	IF (@ret >5)
        SET @lev = 'Expert';
	RETURN @lev; 
END;
	--Query using above function
Select GuestName, ClassName, ClassLevel, dbo.LevelDescr(ClassLevel) as [Level Range] FROM GuestClass gc
JOIN Guest g on (gc.GuestID = g.GuestID)
Join Class c on (gc.ClassID = c.ClassID)
Order By GuestName asc

--Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
IF OBJECT_ID (N'dbo.RoomF',N'IF') Is Not NULL
DROP FUNCTION dbo.RoomF;
GO
CREATE FUNCTION dbo.RoomF (@date date)
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT r.RoomNumber, t.TavernName  
    FROM RoomSale AS rs   
    JOIN Rooms AS r ON rs.RoomID = r.roomID  
    JOIN Taverns AS t ON t.TavernID = r.TavernID   
    WHERE @date BETWEEN rs.VisitDate_Start AND rs.VisitDate_End
);
	--QUERY USING ABOVE FUNCTION
Select * From dbo.RoomF('2020-01-07') 

--Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
	--Modified to take two ints and compare to room cost
IF OBJECT_ID (N'dbo.RoomR',N'IF') Is Not NULL
DROP FUNCTION dbo.RoomR;
GO
CREATE FUNCTION dbo.RoomR (@min int, @max int)
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT RoomNumber, RoomCost, t.TavernName  
    FROM Rooms as r  
    JOIN Taverns AS t ON t.TavernID = r.TavernID   
    WHERE RoomCost BETWEEN @min AND @max
);
	--QUERY USING ABOVE FUNCTION
Select * From dbo.RoomR(75, 100)  
