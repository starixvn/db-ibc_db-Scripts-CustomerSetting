/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200827@Eden
	Task: Update ReleaseDate of VRAgentProfile table for testing [RM#140421]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

DECLARE @ReleaseDate DATETIME = '09/02/2020'

UPDATE t
SET ReleaseDate = @ReleaseDate
FROM VRAgentProfile t WITH(ROWLOCK)
WHERE t.SiteID = 487 
	AND t.Type = 1 