/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Creator: 20240522@Tacy
	Task: CWL - Clean unused setting [Redmine: #205073]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

UPDATE WinLimit_ProductOffer WITH (ROWLOCK, UPDLOCK)
SET IsActive_Company=0
WHERE ProductID=43
GO