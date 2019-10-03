/*
	Created: 20191003@Elodie
	Task: Add new column into Age_CustProfilePicture, add new table Age_ProfilePicture
	DB: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE dbo.Age_CustProfilePicture ADD ImageId INT
ALTER TABLE dbo.Age_CustProfilePicture DROP COLUMN rv

CREATE TABLE Age_ProfilePicture
(
	ImageId		INT NOT NULL,
	Image		VARBINARY(MAX) NOT NULL,
CONSTRAINT [PK_Age_ProfilePicture] PRIMARY KEY CLUSTERED 
(
	ImageId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
