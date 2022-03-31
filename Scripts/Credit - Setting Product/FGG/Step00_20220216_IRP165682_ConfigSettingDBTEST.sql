/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220216@Johnson
	Task: config setting to run DBTEST [Redmine: #165682]
	DB: DBCUST/CustDB
*/
insert into Initial_StepByConfig(StepID,IsScanCustomer)
select 7,0

INSERT INTO Initial_ProductConfig(ConfigID,ProductID,SportTypeList,BetTypeList,Site,Currency,StartTime,IsTest,Status,ProcessedStep)
SELECT 7,64,176,8201,0,'2,3,6,10,13,15,16,20,22,33,34,35,43,45,47,64,69,72,95',GETDATE(),1,0,NULL

INSERT INTO Initial_ProductConfig_Detail(ConfigID,SportType,BetType,IsLive,SettingType,IsDefault,CopyFromSportType,CopyFromBetType)
select 7,176,8201,0,6,0,243,3101
UNION SELECT 7,176,8201,0,7,1,NULL,NULL
UNION select 7,176,8201,0,13,0,243,3101
UNION select 7,176,8201,0,18,0,243,3101