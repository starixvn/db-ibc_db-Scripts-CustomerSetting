/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting 
		  Disable trigger for history tables  [redmine: #207029]
	DB: DBTP-bodb02
*/
---------------------------CustVirtualSetting---------------------------
ALTER TABLE [dbo].[CustVirtualSetting] DISABLE TRIGGER [CustVirtualSetting_update]
GO
---------------------------VRCustLockStatus---------------------------
ALTER TABLE [dbo].[VRCustLockStatus] DISABLE TRIGGER [VRCustLockStatus_Insert_update]
GO
