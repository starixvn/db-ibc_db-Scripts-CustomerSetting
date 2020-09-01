/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200827@Eden
	Task: Update ReleaseDate of VRAgentProfile table for testing [RM#140421]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

DECLARE @ReleaseDate DATETIME = '09/02/2020 12:00 PM'

UPDATE t
SET ReleaseDate = ReleaseDate
FROM VRAgentProfile t WITH(ROWLOCK)
WHERE t.SiteID IN (23,24,25,20,21,487,11,22,3)
	AND t.Type = 1 