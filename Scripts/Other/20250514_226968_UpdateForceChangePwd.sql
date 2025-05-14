/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 14/05/2025
	Task: Update force change password [Redmine:#226968]	
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE  customer WITH (ROWLOCK, UPDLOCK)
SET     pwdexpiry = DATEADD(dd, -1, GETDATE()),
		RepUpdateTime = dbo.f_GetDateTime2()
WHERE   custid = 23994603