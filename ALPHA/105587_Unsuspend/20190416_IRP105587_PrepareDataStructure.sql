/*
	Created: Johnson@20190416
	DB: DBCUST/CustDB
	Task: add new column for suspendinfo [redmine: #105587]	
*/

ALTER TABLE CustProductStatus ADD SuspendInfo TINYINT NULL
GO

--deploy 2 functions in all replicated servers of pub [CUSTDB_Customer_Info]
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