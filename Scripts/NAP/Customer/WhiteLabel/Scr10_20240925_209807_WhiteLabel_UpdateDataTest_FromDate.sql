/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240925
	Task: Update FromDate - Testing
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

UPDATE TOP (5) WhiteLabelSetting WITH (ROWLOCK, UPDLOCK)
SET FromDate='2024-06-01'
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE CustID IN (169654650,169659359,169659405,169660506)
	AND FromDate='2024-09-25'
GO