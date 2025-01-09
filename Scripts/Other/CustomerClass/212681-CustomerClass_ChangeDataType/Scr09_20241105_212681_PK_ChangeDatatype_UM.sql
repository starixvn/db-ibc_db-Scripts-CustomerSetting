/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241120
	Task: change datatype [Redmine:#212681] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

--1. Drop PK
ALTER TABLE CategoryConfig DROP CONSTRAINT PK_CategoryConfig
GO

--2. Change datatype
ALTER TABLE CategoryConfig ALTER COLUMN CategoryID INT NOT NULL
GO

--3. Add PK
ALTER TABLE CategoryConfig ADD CONSTRAINT PK_CategoryConfig PRIMARY KEY (CategoryID)
GO