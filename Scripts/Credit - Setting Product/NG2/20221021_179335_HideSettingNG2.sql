/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202121021@Elodie
	Task : Update ProductSettingDetail [Redmine:#179335]
	DB:  DBCUST/CustDB 
*/
USE CustDB
GO

UPDATE p
SET SettingStatus = 2
FROM PRoductSettingDetail p WITH (ROWLOCK)
WHERE SportType IN (214,215,216,217,218)
