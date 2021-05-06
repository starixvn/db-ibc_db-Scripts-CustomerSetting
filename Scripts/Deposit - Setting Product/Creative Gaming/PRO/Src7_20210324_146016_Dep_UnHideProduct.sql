/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210324
	Task:	 Update SettingStatus = 0 (PROD) for Creative Gaming [Redmine: 146016]
	DB:		 DBCUST/CustDB
	
	P/s : Step 7 unhide Creative Gaming
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=167

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 167