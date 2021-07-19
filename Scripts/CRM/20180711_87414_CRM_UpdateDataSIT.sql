/*
Created: 20180709@Winnie
Task: Update SIT data RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

UPDATE crmFeedbackCustomer WITH(ROWLOCK,UPDLOCK)
SET IsRelated=0
WHERE FeedbackID  IN(224799,224800,224801,224802,224803)
