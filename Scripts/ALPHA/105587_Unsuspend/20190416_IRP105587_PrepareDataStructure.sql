/*
	Created: Johnson@20190416
	DB: DBCUST/CustDB
	Task: prepare structure for suspendinfo [redmine: #105587]	
*/
--step1: add new column SuspendInfo into CustProductStatus
USE CustDB
GO

ALTER TABLE CustProductStatus ADD SuspendInfo TINYINT NULL
GO
ALTER TABLE CustProductStatus ADD CONSTRAINT DF_CustProductStatus_SuspendInfo DEFAULT(0) FOR SuspendInfo
GO

---------------------------------------------------------------------------------
--step 2: add new column SuspendInfo into CustProductStatus_old on DB05/bodb_Customer	
 USE bodb_Customer
 GO
ALTER TABLE CustProductStatus_Old ADD SuspendInfo TINYINT NULL
GO
ALTER TABLE CustProductStatus_Old ADD CONSTRAINT DF_CustProductStatus_SuspendInfo DEFAULT(0) FOR SuspendInfo
GO

-------------------------------------------------------------------------------------
--step 3: add new column SuspendInfo into CustProductStatus_History on DBTP/bodb_CustHistory
USE bodb_CustHistory
GO
ALTER TABLE CustProductStatus_History ADD SuspendInfo TINYINT NULL
GO
ALTER TABLE CustProductStatus_History ADD CONSTRAINT DF_CustProductStatus_History_SuspendInfo DEFAULT(0) FOR SuspendInfo
GO

--step 4: ALTER Trigger on CustProductStatus on DBTP/bodb02
USE bodb02
GO
ALTER TRIGGER [dbo].[CustProductStatus_update] ON [dbo].[CustProductStatus] AFTER UPDATE
AS
/*
	ALTERd by: 20151029@Helen
	Task: Trigger for updating [CustProductStatus] table 
	DB: DBTP/bodb02
	
	Revisions: 
		- 20190424@Johnson: Add new column suspendInfo [redmine:#105587]
*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CustProductStatus_History] (
		[CustID] ,
		[bitmapHasSynced] ,
		[bitmapIsHidden] ,
		[bitmapIsDisabled],
		[SuspendInfo]	
	)
	SELECT
		[CustID] ,
		[bitmapHasSynced] ,
		[bitmapIsHidden] ,
		[bitmapIsDisabled],
		[SuspendInfo]
	FROM [DELETED]
END
GO

-------------------------------------------------------------------------------------
--step 5: deploy 2 functions in all replicated servers of pub [CUSTDB_Customer_Info]
-- to initial function.
CREATE FUNCTION dbo.f_GenerateSuspendInfo()
RETURNS TABLE
AS 
	RETURN 
	SELECT 0 as suspendInfo
GO

CREATE FUNCTION dbo.f_GetSuspendInfoStatus()
RETURNS TABLE
AS 
	RETURN 
	SELECT 0 as suspendInfo
GO


