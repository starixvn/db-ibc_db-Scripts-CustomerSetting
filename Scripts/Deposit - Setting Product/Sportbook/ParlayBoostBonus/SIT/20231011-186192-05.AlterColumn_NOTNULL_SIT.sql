/*<info serverAlias="DBCUST-CustDB,DBTP-bodb02"></info>*/
/*
	Created: 20231011@Tacy
	Task: In-House - Alter IsDeleted column NOT NULL
	DB: DBCUST-CustDB,DBTP-bodb02
*/
UPDATE Dep_CustBonusSharing WITH (ROWLOCK, UPDLOCK)
SET [isDeleted]=0
, RepUpdateTime=SYSDATETIME()

ALTER TABLE Dep_CustBonusSharing ALTER COLUMN [isDeleted] BIT NOT NULL
GO