/*
	Created: 20200415@Helen
	Task: https://nexdev.net/issues/131774
	DB: DBCUST/bodb_Licensee AND all replicated of pub: Cusdb_bodb_Licensee
*/
USE bodb_Licensee
GO
CREATE FUNCTION [dbo].[f_CheckRepTable]
(
	@TableName varchar(50)
)
RETURNS BIT
/* 
	Created:20150603@Daniel
    Task: Check whether a table is published or replicated, use for checking table access via execRep SPs
    DB: All DB servers/DBs that have table(s) published/replicated
    
    Param: 
	   Input table's name to @TableName to check
	   + if return 1: Table is published (publisher) or replicated (subscriber) and can be accessed in exec rep SPs
	   + if return 0: Table is not either published or replicated
    
*/
AS
BEGIN
    DECLARE @ReturnVal BIT
    SET @ReturnVal = 0

    IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE name = 'MSreplication_objects') --if not subscriber
    BEGIN
	   IF EXISTS(SELECT 1 FROM sys.tables WHERE name = @TableName AND type = 'U' AND is_replicated = 1)--check table is published from publisher
		  SET @ReturnVal = 1
    END
    ELSE
    BEGIN
	   IF EXISTS(SELECT 1 FROM dbo.MSreplication_objects WHERE article = @TableName)	--check table in subscriber is replicated
		  SET @ReturnVal = 1
    END

    RETURN @ReturnVal
END
GO
