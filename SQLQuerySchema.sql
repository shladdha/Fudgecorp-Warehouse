/****** Object:  Database UNKNOWN    Script Date: 4/19/2020 12:27:19 AM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE UNKNOWN
GO
CREATE DATABASE UNKNOWN
GO
ALTER DATABASE UNKNOWN
SET RECOVERY SIMPLE
GO
*/
USE ist722_hhkhan_cc5_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;


-- Create the schema if it does not exist
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'FMFFWarehouse')) 
BEGIN
    EXEC ('CREATE SCHEMA [FMFFWarehouse] AUTHORIZATION [dbo]')
	PRINT 'CREATE SCHEMA [FMFFWarehouse] AUTHORIZATION [dbo]'
END
go 




-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
/*GO
CREATE SCHEMA FMFFWarehouse
GO
*/

/* Drop table FMFFWarehouse.FactOrderFullfilment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FMFFWarehouse.FactOrderFullfilment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FMFFWarehouse.FactOrderFullfilment 
;


/* Drop table FMFFWarehouse.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FMFFWarehouse.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FMFFWarehouse.DimCustomer 
;

/* Create table FMFFWarehouse.DimCustomer */
CREATE TABLE FMFFWarehouse.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int  NOT NULL
,  [CustomerFirstName]  varchar(50)   NOT NULL
,  [CustomerLastName]  varchar(50)   NOT NULL
,  [CustomerEmail]  varchar(200)   NOT NULL
,  [CustomerAddress]  varchar(1000)  NULL
,  [CustomerCity]  varchar(50)   NOT NULL
,  [CustomerState] varchar(5)   NOT NULL
,  [CustomerZipcode]  varchar(20)   NOT NULL
,  [SourceCompany]  nvarchar(20)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  varchar(200)   NULL
, CONSTRAINT [PK_FMFFWarehouse.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'FMFFWarehouse', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Customers dimension', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimCustomer
;



-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[FMFFWarehouse].[Customer]'))
DROP VIEW [FMFFWarehouse].[Customer]
GO
CREATE VIEW [FMFFWarehouse].[Customer] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerID] AS [CustomerID]
, [CustomerFirstName] AS [CustomerFirstName]
, [CustomerLastName] AS [CustomerLastName]
, [CustomerEmail] AS [CustomerEmail]
, [CustomerAddress] AS [CustomerAddress]
, [CustomerCity] AS [CustomerCity]
, [CustomerState] AS [CustomerState]
, [CustomerZipcode] AS [CustomerZipcode]
, [SourceCompany] AS [SourceCompany]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM FMFFWarehouse.DimCustomer
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerFirstName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerLastName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerEmail', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerAddress', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerCity', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerState', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerZipcode', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SourceCompany', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer First Name', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Last Name', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Email', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Address', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer''s City', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'State or province', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Zipcode', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Company before merger', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'ALFKI', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Misty', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Meadows', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'mmeadows@dayrep.com', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'60 Madison Ave', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'NEW YORK', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'NY', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'10010', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Fudgemart/Fudgeflix', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3/fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_accounts/fm_customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Accounts/Customers', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_id/customer_id', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_firstname/customer_firstname', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_lastname/customer_lastname', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_email/customer_email', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_address/customer_address', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'zip_city/customrer_city', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'zip_state/customer_state', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_zipcode/customer_zip', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZipcode'; 
;





