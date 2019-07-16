/*
	Created: 20190716@Johnson
	Task: insert log action for new headline
	DB: DBLOG/bodb_CustomerLog
*/

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
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 160012,	4,'CS_CustomerIns_Headline', N'Add general information for Headline', N'Add general information for Headline', N'Add general information for Headline', N'Add general information for Headline', N'Add general information for Headline', N'Add general information for Headline', N'Add general information for Headline', 0, N'Add general information for Headline', N'Add general information for Headline'
