/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@2021123
	Task: Clone table CustSettingAutoSuspend_Clone, copy From CustSettingAutoSuspend  [RM#164888]
	DB: DBCust/CustDB
*/
USE CustDB
GO
CREATE TABLE CustSettingAutoSuspend_Clone(
	CustID	int, 
	AutoSuspendLive	varbinary(30),
	AutoSuspendNonLive	varbinary(30),
	SportType	int,
	PRIMARY KEY( CustID,SportType)
)

GO
INSERT INTO CustSettingAutoSuspend_Clone (CustID,AutoSuspendLive,AutoSuspendNonLive,SportType)
SELECT CustID,AutoSuspendLive,AutoSuspendNonLive,SportType FROM CustSettingAutoSuspend WITH(NOLOCK)