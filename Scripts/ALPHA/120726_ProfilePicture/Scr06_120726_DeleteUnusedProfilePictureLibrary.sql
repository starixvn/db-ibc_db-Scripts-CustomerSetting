/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBAGE/bodb_Age
*/

USE bodb_Age
GO

--400 affected rows
DELETE p1
FROM dbo.Age_ProfilePicture p1 WITH (NOLOCK)
WHERE p1.ImageId BETWEEN 201 AND 10000
	OR p1.ImageId BETWEEN 10201 AND 20000

