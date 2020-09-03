/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2020903@Eden
	Task: Update ReleaseDate of VRAgentProfile table, Clean testing data VRAgentAutoAdjustment [RM#140421]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

DECLARE @ReleaseDate DATETIME = '09/03/2020'

UPDATE t
SET ReleaseDate = @ReleaseDate
FROM VRAgentProfile t WITH(ROWLOCK)

DELETE FROM VRAgentAutoAdjustment