/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241216
	Task: Delete incorrect data - Testing
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

--Delete data test:
INSERT INTO WhiteLabelSetting_Del_InHouse(CustID, FromDate, RepUpdateTime)
SELECT 169654650, '2024-09-25', dbo.f_GetDateTime2() 
UNION ALL
SELECT 169659359, '2024-09-25', dbo.f_GetDateTime2() 
UNION ALL 
SELECT 169659405, '2024-09-25', dbo.f_GetDateTime2() 
UNION ALL 
SELECT 169660506, '2024-09-25', dbo.f_GetDateTime2() 
UNION ALL 
SELECT 187007231, '2024-12-13', dbo.f_GetDateTime2() 
GO
