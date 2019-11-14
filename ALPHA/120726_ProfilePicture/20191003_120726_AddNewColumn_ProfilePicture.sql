/*
	Created: 20191003@Elodie
	Task: Add new column into Age_CustProfilePicture
	DB: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE dbo.Age_CustProfilePicture ADD ImageId INT
ALTER TABLE dbo.Age_CustProfilePicture DROP COLUMN rv
