/*
Created: 20180709@Winnie
Task: Get ReleaseDate and LogID and keep them for rollback plan. RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

DECLARE @ReleaseDate	DATETIME
DECLARE @LogID			BIGINT
SELECT @ReleaseDate = GETDATE()
SELECT @LogID		= MAX(LogID) FROM crmLogFeedback WITH(NOLOCK) 
SELECT @ReleaseDate AS ReleaseDate
SELECT @LogID		AS LogID
