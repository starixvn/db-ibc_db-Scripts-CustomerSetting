/*
Created: 20180709@Winnie
Task: Update SIT data RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO


UPDATE c
	SET c.Description='<ROOT><row AutoField="" Remark="test"/></ROOT>'
FROM crmFeedback  c WITH(ROWLOCK,UPDLOCK)
WHERE c.FeedbackID IN(190160,224792,224793,224794,224790,224791)