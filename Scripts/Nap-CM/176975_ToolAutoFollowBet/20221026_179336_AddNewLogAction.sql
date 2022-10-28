/*<info serverAlias="DBLog-bodbCustomerLog"></info>*/
/*
	Created: 20221026@Johnson
	Task: Database structure change to manage follow bet account [Redmine: #179336]
	DB: DBCUST/CustDB
*/

;WITH T AS (
	SELECT 95077 ActionID, 'NAP_Customer_FollowBetAccountUpdFollowStatus' spName, N'Mark pro account to follow bet account' ActionEn	
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
SELECT ActionID, 4, spName, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, NULL, 1, ActionEn, ActionEn
FROM T		   