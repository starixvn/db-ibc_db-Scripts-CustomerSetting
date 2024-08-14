/*<info serverAlias=DBTP-bodb02></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Add IsDeleted column on DBTP [RedmineID:#206738]
	DB: DBTP/bodb02
*/
USE bodb02
GO

ALTER TABLE custSub ADD IsDeleted BIT NULL
GO
