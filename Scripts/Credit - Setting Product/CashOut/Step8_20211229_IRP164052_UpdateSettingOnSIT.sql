/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20211229@Johnson 
	Task: update setting for Cash Out on SIT
	DB: DBCUST/CustDB	
*/ 
USE CustDB
GO

UPDATE ProductSettingDetail WITH(ROWLOCK)
SET IsHidden = 0, 
	IsDisabled = 0
WHERE SportType = 9903