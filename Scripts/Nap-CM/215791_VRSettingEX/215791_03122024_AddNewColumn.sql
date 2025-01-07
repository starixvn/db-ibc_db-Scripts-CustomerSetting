/*<info serverAlias="DBCUST-CustDB,DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20241230@Winfred
	Task: [NAP CM] VR Engine - Pre-match Period with Extra VR [redmine: #215791]
	DB: DBCUST/CustDB, DBTP/bodb02,DBCustRepl/ReplCustDB, DBACC/bodb02
*/
--ALTER TABLE VRSettingRule DROP CONSTRAINT DF_VRSettingRule_PreMatchPeriod;
--GO
--ALTER TABLE VRSettingRule DROP COLUMN PreMatchPeriod;
--GO
ALTER TABLE VRSettingRule ADD PreMatchPeriod SMALLMONEY NOT NULL CONSTRAINT DF_VRSettingRule_PreMatchPeriod DEFAULT(0) WITH VALUES 
GO
