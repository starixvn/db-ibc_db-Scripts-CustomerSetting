/*<info serverAlias="DBACC-bodb_ACC"></info>*/
/*
	Created: 20210531@Eden
	Task: sync data from bodb02..BetMonitoring_Setting to bodb_ACC - restore [Redmine:#152636]	
	DB: DBCUST/CustDB
*/
USE bodb_ACC
GO
DELETE FROM dbo.BetMonitoring_Setting WITH(ROWLOCK,UPDLOCK)

INSERT INTO dbo.BetMonitoring_Setting (SettingID,SettingName,Value)
SELECT SettingID,SettingName,Value
FROM bodb02.dbo.BetMonitoring_Setting WITH(NOLOCK)

