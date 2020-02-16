--Write a query to return users who have admin roles
Select EmployeeName, RoleName FROM Employees e
Join Roles r on (r.RoleID = e.RoleID)
WHere RoleName = 'Admin'

--Write a query to return users who have admin roles and information about their taverns
Select EmployeeName, RoleName, TavernName FROM Employees e
Join Roles r on (r.RoleID = e.RoleID)
Join Taverns t on (t.TavernID = e.TavernID)
Where RoleName = 'Admin'

--Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels
Select GuestName gn, ClassName, ClassLevel FROM GuestClass gc
JOIN Guest g on (gc.GuestID = g.GuestID)
Join Class c on (gc.ClassID = c.ClassID)
Order By gn asc

--Write a query that returns the top 10 sales in terms of sales price and what the services were
Select Top 10 GuestName, ServiceName, DatePurchased, AmountPurchased, ss.ServiceCost * ss.AmountPurchased as TotalSale From ServiceSales ss
Join Guest g on (ss.GuestID = g.GuestID)
Join Services s on (ss.ServiceID = s.ServiceID)
Order By TotalSale Desc

--Write a query that returns guests with 2 or more classes
Select GuestName, ClassName, ClassLevel FROM GuestClass gc
JOIN Guest g on (gc.GuestID = g.GuestID)
Join Class c on (gc.ClassID = c.ClassID)
WHERE g.GuestID IN (SELECT GuestID FROM GuestClass GROUP BY GuestID
HAVING COUNT(*) >1)

--Write a query that returns guests with 2 or more classes with levels higher than 5
Select GuestName, ClassName, ClassLevel FROM GuestClass gc
JOIN Guest g on (gc.GuestID = g.GuestID)
Join Class c on (gc.ClassID = c.ClassID)
WHERE ClassLevel >=5 and g.GuestID IN (SELECT GuestID FROM GuestClass GROUP BY GuestID
HAVING COUNT(*) >1)

--Write a query that returns guests with ONLY their highest level class
Select GuestName, MAX(ClassLevel) as MaxLevel from (Select g.GuestName, c.ClassName, ClassLevel FROM GuestClass gc 
JOIN Guest g on (gc.GuestID = g.GuestID)
Join Class c on (gc.ClassID = c.ClassID)) as Maxtbl
GROUP BY GuestName 

--Write a query that returns guests that stay within a date range. Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them)
Select GuestName, VisitDate_Start as [Visit Start], VisitDate_End as [Visit End] FROM RoomSale rs
Join Guest g ON (rs.GuestID = g.GuestID)
WHERE VisitDate_Start Between '2020-01-01' AND '2020-01-07'

--Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.
SELECT 
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
(
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT
		('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
	Else '' 
	END)
, 
	CASE WHEN refConst.CONSTRAINT_NAME iS NOT NULL
	Then 
		(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
	Else '' 
	END
, 
--Added the following Case Statement to Check for Primary Keys in the keys table in order
--to add in PK statement and Identity
	CASE WHEN keys.CONSTRAINT_NAME LIKE 'PK%'
	Then 
			' PRIMARY KEY IDENTITY(1,1) '
	Else '' 
	END
, 
',') as queryPiece From
INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN 
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
 WHERE cols.TABLE_NAME = 'Taverns'
UNION ALL
SELECT ')'; 