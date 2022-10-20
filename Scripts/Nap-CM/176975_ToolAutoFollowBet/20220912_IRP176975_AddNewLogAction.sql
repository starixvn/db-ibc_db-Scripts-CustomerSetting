/*<info serverAlias="DBLog-bodbCustomerLog"></info>*/
/*
	Created: 20220912@Johnson
	Task: Database structure change to manage follow bet account [Redmine: #176975]
	DB: DBCUST/CustDB
*/

;WITH T AS (
	SELECT 95074 ActionID, 'NAP_Customer_FollowBetAccountIns' spName, N'Add user(s) to Follow Bet Acount List' ActionEn
	UNION SELECT 95075, 'NAP_Customer_FollowBetAccountUpd', N'Update active status for user to follow bet account'
	UNION SELECT 95076, 'NAP_Customer_FollowBetAccountDel', N'Remove user from  Follow Bet Acount List'
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