/*<info serverAlias="DBCUST-custDB"></info>*/
/*
	Created: 20210413@Tina
	Task: All Sites - Lock account & indirect close account [redmine: #148600]
	DB: DBCUST.custDB
		DBAGE.bodb02
*/

USE [CustDB]
GO
--step1: add 2 news column Locked and CloseInfo into CustProductStatus
IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustProductStatus' AND C.name = 'Locked')
BEGIN
	ALTER TABLE CustProductStatus ADD Locked TINYINT NULL CONSTRAINT DF_CustProductStatus_Locked DEFAULT (0);
END

GO
IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustProductStatus' AND C.name = 'CloseInfo')
BEGIN
	ALTER TABLE CustProductStatus ADD CloseInfo TINYINT NULL CONSTRAINT DF_CustProductStatus_CloseInfo DEFAULT (0); 
END
GO
--step 2: add 2 news column Locked and CloseInfo into CustProductStatus_old on DB05/bodb_Customer	

USE [bodb_Customer]
GO

IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustProductStatus_Old' AND C.name = 'Locked')
BEGIN
	ALTER TABLE CustProductStatus_Old ADD Locked TINYINT NULL CONSTRAINT DF_CustProductStatus_Locked DEFAULT (0);
END

GO
IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustProductStatus_Old' AND C.name = 'CloseInfo')
BEGIN
	ALTER TABLE CustProductStatus_Old ADD CloseInfo TINYINT NULL CONSTRAINT DF_CustProductStatus_CloseInfo DEFAULT (0); 
END
GO

--step 3: add 2 news column Locked and CloseInfo into CustProductStatus_History on DBTP/bodb_CustHistory
USE [bodb_CustHistory]
GO

IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustProductStatus_History' AND C.name = 'Locked')
BEGIN
	ALTER TABLE CustProductStatus_History ADD Locked TINYINT NULL CONSTRAINT DF_CustProductStatus_Locked DEFAULT (0);
END

GO
IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustProductStatus_History' AND C.name = 'CloseInfo')
BEGIN
	ALTER TABLE CustProductStatus_History ADD CloseInfo TINYINT NULL CONSTRAINT DF_CustProductStatus_CloseInfo DEFAULT (0); 
END
GO

--step 4: ALTER Trigger on CustProductStatus on DBTP/bodb02
USE [bodb02]
GO
ALTER TRIGGER [dbo].[CustProductStatus_update] ON [dbo].[CustProductStatus] AFTER UPDATE
AS
/*
  ALTERd by: 20151029@Helen
  Task: Trigger for updating [CustProductStatus] table 
  DB: DBTP/bodb02
  
  Revisions: 
    - 20190424@Johnson: Add new column suspendInfo [redmine:#105587]
	- 20210408@Tina: Add new column Locked and CloseInfo [redmine: #148600]
*/
BEGIN 
  SET NOCOUNT ON
  
  INSERT INTO bodb_CustHistory.dbo.[CustProductStatus_History] (
    [CustID] ,
    [bitmapHasSynced] ,
    [bitmapIsHidden] ,
    [bitmapIsDisabled],
    [SuspendInfo],
	[Locked],
	[CloseInfo]  
  )
  SELECT
    [CustID] ,
    [bitmapHasSynced] ,
    [bitmapIsHidden] ,
    [bitmapIsDisabled],
    [SuspendInfo],
	[Locked],
	[CloseInfo]
  FROM [DELETED]
END
