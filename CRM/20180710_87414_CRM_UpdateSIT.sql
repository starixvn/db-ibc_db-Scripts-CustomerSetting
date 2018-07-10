/*
Created: 20180709@Winnie
Task: Update SIT data RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

UPDATE crmFeedback WITH(ROWLOCK,UPDLOCK)
SET ProductID=46004
WHERE ProductID NOT IN(46004,46005,46000,46001,46002,46003)
