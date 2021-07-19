/*
	Created: 20191003@Elodie
	Task: Add new table Age_ProfilePicture, Age_CustProfilePicture
	DB: DBAGE/bodb_Age
*/

USE bodb_Age
GO

CREATE TABLE Age_ProfilePicture
(
	ImageId		INT NOT NULL,
	Image		VARBINARY(MAX) NOT NULL,
CONSTRAINT [PK_Age_ProfilePicture] PRIMARY KEY CLUSTERED 
(
	ImageId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ProfileData]
) ON [ProfileData] TEXTIMAGE_ON [ProfileData]
GO

CREATE TABLE Age_CustProfilePicture
(
	CustId		INT NOT NULL,
	ImageId		INT NOT NULL,
	Modified	DATETIME NULL,
CONSTRAINT [PK_Age_CustProfilePicture] PRIMARY KEY CLUSTERED 
(
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ProfileData]
) ON [ProfileData]
GO