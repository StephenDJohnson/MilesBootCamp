DROP TABLE IF EXISTS ServiceSales, SupplySales, GuestClass, Class, GuestStatusLink, Guest, GuestStatus, Inventory, TavernOrders, Supplies, Statuses, Services, Roles, Employees, Locations, Owners, Taverns;

/*Tables */
CREATE TABLE Taverns (
	TavernID int PRIMARY KEY IDENTITY(1,1),
	TavernName varchar(100),
	LocationID int,
	Floors int,
	OwnerID int
);

CREATE TABLE Owners (
	OwnerID int PRIMARY KEY IDENTITY(1,1),
	OwnerName varchar(100)
);

CREATE TABLE Locations (
	LocationID int PRIMARY KEY IDENTITY(1,1),
	Address varchar(100),
	City varchar(100),
	Country varchar(100)
);


CREATE TABLE Roles (
	RoleID int PRIMARY KEY IDENTITY(1,1),
	RoleName varchar(100),
	RoleDescription varchar(250)
);

CREATE TABLE Employees (
	EmployeeID int PRIMARY KEY IDENTITY(1,1),
	EmployeeName varchar(100),
	TavernID int,
	Pay int,
	RoleID int
);

CREATE TABLE Services (
	ServiceID int IDENTITY(1,1),
	ServiceName varchar(100),
	ServiceDescription varchar(250),
	StatusID int,
	ServiceCost int,
	TavernID int,
    PRIMARY KEY (ServiceID, ServiceCost)
);


CREATE TABLE Statuses (
	StatusID int PRIMARY KEY IDENTITY(1,1),
	StatusName varchar(100)
);

CREATE TABLE Supplies (
	SupplyID int IDENTITY(1,1),
	SupplyName varchar(100),
	SupplyDescription varchar(250),
	UnitOfMeasure varchar(50),
	SupplyCost int,
    PRIMARY KEY (SupplyID, SupplyCost)
);

CREATE TABLE TavernOrders (
	OrderID int PRIMARY KEY IDENTITY(1,1),
	SupplyID int,
	Amount int,
	SupplyCost int,
    TotalCost int,
	TavernID int,
	DateRcvd date
);

CREATE TABLE Inventory (
	TavernID int,
	SupplyID int,
	CurrentCount int,
	DateUpdated date,
    SupplyCost int
);


CREATE TABLE GuestStatus (
	GuestStatusID int PRIMARY KEY IDENTITY(1,1),
	StatusName varchar(100)	
);

CREATE TABLE Guest (
	GuestID int PRIMARY KEY (GuestID) IDENTITY(1,1),
	GuestName varchar(100),
	GuestBday date,
	GuestCday date
);

CREATE TABLE GuestStatusLink (
	GuestID int,
	GuestStatusID int 
);

CREATE TABLE Class (
	ClassID int PRIMARY KEY IDENTITY(1,1),
	ClassName varchar(100)
);

CREATE TABLE GuestClass (
	GuestID int FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
	ClassID int FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
	ClassLevel int,
	PRIMARY KEY (GuestID, ClassID)
);

CREATE TABLE SupplySales (
	OrderID int IDENTITY(1,1),
	GuestID int FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
	SupplyID int,
	TavernID int,
	AmountPurchased int,
	DatePurchased date,
	SupplyCost int
);

CREATE TABLE ServiceSales (
	OrderID int IDENTITY(1,1),
	GuestID int FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
	ServiceID int,
	TavernID int,
	ServiceCost int,
	DatePurchased date,
	AmountPurchased int
    
);

/*Foreign Key SetUp */

ALTER TABLE Taverns ADD FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
ALTER TABLE Taverns ADD FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
ALTER TABLE Employees ADD FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
ALTER TABLE Employees ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE Services ADD FOREIGN KEY (StatusID) REFERENCES Statuses(StatusID)
ALTER TABLE Services ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE TavernOrders ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE TavernOrders ADD FOREIGN KEY (SupplyID, SupplyCost) REFERENCES Supplies(SupplyID, SupplyCost)
ALTER TABLE Inventory ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE Inventory ADD FOREIGN KEY (SupplyID, SupplyCost) REFERENCES Supplies(SupplyID, SupplyCost)
ALTER TABLE GuestStatusLink ADD FOREIGN KEY (GuestStatusID) REFERENCES GuestStatus(GuestStatusID)
ALTER TABLE GuestStatusLink ADD FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
ALTER TABLE SupplySales ADD FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
ALTER TABLE SupplySales ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE ServiceSales ADD FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
ALTER TABLE ServiceSales ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE ServiceSales ADD FOREIGN KEY (ServiceID, ServiceCost) REFERENCES Services(ServiceID, ServiceCost)
ALTER TABLE SupplySales ADD FOREIGN KEY (SupplyID, SupplyCost) REFERENCES Supplies(SupplyID, SupplyCost)



/*Insert Values into Tables */

