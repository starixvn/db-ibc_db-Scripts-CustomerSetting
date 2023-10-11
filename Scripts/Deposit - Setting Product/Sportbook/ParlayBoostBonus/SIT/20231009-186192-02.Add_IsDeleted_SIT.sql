/*<info serverAlias="DBCUST-CustDB,DBBOF-bodb02,DBAGE-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20231009@Tacy
	Task: In-House - Add IsDeleted column
	DB: DBCUST-CustDB,DB05x-bodb02,DBTP-bodb02
	
	Revisions:
		- 20231009@Tacy: Integration - Parlay Boost Bonus [RedmineID: #186192]
*/
USE CustDB
GO

ALTER TABLE Dep_CustBonusSharing ADD [isDeleted] BIT NULL
GO

--Default value:
ALTER TABLE [dbo].[Dep_CustBonusSharing] ADD  CONSTRAINT [DF_Dep_CustBonusSharing_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO