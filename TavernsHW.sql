CREATE TABLE Taverns (
	TavernID int IDENTITY(1,1),
	TavernName varchar(100),
	LocationID int,
	Floors int,
	OwnerID int,
	PRIMARY KEY (TavernID)
);

CREATE TABLE Rats (
	RatID int IDENTITY(1,1),
	RatName varchar(100),
	TavernID int,
	PRIMARY KEY (RatID)
);

CREATE TABLE Owners (
	OwnerID int IDENTITY(1,1),
	OwnerName varchar(100),
	PRIMARY KEY (OwnerID)
);

CREATE TABLE Locations (
	LocationID int IDENTITY(1,1),
	Address varchar(100),
	City varchar(100),
	Country varchar(100),
	PRIMARY KEY (LocationID)
);

CREATE TABLE Employees (
	EmployeeID int IDENTITY(1,1),
	EmployeeName varchar(100),
	TavernID int,
	Pay int,
	RoleID int,
	PRIMARY KEY (EmployeeID)
);

CREATE TABLE Roles (
	RoleID int IDENTITY(1,1),
	RoleName varchar(100),
	RoleDescription varchar(250),
	PRIMARY KEY (RoleID)
);

CREATE TABLE Services (
	ServiceID int IDENTITY(1,1),
	ServiceName varchar(100),
	ServiceDescription varchar(250),
	StatusID int,
	Cost int,
	TavernID int
	PRIMARY KEY (ServiceID)
);

CREATE TABLE ServiceSales (
	OrderID int IDENTITY(1,1),
	ServiceID int,
	TavernID int,
	Cost int,
	GuestName varchar(100),
	DatePurchased date,
	AmountPurchased int,
	PRIMARY KEY (OrderID)
);

CREATE TABLE Statuses (
	StatusID int IDENTITY(1,1),
	StatusName varchar(100),
	PRIMARY KEY (StatusID)
);

CREATE TABLE Supplies (
	SupplyID int IDENTITY(1,1),
	SupplyName varchar(100),
	SupplyDescription varchar(250),
	UnitOfMeasure int,
	Cost int,
	PRIMARY KEY (SupplyID)
);

CREATE TABLE TavernOrders (
	OrderID int IDENTITY(1,1),
	SupplyID int,
	Amount int,
	Cost int,
	TavernID int,
	DateRcvd date,
	PRIMARY KEY (OrderID)
);

CREATE TABLE Inventory (
	TavernID int,
	SupplyID int,
	Count int,
	DateUpdated date
);

INSERT INTO Taverns (TavernName,LocationID,Floors,OwnerID)
VALUES 
	('Buddies',1,1,1),
	('Leneghans',2,1,1),
	('Crusaders',3,2,1),
	('Java',4,3,2),
	('Dog & Pony',5,1,3);

INSERT INTO Rats (RatName,TavernID)
VALUES 
	('Splinter',1),
	('Joe',1),
	('Ratatouille',2),
	('Cold Brew',4),
	('Sam',5);

INSERT INTO Owners (OwnerName)
VALUES 
	('John Smith'),
	('Pauly Shore'),
	('Ash Ketchum'),
	('Frank Carter'),
	('Thomas Selby');

INSERT INTO Locations (Address, City, Country)
VALUES 
	('123 Main Street','Philadelphia','USA'),
	('2900 Poplar Street','Berlin','Germany'),
	('4458 East Lansing Avenue','London','England'),
	('62 N. 5th Street','New York City','USA'),
	('8876 Rising Sn Ave','Philadelphia','USA');

INSERT INTO Employees (EmployeeName,TavernID,Pay,RoleID)
VALUES 
	('Bill Burr',1,20,1),
	('Ralph Wigum',1,10,2),
	('Andy Reid',2,35,1),
	('McLovin',3,20,4),
	('Luke Skywalker',5,23,3);