INSERT INTO Owners (OwnerName)
VALUES 
	('John Smith'),
	('Aldus Dumbledore'),
	('Ash Ketchum'),
	('Moe Sislack'),
	('Thomas Shelby');

INSERT INTO Locations (Address, City, Country)
VALUES 
	('123 Main Street','Philadelphia','USA'),
	('2900 Poplar Street','Berlin','Germany'),
	('4458 East Lansing Avenue','London','England'),
	('62 N. 5th Street','New York City','USA'),
	('8876 Rising Sn Ave','Philadelphia','USA');

INSERT INTO Taverns (TavernName,LocationID,Floors,OwnerID)
VALUES 
	('Buddies',1,1,1),
	('Leneghans',2,1,1),
	('Crusaders',3,2,1),
	('Flaming Moes',4,3,2),
	('Dog & Pony',5,1,3);
    
INSERT INTO Roles (RoleName,RoleDescription)
VALUES 
	('Bartender','Take care of patrons needs, including serving food and drink'),
	('Cook','Cook food in kitchen. Lunch and Dinner'),
	('Bar Back','Bring beer up from cellar to stock the bar'),
	('Bouncer','Take care of drunk knuckleheads'),
	('DJ','Play cool music');

INSERT INTO Employees (EmployeeName,TavernID,Pay,RoleID)
VALUES 
	('Bill Burr',1,20,1),
	('Ralph Wigum',1,10,2),
	('Andy Reid',2,35,1),
	('McLovin',3,20,4),
	('Luke Skywalker',5,23,3);

INSERT INTO Statuses (StatusName)
VALUES 
	('Active'),
	('Inactive');
    
INSERT INTO Services (ServiceName,ServiceDescription,StatusID,ServiceCost,TavernID)
VALUES 
	('Dry Cleaning','A fancy way to clean your money....',1,50,1),
	('Horse Bets','Get all the winners',1,20,3),
	('Moonshine','We got a guy who makes high quality bathtub Gin',2,30,2),
	('Tax Returns','When the line at H&R Block is too long',1,31,5),
	('Screen Repair','We can fix your broken screens for some reason',2,79,4);

INSERT INTO Supplies (SupplyName,SupplyDescription,UnitOfMeasure,SupplyCost)
VALUES 
	('Daisy Cutter','IPA','Ounce',6),
	('Stone Cutter','Belgian Wheat','Ounce',7),
	('Jaromir Lagr','Lager from Czech Mountains','Ounce',6),
	('Bombtastic','Cherry Sour made with Monster Energy Drink','Ounce',8),
	('Nightmare Ale','Strong Ale','Ounce',5);

INSERT INTO TavernOrders (SupplyID,Amount,TotalCost,DateRcvd,TavernID)
VALUES 
	(1,250,1550,'2020-01-05',1),
	(2,600,4500,'2020-01-07',1),
	(3,50,6868,'2020-01-05',2),
	(3,50,6868,'2020-01-05',3),
	(4,20,700,'2020-01-06',5);

INSERT INTO Inventory (TavernID,SupplyID,CurrentCount,DateUpdated)
VALUES 
	(1,1,600,'2020-01-06'),
	(1,2,400,'2020-01-06'),
	(1,3,770,'2020-01-06'),
	(1,4,1200,'2020-01-06'),
	(1,5,300,'2020-01-06'),
	(2,1,600,'2020-01-06'),
	(2,2,400,'2020-01-06'),
	(2,3,770,'2020-01-06'),
	(2,4,1200,'2020-01-06'),
	(2,5,300,'2020-01-06'),
	(3,1,600,'2020-01-06'),
	(3,2,400,'2020-01-06'),
	(3,3,770,'2020-01-06'),
	(3,4,1200,'2020-01-06'),
	(3,5,300,'2020-01-06');

INSERT INTO GuestStatus (StatusName)
VALUES 
	('Hungry'),
	('Hangry'),
	('Raging'),
	('Drunk'),
	('Tired'),
	('Happy'),
	('Sad');

INSERT INTO Class (ClassName)
VALUES 
	('Red Mage'),
	('White Mage'),
	('Black Mage'),
	('Fighter'),
	('Thief'),
	('Paladin'),
	('Dragoon');
    
INSERT INTO Guest (GuestName, GuestBDay, GuestCDay)
VALUES 
	('Alfred', '1980-01-01', '2014-01-01'),
	('Miles', '1980-01-01', '2014-01-01'),
    ('Owen', '1980-01-01', '2014-01-01'),
    ('Abigail', '1980-01-01', '2014-01-01'),
    ('James', '1980-01-01', '2014-01-01');

INSERT INTO GuestClass (GuestID, ClassID, ClassLevel)
VALUES 
	(1,1,1),
	(2,3,4),
	(3,2,5),
	(4,6,2),
	(5,2,4);
/*(1,2,1) Would not work due to contraint of Composite Key - User ID 1 can not be used twice */