/* Drop table FMFFWarehouse.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FMFFWarehouse.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FMFFWarehouse.DimProduct 
;

/* Create table FMFFWarehouse.DimProduct */
CREATE TABLE FMFFWarehouse.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  varchar(20)   NOT NULL
,  [ProductName]  varchar(200)   NOT NULL
,  [ProductVendorName]  varchar(50)   NOT NULL
,  [ProductPrice]  money  NULL
,  [SourceCompany]  nvarchar(20)   NOT NULL
,  [ProductDepartment]  varchar(20)   NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  varchar(200)   NULL
, CONSTRAINT [PK_FMFFWarehouse.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Product', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'FMFFWarehouse', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Products on an order (Produt Dimension)', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimProduct
;



-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[FMFFWarehouse].[Product]'))
DROP VIEW [FMFFWarehouse].[Product]
GO
CREATE VIEW [FMFFWarehouse].[Product] AS 
SELECT [ProductKey] AS [ProductKey]
, [ProductID] AS [ProductID]
, [ProductName] AS [ProductName]
, [ProductVendorName] AS [ProductVendorName]
, [ProductPrice] AS [ProductPrice]
, [SourceCompany] AS [SourceCompany]
, [ProductDepartment] AS [ProductDepartment]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM FMFFWarehouse.DimProduct
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductID', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductVendorName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductPrice', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SourceCompany', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductDepartment', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of product', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Vendor names in fudgemart ; Fudgeflix in place of vendor names for fudgeflix vendors ', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Price of each product( retail price for fudgemart products and plan price for fudgeflix)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Company before merger', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Department/plan of each product', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3,…', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Straight Claw Hammer, Sledge Hammer, Rip Claw Hammer', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Soney, Mikey, Stanlee….', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'15.95, 9.99', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Fudgemart/Fudgeflix', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Hardware, Clothing, Basic Rental, Basic Rental + Streaming', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'titles/products', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'titles/products', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fudgeflix/vendor', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'plans/products', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fudgeflix/departmentlookup', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_id/product_id', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_name/product_name', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'fudgeflix/vendor_name', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'plan_price/retail_price', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'fudgeflix/department_id', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar/int', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductVendorName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
;


/* Drop table FMFFWarehouse.DimOrder */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FMFFWarehouse.DimOrder') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FMFFWarehouse.DimOrder 
;

/* Create table FMFFWarehouse.DimOrder */
CREATE TABLE FMFFWarehouse.DimOrder (
   [OrderKey]  int IDENTITY  NOT NULL
,  [OrderID]  int   NOT NULL
,  [OrderDate]  datetime   NOT NULL
,  [ShipDate]  datetime   NULL
,  [ShipVia]  varchar(20)   NULL
,  [SourceCompany]  nvarchar(20)   NOT NULL
,  [OrderQuantity] int Null
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  varchar(200)   NULL
, CONSTRAINT [PK_FMFFWarehouse.DimOrder] PRIMARY KEY CLUSTERED 
( [OrderKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimOrder
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimOrder
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'FMFFWarehouse', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimOrder
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Orders Table', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimOrder
;



-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[FMFFWarehouse].[Order]'))
DROP VIEW [FMFFWarehouse].[Order]
GO
CREATE VIEW [FMFFWarehouse].[Order] AS 
SELECT [OrderKey] AS [OrderKey]
, [OrderID] AS [OrderID]
, [OrderDate] AS [OrderDate]
, [ShipDate] AS [ShipDate]
, [ShipVia] AS [ShipVia]
, [SourceCompany] AS [SourceCompany]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM FMFFWarehouse.DimOrder
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderDate', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShipDate', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShipVia', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SourceCompany', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'order date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'shipped date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'shipping company', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Company before merger', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/1/2009', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/10/2009', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'JiffyEx, UDS, Postal Service', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Fudgemart/Fudgeflix', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'SourceCompany'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_account_titles/fm_Order', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_account_titles/fm_order', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_account_titles/fm_order', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'/ship_via_lookup', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'at_id/order_id', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'at_queue_date/order_date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'at_shipped_date/shipped_date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'fudgeflix/ship_via', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'OrderDate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipDate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimOrder', @level2type=N'COLUMN', @level2name=N'ShipVia'; 
;





/* Drop table FMFFWarehouse.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FMFFWarehouse.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FMFFWarehouse.DimDate 
;

/* Create table FMFFWarehouse.DimDate */
CREATE TABLE FMFFWarehouse.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  date   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekday]  bit  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_FMFFWarehouse.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'FMFFWarehouse', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Date dimension contains one row for every day, beginning at 1/1/2005. There may also be rows for "hasn''t happened yet."', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=DimDate
;

INSERT INTO FMFFWarehouse.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 0)
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[FMFFWarehouse].[Date]'))
DROP VIEW [FMFFWarehouse].[Date]
GO
CREATE VIEW [FMFFWarehouse].[Date] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [FullDateUSA] AS [FullDateUSA]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [QuarterName] AS [QuarterName]
, [Year] AS [Year]
, [IsWeekday] AS [IsWeekday]
FROM FMFFWarehouse.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FullDateUSA', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'QuarterName', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsWeekday', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full date as a SQL date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'String expression of the full date, eg MM/DD/YYYY', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day of week; Sunday = 1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Day name of week, eg Monday', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the month', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the year', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Week of year, 1..53', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month name, eg January', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month of year, 1..12', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar quarter, 1..4', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quarter name eg. First', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year, eg 2010', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is today a weekday', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20041123', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'38314', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'23-Nov-2004', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..7', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..31', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..365', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..52 or 53', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, …, 12', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2004', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'In the form: yyyymmdd', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
;






/* Create table FMFFWarehouse.FactOrderFullfilment */
CREATE TABLE FMFFWarehouse.FactOrderFullfilment (
   [ProductKey]  varchar(20)   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [OrderKey]  int   NOT NULL
,  [ShippedDateKey]  datetime  NULL
,  [OrderDateKey]  datetime   NOT NULL
,  [OrderID]  int   NOT NULL
,  [LagDays]  int   NOT NULL
,  [Quantity]  int   NULL
, CONSTRAINT [PK_FMFFWarehouse.FactOrderFullfilment] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [OrderID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=FactOrderFullfilment
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderFullfilment', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=FactOrderFullfilment
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'FMFFWarehouse', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=FactOrderFullfilment
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Order fulfillment information', @level0type=N'SCHEMA', @level0name=FMFFWarehouse, @level1type=N'TABLE', @level1name=FactOrderFullfilment
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[FMFFWarehouse].[OrderFullfilment]'))
DROP VIEW [FMFFWarehouse].[OrderFullfilment]
GO
CREATE VIEW [FMFFWarehouse].[OrderFullfilment] AS 
SELECT [ProductKey] AS [ProductKey]
, [CustomerKey] AS [CustomerKey]
, [OrderKey] AS [OrderKey]
, [ShippedDateKey] AS [ShippedDateKey]
, [OrderDateKey] AS [OrderDateKey]
, [OrderID] AS [OrderID]
, [LagDays] AS [LagDays]
, [Quantity] AS [Quantity]
FROM FMFFWarehouse.FactOrderFullfilment
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShippedDateKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderDateKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'LagDays', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'LagDays'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quantity', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Product', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Customer', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date (for Orders)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date (for Shipped)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date (for Ordered)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The natural key for the fact table, if any (eg order number)', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'shipped date - order date', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'LagDays'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity sold of item on order', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20120108', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20120108', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3…', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2,5,6', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'LagDays'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'3', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amounts', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'LagDays'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amounts', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimProduct.ProductKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimCustomer.CustomerKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimOrder.OrderKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'LagDays'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix/fudgemart', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'LagDays'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderDetails', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderDetails', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Quantity', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'smallint', @level0type=N'SCHEMA', @level0name=N'FMFFWarehouse', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
;
ALTER TABLE FMFFWarehouse.FactOrderFullfilment ADD CONSTRAINT
   FK_FMFFWarehouse_FactOrderFullfilment_ProductKey FOREIGN KEY
   (ProductKey) REFERENCES FMFFWarehouse.DimProduct
   (ProductKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE FMFFWarehouse.FactOrderFullfilment ADD CONSTRAINT
   FK_FMFFWarehouse_FactOrderFullfilment_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES FMFFWarehouse.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE FMFFWarehouse.FactOrderFullfilment ADD CONSTRAINT
   FK_FMFFWarehouse_FactOrderFullfilment_OrderKey FOREIGN KEY
   (
   OrderKey
   ) REFERENCES FMFFWarehouse.DimOrder
   ( OrderKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE FMFFWarehouse.FactOrderFullfilment ADD CONSTRAINT
   FK_FMFFWarehouse_FactOrderFullfilment_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES FMFFWarehouse.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE FMFFWarehouse.FactOrderFullfilment ADD CONSTRAINT
   FK_FMFFWarehouse_FactOrderFullfilment_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES FMFFWarehouse.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
 SET IDENTITY_INSERT FMFFWarehouse.DimCustomer ON
;
INSERT INTO FMFFWarehouse.DimCustomer (CustomerKey, CustomerID, CustomerFirstName, CustomerLastName, CustomerEmail, CustomerAddress, CustomerCity, CustomerState, CustomerZipcode, SourceCompany, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT FMFFWarehouse.DimCustomer OFF
;

SET IDENTITY_INSERT FMFFWarehouse.DimProduct ON
go
INSERT INTO FMFFWarehouse.DimProduct (ProductKey, ProductID, ProductName, ProductVendorName, ProductPrice, SourceCompany, ProductDepartment, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'None', 'None', 'None', 0, 'None', 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
go
SET IDENTITY_INSERT FMFFWarehouse.DimProduct OFF
go
SET IDENTITY_INSERT FMFFWarehouse.DimOrder ON
;
INSERT INTO FMFFWarehouse.DimOrder (OrderKey, OrderID, OrderDate, ShipDate, ShipVia, SourceCompany, OrderQuantity, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, '12/31/1899', '12/31/9999', 'None', 'None',-1, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT FMFFWarehouse.DimOrder OFF
;
