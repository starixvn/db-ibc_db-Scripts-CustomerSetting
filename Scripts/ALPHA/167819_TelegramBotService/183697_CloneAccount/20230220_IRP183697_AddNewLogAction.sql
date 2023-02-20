/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230220@Johnson
	Task: Add new log action for clone account from telegram chatbot [#RedmineID:#183697]
	DB: DBLOG/bodb_CustomerLog
*/

WITH T AS (
SELECT 630 ActionID_Old, 95079 ActionID_New
UNION SELECT 630, 95080
UNION SELECT 629, 95081
UNION SELECT 629, 95082
UNION SELECT 603, 95083
UNION SELECT 603, 95084
)
INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT t.ActionID_New 
	,[ActionTypeID]
   ,[SPName]
   ,[ActionNameEN]
   ,[ActionNameCH]
   ,[ActionNameCS]
   ,[ActionNameJP]
   ,[ActionNameIT]
   ,[ActionNameTH]
   ,[ActionNameKO]
   ,[XsltContent]
   ,[IsInternal]
   ,[ActionNameVI]
   ,[ActionNameCN]
FROM T
	INNER JOIN LogAction l WITH(NOLOCK) ON t.ActionID_Old = l.ActionID