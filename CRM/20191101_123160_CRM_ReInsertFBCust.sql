/*
	Created By: Winnie
	Created Date: 20191101
	RedmineID: #123160
	DB: DBCust/CustDB	
*/

INSERT INTO [bodb_CRM].[dbo].[crmFeedbackCustomer]
           ([FeedbackID]
           ,[CustID]
           ,[IsRelated])
 SELECT 735310,CustID,0
 FROM crmCustomer WITH(NOLOCK) WHERE UserName='WFBM00AC2'