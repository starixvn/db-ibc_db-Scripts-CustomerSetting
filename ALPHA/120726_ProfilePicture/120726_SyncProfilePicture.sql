/*
	Created: 20200109@Elodie
	Task: Sync data of profile picture
	DB: DB052/bodb_Age
*/

USE bodb_Age
GO

TRUNCATE TABLE dbo.Age_ProfilePicture
TRUNCATE TABLE dbo.Age_CustProfilePicture

INSERT INTO dbo.Age_ProfilePicture (ImageId, Image)
SELECT ImageId, Image
FROM DBAGE.bodb_Age.dbo.Age_ProfilePicture WITH (NOLOCK)

INSERT INTO dbo.Age_CustProfilePicture (CustId, ImageId, Modified)
SELECT CustId, ImageId, Modified
FROM DBAGE.bodb_Age.dbo.Age_CustProfilePicture WITH (NOLOCK)

