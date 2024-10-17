/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting 
		  Add triggers for history tables  [redmine: #207029]
	DB: DBCUST-CUSTDB
*/
------------------------------------------------------CustVirtualSetting
CREATE TRIGGER [CustVirtualSetting_update] ON [CustVirtualSetting]
AFTER UPDATE
AS
/*
	Created by: 31072024@Winfred
	Task: Trigger for updating [CustVirtualSettingr] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 31072024@Winfred: Apply In-house Replication for Virtual Rate Setting [redmine:#207029]

*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.CustVirtualSetting_History(custid, seqNo, bitmapVirtual)
	SELECT	custid, seqNo, bitmapVirtual
	FROM [DELETED]
END 
GO

------------------------------------------------------VRCustLockStatus
CREATE TRIGGER [VRCustLockStatus_Insert_update] ON [VRCustLockStatus]
AFTER UPDATE,INSERT,DELETE
AS
/*
	Created by: 31072024@Winfred
	Task: Trigger for Inserting, updating [VRCustLockStatus] table 
	DB: DBCUST/CUSTDB

	Revisions: 
        - 31072024@Winfred: Apply In-house Replication for Virtual Rate Setting [redmine:#207029]
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.[VRCustLockStatus_History](CustID, Type, IsLocked)
	SELECT	custid, Type, 0
	FROM [DELETED]
	UNION ALL
	SELECT	custid, Type, 1
	FROM [inserted]
END 
GO