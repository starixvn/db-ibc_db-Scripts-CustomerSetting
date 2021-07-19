/*
	Created: 20200610@Eden
	Task: Alter table CustSettingAutoSuspend - BasketBall VR [Redmine: #134978]
	DB: DBCUST/CustDB
*/
ALTER TABLE CustSettingAutoSuspend ADD SportType INT NOT NULL CONSTRAINT DF_CustSettingAutoSuspend_SportType DEFAULT(43)
ALTER TABLE CustSettingAutoSuspend ALTER COLUMN AutoSuspendLive VARBINARY(30)
ALTER TABLE CustSettingAutoSuspend ALTER COLUMN AutoSuspendNonLive VARBINARY(30)
GO
ALTER TABLE CustSettingAutoSuspend DROP CONSTRAINT PK_CustSettingAutoSuspend_CustID 
ALTER TABLE CustSettingAutoSuspend ADD CONSTRAINT PK_CustSettingAutoSuspend_CustID PRIMARY KEY (CustID,SportType)
GO

