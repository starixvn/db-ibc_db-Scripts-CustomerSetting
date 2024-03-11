/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02"></info>*/
/*
	Created by: Tacy@20240228
	Task: in-house - Clean job [Redmine:#200454] 
	DB:	DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02
*/

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','Dep_ChargeInfoSetting','RepUpdateTime','ChargeId' UNION
SELECT 'bodb02','Dep_ChargeInfoSetting','RepUpdateTime','ChargeId'
GO