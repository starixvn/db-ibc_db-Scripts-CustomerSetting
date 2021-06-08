/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210531
	Task:	 Update SettingStatus = 0 (PROD) for AdvantPlay [Redmine: 154258]
	DB:		 DBCUST/CustDB
	
	P/s : Step 8 unhide AdvantPlay
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=172

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 172