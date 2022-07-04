/*<info serverAlias="DBTP-bodb02"></info>*/

/*
	Created: 20220704@Tacy
	Task: Initial data "SyncHistoryDataLastTime" into column ConfigName on table CustMaxBetSetting_Config
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBTP/bodb02
*/

INSERT INTO CustMaxBetSetting_Config(ConfigName, ConfigValue) 
VALUES ('SyncHistoryDataLastTime', CONVERT(VARCHAR, GETDATE(), 121))
