------DROP TABLES
DROP TABLE OrderDetails
GO
DROP TABLE Orders
GO
DROP TABLE Products
GO
DROP TABLE Category
go
DROP TABLE [Address]
GO
DROP TABLE Users
GO
DROP TABLE LocalBodies
GO
DROP TABLE District
GO
DROP TABLE Province
GO
DROP TABLE Genders
GO
DROP TABLE MeasurementType
GO
DROP TABLE OrderStatus
GO
DROP TABLE PaymentMethod
GO
DROP TABLE StaticVariables
GO
---------INITIAL------
CREATE TABLE Genders (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50)
)
GO
SET IDENTITY_INSERT [dbo].Genders ON 
GO
INSERT INTO Genders(ID, [Name])
SELECT 1, 'Male' 
UNION ALL
SELECT 2, 'Female' 
UNION ALL
SELECT 3, 'Others' 
GO
SET IDENTITY_INSERT [dbo].Genders OFF
GO
--CREATE TABLE [dbo].[Users] (
--    [Id]                   NVARCHAR (128) NOT NULL,
--    [Email]                NVARCHAR (256) NULL,
--    [EmailConfirmed]       BIT            NOT NULL,
--    [PasswordHash]         NVARCHAR (MAX) NULL,
--    [SecurityStamp]        NVARCHAR (MAX) NULL,
--    [PhoneNumber]          NVARCHAR (MAX) NULL,
--    [PhoneNumberConfirmed] BIT            NOT NULL,
--    [TwoFactorEnabled]     BIT            NOT NULL,
--    [LockoutEndDateUtc]    DATETIME       NULL,
--    [LockoutEnabled]       BIT            NOT NULL,
--    [AccessFailedCount]    INT            NOT NULL,
--    [UserName]             NVARCHAR (256) NOT NULL,
--    [Discriminator]        NVARCHAR (128) NOT NULL
--)
--GO
--ALTER TABLE Users 
--ADD	FirstName NVARCHAR(255) NOT NULL,
--	MiddleName NVARCHAR(255) NULL,
--	LastName NVARCHAR(255) NULL,
--	GenderID INT NOT NULL,
--	[Active] BIT NOT 
go
ALTER TABLE Users 
ADD FullName AS (FirstName + ' ' + MiddleName + ' ' + LastName)
GO
ALTER TABLE Users ADD CONSTRAINT FK_USERS_GENDERID_GENDERS_ID FOREIGN KEY (GenderID) REFERENCES Genders(ID)
GO
ALTER TABLE Users ADD CONSTRAINT DF_USERS_DEFAULT_0_EMAILCONFIRMED DEFAULT(0) FOR EmailConfirmed
go
ALTER TABLE Users ADD CONSTRAINT DF_USERS_DEFAULT_1_Active DEFAULT(1) FOR [Active]
GO
--INSERT INTO Users(FirstName, Email, [Password], GenderID, UserTypeID, EmailConfirmed, [Active])
--SELECT 'Admin', 'admin@admin.com', HASHBYTES('MD5', '1'), 1, 1, 1, 1
GO
CREATE TABLE Province (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50)
)
GO
CREATE TABLE District (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50),
	ProvinceID INT NOT NULL
)
GO
ALTER TABLE District ADD CONSTRAINT FK_DISTRICT_PROVINCEID_PROVINCE_ID FOREIGN KEY (ProvinceID) REFERENCES Province(ID)
GO
CREATE TABLE LocalBodies (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50),
	ProvinceID INT NOT NULL,
	DistrictID INT NOT NULL
)
GO
ALTER TABLE LocalBodies ADD CONSTRAINT FK_LOCALBODIES_PROVINCEID_PROVINCE_ID FOREIGN KEY (ProvinceID) REFERENCES Province(ID)
GO
ALTER TABLE LocalBodies ADD CONSTRAINT FK_LOCALBODIES_DISTRICTID_DISTRICT_ID FOREIGN KEY (DistrictID) REFERENCES District(ID)
GO
CREATE TABLE [Address] (
	ID INT IDENTITY PRIMARY KEY NOT NULL,
	UserID NVARCHAR(128) NOT NULL,
	ProvinceID INT,
	DistrictID INT,
	LocalBodiesID INT,
	Locality NVARCHAR(255),
	WardNo INT,
	Landmark NVARCHAR(255) NOT NULL,
	Pincode NVARCHAR(255) NOT NULL,
	PhoneNo NVARCHAR(50),
	IsOrder BIT NULL
) 
GO
ALTER TABLE [Address] ADD CONSTRAINT FK_ADDRESS_USERID_USERS_ID FOREIGN KEY (UserID) REFERENCES Users(ID)
GO
ALTER TABLE [Address] ADD CONSTRAINT FK_ADDRESS_PROVINCEID_PROVINCE_ID FOREIGN KEY (ProvinceID) REFERENCES Province(ID)
GO
ALTER TABLE [Address] ADD CONSTRAINT FK_ADDRESS_DISTRICTID_DISTRICT_ID FOREIGN KEY (DistrictID) REFERENCES District(ID)
GO
ALTER TABLE [Address] ADD CONSTRAINT FK_ADDRESS_LOCALBODIESID_LOCALBODIES_ID FOREIGN KEY (LocalBodiesID) REFERENCES LocalBodies(ID)
GO
ALTER TABLE [Address] ADD CONSTRAINT DF_ADDRESS_DEFAULT_0_ISORDER DEFAULT(0) FOR IsOrder
GO
CREATE TABLE Category (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50),
	Icon NVARCHAR(300),
	[Active] BIT NOT NULL,
	Levels INT NOT NULL,
	ParentID INT NULL,
	CreatedBy NVARCHAR(128) NOT NULL,
	CreatedDate DATETIME
)
GO
ALTER TABLE Category ADD CONSTRAINT FK_CATEGORY_PARENTID_CATEGORY_ID FOREIGN KEY (ParentID) REFERENCES Category(ID)
GO
ALTER TABLE Category ADD CONSTRAINT FK_CATEGORY_CREATEDBY_USERS_ID FOREIGN KEY (CreatedBy) REFERENCES Users(ID)
GO
ALTER TABLE Category ADD CONSTRAINT DF_CATEGORY_DEFAULT_GETDATE_CREATEDDATE DEFAULT(GETDATE()) FOR CreatedDate
GO
CREATE TABLE MeasurementType (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50)
)
GO
SET IDENTITY_INSERT [dbo].MeasurementType ON 
GO
INSERT INTO MeasurementType(ID, [Name])
SELECT 1, 'Kilogram' 
UNION ALL
SELECT 2, 'Gram' 
UNION ALL
SELECT 3, 'Liter' 
UNION ALL
SELECT 4, 'Millilitre' 
GO
SET IDENTITY_INSERT [dbo].MeasurementType OFF
GO
--CREATE TABLE Products (
--	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
--	[Name] NVARCHAR(50),
--	OriginalPrice DECIMAL(18, 2),
--	SellPrice DECIMAL(18, 2),
--	Discount DECIMAL(5, 2),
--	KeyFeatures NVARCHAR(1000),
--	Descriptions NVARCHAR(MAX),
--	CategoryID INT,
--	MeasurementTypeID INT,
--	MeasurementTypeQuantity INT,
--	ExpiryDate DATE,
--	Icon NVARCHAR(300),
--	[Active] BIT NOT NULL,
--	CreatedBy NVARCHAR(128) NOT NULL,
--	CreatedDate DATETIME
--)
GO
ALTER TABLE Products 
ADD
	OriginalPrice DECIMAL(18, 2),
	Discount DECIMAL(5, 2),
	KeyFeatures NVARCHAR(1000),
	Descriptions NVARCHAR(MAX),
	CategoryID INT,
	MeasurementTypeID INT,
	MeasurementTypeQuantity INT,
	ExpiryDate DATE,
	Icon NVARCHAR(300),
	[Active] BIT NOT NULL,
	CreatedBy NVARCHAR(128) NOT NULL,
	CreatedDate DATETIME
