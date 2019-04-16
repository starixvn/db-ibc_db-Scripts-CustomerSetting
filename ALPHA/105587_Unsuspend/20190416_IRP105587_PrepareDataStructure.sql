/*
	Created: Johnson@20190416
	DB: DBCUST/CustDB
	Task: add new column for suspendinfo [redmine: #105587]	
*/

ALTER TABLE CustProductStatus ADD SuspendInfo TINYINT NULL
GO

--deploy 2 functions in all replicated servers of pub [CUSTDB_Customer_Info]
-- to initial function.
ALTER FUNCTION dbo.f_GenerateSuspendInfo()
RETURNS TINYINT
AS 
BEGIN
	RETURN 0
END
GO

ALTER FUNCTION dbo.f_GetSuspendInfoStatus()
RETURNS BIT
AS 
BEGIN
	RETURN 0
END
GO