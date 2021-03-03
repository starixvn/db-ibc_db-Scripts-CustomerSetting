/*
	Created: 20210224@Eden
	Task: Create View VRCustLockStatus get data from DBCUST.CUSTDB.dbo.VRCustLockStatus [RM#149370]
	DB: all replicated server CustDB_CustSetting publication
*/
GO
CREATE VIEW [dbo].VRCustLockStatus
/*
	Created: 20210224@Eden
	Task:  - [Redmine: 149370]
	DB: all replicated server CustDB_CustSetting publication
*/
AS
	SELECT CustID,Type
	FROM DBCUST.CUSTDB.dbo.VRCustLockStatus WITH(NOLOCK)
GO
--DROP VIEW [dbo].VRCustLockStatus