GO
ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_CATEGORYID_CATEGORY_ID FOREIGN KEY (CategoryID) REFERENCES Category(ID)
GO
ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_MEASUREMENTTYPEID_MEASUREMENTTYPE_ID FOREIGN KEY (MeasurementTypeID) REFERENCES MeasurementType(ID)
GO
ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_CREATEDBY_USERS_ID FOREIGN KEY (CreatedBy) REFERENCES Users(ID)
GO
ALTER TABLE Products ADD CONSTRAINT DF_PRODUCTS_DEFAULT_GETDATE_CREATEDDATE DEFAULT(GETDATE()) FOR CreatedDate
GO
CREATE TABLE OrderStatus (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50)
)
GO
SET IDENTITY_INSERT [dbo].OrderStatus ON 
GO
INSERT INTO OrderStatus(ID, [Name])
SELECT 1, 'Ongoing' 
UNION ALL
SELECT 2, 'Cancelled' 
UNION ALL
SELECT 3, 'Delivered' 
UNION ALL
SELECT 4, 'Refund' 
GO
SET IDENTITY_INSERT [dbo].OrderStatus OFF
GO
CREATE TABLE PaymentMethod (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50)
)
GO
SET IDENTITY_INSERT [dbo].PaymentMethod ON 
GO
INSERT INTO PaymentMethod(ID, [Name])
SELECT 1, 'Cash On Delivery(COD)' 
UNION ALL
SELECT 2, 'Esewa' 
UNION ALL
SELECT 3, 'Khalti' 
UNION ALL
SELECT 4, 'PhonePay' 
UNION ALL
SELECT 5, 'Connect IPS'
GO
SET IDENTITY_INSERT [dbo].PaymentMethod OFF
GO
CREATE TABLE Orders (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	UserID NVARCHAR(128) NOT NULL,
	AddressID INT,
	PaidMethod INT,
	Total DECIMAL(18,2),
	Tax DECIMAL(18,2),
	Discount DECIMAL(18,2),
	DeliveryCharge DECIMAL(18,2),
	GrandTotal DECIMAL(18,2),
	StatusID INT,
	OrderedDate DATETIME,
	IsPaid BIT,
	PaidDate DATETIME,
	DeliveryDate DATETIME
)
GO
ALTER TABLE Orders ADD CONSTRAINT FK_ORDERS_ADDRESSID_ADDRESS_ID FOREIGN KEY (AddressID) REFERENCES Address(ID)
GO
ALTER TABLE Orders ADD CONSTRAINT FK_ORDERS_STATUSID_ORDERSTATUS_ID FOREIGN KEY (StatusID) REFERENCES OrderStatus(ID)
GO
ALTER TABLE Orders ADD CONSTRAINT DF_ORDERS_DEFAULT_GETDATE_ORDEREDDATE DEFAULT(GETDATE()) FOR OrderedDate
GO
ALTER TABLE Orders ADD CONSTRAINT FK_ORDERS_USERID_USERS_ID FOREIGN KEY (UserID) REFERENCES Users(ID)
GO
ALTER TABLE Orders ADD CONSTRAINT DF_ORDERS_DEFAULT_0_DISCOUNT DEFAULT(0) FOR Discount
GO
ALTER TABLE Orders ADD CONSTRAINT DF_ORDERS_DEFAULT_0_ISPAID DEFAULT(0) FOR IsPaid
GO
CREATE TABLE OrderDetails (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Rate DECIMAL(18,2),
	Discount DECIMAL(18,2),
	Total DECIMAL(18,2)
)
GO
ALTER TABLE OrderDetails ADD CONSTRAINT FK_ORDERDETAILS_ORDERID_ORDERS_ID FOREIGN KEY (OrderID) REFERENCES Orders(ID)
GO
ALTER TABLE OrderDetails ADD CONSTRAINT FK_ORDERDETAILS_PRODUCTID_PRODUCTS_ID FOREIGN KEY (ProductID) REFERENCES Products(ID)
GO
ALTER TABLE OrderDetails ADD CONSTRAINT DF_ORDERDETAILS_DEFAULT_0_DISCOUNT DEFAULT(0) FOR Discount
GO
CREATE TABLE StaticVariables (
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Text] NVARCHAR(100) UNIQUE,
	[Value] NVARCHAR(100),
)
GO
INSERT INTO StaticVariables([Text], [Value])
SELECT 'DataDrive', 'D:\EPharma\'
GO

--select * from StaticVariables


--update StaticVariables set Value='E:\EPharma\'