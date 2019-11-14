/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBAGE/bodb_Age
*/

USE bodb_Age
GO

CREATE TABLE #ProfileCustomer (ImageId INT IDENTITY(1000001,1), Image VARBINARY(MAX))

INSERT INTO #ProfileCustomer (Image)
SELECT DISTINCT image
FROM bodb02.dbo.Age_CustProfilePicture WITH (NOLOCK)

INSERT INTO dbo.Age_ProfilePicture (ImageId, Image) 
SELECT ImageId, Image
FROM #ProfileCustomer

