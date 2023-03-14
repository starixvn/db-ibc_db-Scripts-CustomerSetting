/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Alter column DisableNumber
	DB: DBCUST/CustDB
*/
USE CustDB
GO

ALTER TABLE Custinfo ALTER COLUMN DisableNumber BIT NULL