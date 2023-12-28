/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231129
	Task: GDG - clean redundant data
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/
USE CustDB
GO

DELETE FROM SportNonOfferedSiteCurrency with (ROWLOCK)
WHERE SportType=236
GO