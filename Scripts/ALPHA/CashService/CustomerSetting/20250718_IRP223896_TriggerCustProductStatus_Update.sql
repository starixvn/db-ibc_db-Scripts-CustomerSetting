/*<info serverAlias="DBCUST-CUSTDB"></info>*/
USE [CustDB]
GO

----------------------------------------------------------------
--CustProductStatus
ALTER TRIGGER [dbo].[CustProductStatus_update] ON [dbo].[CustProductStatus] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustProductStatus] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 20240114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
		- 20250718@Elodie: Add ServiceType column [redmine:#223896]
*/
BEGIN 
  SET NOCOUNT ON
  
  INSERT INTO CustDB_History.dbo.[CustProductStatus_History] (
    [CustID] ,
    [bitmapHasSynced] ,
    [bitmapIsHidden] ,
    [bitmapIsDisabled],
    [SuspendInfo],
	[Locked],
	[CloseInfo],
	[ServiceType]
  )
  SELECT
    [CustID] ,
    [bitmapHasSynced] ,
    [bitmapIsHidden] ,
    [bitmapIsDisabled],
    [SuspendInfo],
	[Locked],
	[CloseInfo],
	[ServiceType]
  FROM [DELETED]
END
