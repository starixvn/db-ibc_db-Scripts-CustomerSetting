/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: UnBlock add new cust [RedmineID:#131370]
	DB: DBCust/CustDB
*/
------------------------------------------------------
USE CustDB
GO
PRINT N'Step 8: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
--> Step 1 add config to block add new cust
-- Setting UMConfig . GMT -4
DECLARE  @SiteID INT,@Currency INT

SELECT  @SiteID =  0,@Currency = 0
DELETE FROM UMConfig WHERE SportType = 180 AND BetType = 1201  
AND SiteID  = @SiteID AND Currency = @Currency

PRINT N'Step 8: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 