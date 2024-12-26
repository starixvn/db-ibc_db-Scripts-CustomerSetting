/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241216
	Task: Update FromDate - Testing
	DB:	DBCUST-CustDB
*/
USE CustDB
GO


UPDATE TOP (2) WhiteLabelSetting WITH (ROWLOCK, UPDLOCK)
SET FromDate='2024-09-05'
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE CustID IN (187007231)
	AND FromDate='2024-12-13'
GO

--Update ToDate

DECLARE @today DATETIME
	
SELECT  @today = CONVERT(DATE, GETDATE())

UPDATE WhiteLabelSetting WITH (ROWLOCK, UPDLOCK)
SET ToDate=CONVERT(DATE, ToDate)
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE ToDate <= @today
GO