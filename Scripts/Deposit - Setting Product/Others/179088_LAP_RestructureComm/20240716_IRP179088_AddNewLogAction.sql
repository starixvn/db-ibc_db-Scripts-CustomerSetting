/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 2024716@Johnson
	Task: Add New Log Action for LAP - Restructure Player Commission
	DB: DBLOG-bodb_CustomerLog
*/

;WITH T as(
SELECT 2609 ActionID, 2615 ActionIDNew
UNION SELECT 2610, 2616
UNION SELECT 2611, 2617
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
SELECT t.ActionIDNew
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
FROM LogAction l WITH(NOLOCK)
	INNER JOIN T ON l.ActionID  = T.ActionID

 