INSERT INTO Roles (RoleName,RoleDescription)
VALUES 
	('Bartender','Take care of patrons needs, including serving food and drink'),
	('Cook','Cook food in kitchen. Lunch and Dinner'),
	('Bar Back','Bring beer up from cellar to stock the bar'),
	('Bouncer','Take care of drunk knuckleheads'),
	('DJ','Play cool music');

INSERT INTO Services (ServiceName,ServiceDescription,StatusID,Cost,TavernID)
VALUES 
	('Dry Cleaning','A fancy way to clean your money....',1,50,1),
	('Horse Bets','Get all the winners',1,20,3),
	('Moonshine','We got a guy who makes high quality bathtub Gin',2,30,2),
	('Tax Returns','When the line at H&R Block is too long',1,31,5),
	('Screen Repair','We can fix your broken screens for some reason',2,79,4);

INSERT INTO Statuses (StatusName)
VALUES 
	('Active'),
	('Inactive');

INSERT INTO ServicesSales (ServiceID,CustomerName,DatePurchased,AmountPurchased)
VALUES 
	(1,'Jim Thomas',2019-01-01,1),
	(1,'Jim Thomas',2019-01-04,1),
	(3,'Beer Baron',2020-01-01,5),
	(4,'Monty Burns',2020-04-04,1),
	(5,'Clumsy Bob',2020-01-01,1);

INSERT INTO Supplies (SupplyName,SupplyDescription,UnitOfMeasure,Cost)
VALUES 
	('Daisy Cutter','IPA','Ounce',6),
	('Stone Cutter','Belgian Wheat','Ounce',7),
	('Jaromir Lagr','Lager from Czech Mountains','Ounce',6),
	('Bombtastic','Cherry Sour made with Monster Energy Drink','Ounce',8),
	('Nightmare Ale','Strong Ale','Ounce',5);

INSERT INTO TavernOrders (SupplyID,Amount,Cost,DateRcvd,TavernID)
VALUES 
	(1,250,1550,2020-01-05,1),
	(2,600,4500,2020-01-07,1),
	(3,50,6868,2020-01-05,2),
	(3,50,6868,2020-01-05,3),
	(4,20,700,2020-01-06,5);

INSERT INTO Inventory (TavernID,SupplyID,Count,DateUpdated)
VALUES 
	(1,1,600,2020-01-01),
	(1,2,400,2020-01-01),
	(1,3,770,2020-01-01),
	(1,4,1200,2020-01-01),
	(1,5,300,2020-01-01),
	(2,1,600,2020-01-01),
	(2,2,400,2020-01-01),
	(2,3,770,2020-01-01),
	(2,4,1200,2020-01-01),
	(2,5,300,2020-01-01),
	(3,1,600,2020-01-01),
	(3,2,400,2020-01-01),
	(3,3,770,2020-01-01),
	(3,4,1200,2020-01-01),
	(3,5,300,2020-01-01);

ALTER TABLE Taverns ADD FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
ALTER TABLE Taverns ADD FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
ALTER TABLE Rats ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE Employees ADD FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
ALTER TABLE Employees ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE Services ADD FOREIGN KEY (StatusID) REFERENCES Statuses(StatusID)
ALTER TABLE Services ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE TavernOrders ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE TavernOrders ADD FOREIGN KEY (SupplyID) REFERENCES Supplies(SupplyID)
ALTER TABLE Inventory ADD FOREIGN KEY (TavernID) REFERENCES Taverns(TavernID)
ALTER TABLE Inventory ADD FOREIGN KEY (SupplyID) REFERENCES Supplies(SupplyID)
ALTER TABLE ServicesSales ADD FOREIGN KEY (StatusID) REFERENCES Statuses(StatusID)
ALTER TABLE ServicesSales ADD FOREIGN KEY (TavernID) REFERENCES Services(TavernID)
ALTER TABLE ServicesSales ADD FOREIGN KEY (Cost) REFERENCES Services(Cost)
	



