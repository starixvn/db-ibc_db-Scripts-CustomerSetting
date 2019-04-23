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
ALTER TABLE CustProductStatus_Old ADD CONSTRAINT DF_CustProductStatus_Old_SuspendInfo DEFAULT(0) FOR SuspendInfo
GO

-------------------------------------------------------------------------------------
--step 3: add new column SuspendInfo into CustProductStatus_History on DBTP/bodb_CustHistory
USE bodb_CustHistory
GO
ALTER TABLE CustProductStatus_History ADD SuspendInfo TINYINT NULL
GO
ALTER TABLE CustProductStatus_History ADD CONSTRAINT DF_CustProductStatus_History_SuspendInfo DEFAULT(0) FOR SuspendInfo
GO
	 
-------------------------------------------------------------------------------------
--step 2: deploy 2 functions in all replicated servers of pub [CUSTDB_Customer_Info]
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


