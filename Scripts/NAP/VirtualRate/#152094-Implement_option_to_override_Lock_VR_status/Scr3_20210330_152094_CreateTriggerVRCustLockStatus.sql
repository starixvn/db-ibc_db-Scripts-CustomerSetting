/*<info serverAlias="DBTP-bodb02"></info>*/
/*	
	Created: 20210330@Eden
	Task: Create trigger VRCustLockStatus [#152094]
	DB: DBTP/bodb02
*/
USE bodb02
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('[VRCustLockStatus_Insert_update]') IS NOT NULL
	DROP TRIGGER [VRCustLockStatus_Insert_update]
go
CREATE TRIGGER [dbo].[VRCustLockStatus_Insert_update] ON [dbo].[VRCustLockStatus]
AFTER UPDATE,INSERT,DELETE
AS
/*
	Created by: 20210330@Eden
	Task: Trigger for Inserting, updating [VRCustLockStatus] table 
	DB: DBTP/bodb02

	Revisions: 
		- 20210330@Eden: First commit [Redmine:#152094]
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.[VRCustLockStatus_History](CustID, Type, IsLocked)
	SELECT	custid, Type, 0
	FROM [DELETED]
	UNION ALL
	SELECT	custid, Type, 1
	FROM [inserted]
END 
