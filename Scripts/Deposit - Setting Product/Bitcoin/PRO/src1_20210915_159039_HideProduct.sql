/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210915
	Task:  Update SettingStatus = 2 (PROD) for  Product Bitcoin product Deposit RedmineID:#159039
	DB: DBCust/CustDB
	
	P/s : Step 1 hide Sports Bitcoin
*/

USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=175

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 175

