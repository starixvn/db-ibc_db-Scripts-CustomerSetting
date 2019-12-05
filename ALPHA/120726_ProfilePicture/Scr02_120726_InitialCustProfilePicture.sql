/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBAGE/bodb_Age
*/

USE bodb_Age
GO

TRUNCATE TABLE Age_CustProfilePicture

INSERT INTO Age_CustProfilePicture (CustId, ImageId, Modified)
SELECT cp.CustId, p.ImageId, cp.Modified
FROM bodb02.dbo.Age_CustProfilePicture cp WITH (NOLOCK)
	INNER JOIN dbo.Age_ProfilePicture p WITH (NOLOCK) ON p.Image = cp.image

