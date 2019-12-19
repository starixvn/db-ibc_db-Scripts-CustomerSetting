/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBAGE/bodb_Age
*/

USE bodb_Age
GO

UPDATE p1
SET p1.Image = p2.Image
FROM dbo.Age_ProfilePicture p1 WITH (ROWLOCK)
	INNER JOIN Age_ProfilePicture p2 WITH (NOLOCK) ON p2.ImageId = p1.ImageId + 200 
WHERE p1.ImageId < 1000000

