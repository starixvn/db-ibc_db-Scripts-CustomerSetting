/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210915
	Task: UPDATE global SettingStatus = 0 (PROD) for Bitcoin [Redmine: 159039]
	DB: DBCUST/CustDB
	
	P/s : Step 5 UPDATE global SettingStatus Bitcoin
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=175

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 175
