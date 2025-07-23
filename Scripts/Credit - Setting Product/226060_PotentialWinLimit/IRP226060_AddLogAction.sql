/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250512@Johnson	
	Task: Add log action for Potential Winning Limit/Threshold [redmine:#226060]
	DB: DBLOG-bodb_CustomerLog
*/

DECLARE @ActionNameEN NVARCHAR(512) = 'Add Potential Winning Limit for member'

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
SELECT 265000, NULL, 'Acc_CustomerInsMember_Ag', @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, NULL, 0, @ActionNameEN, @ActionNameEN

SELECT @ActionNameEN = 'Update Sportsbook Potential Win Limit for customers'

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
SELECT 854, NULL, 'Acc_CustSetting_PotentialWinLimit_162_Upd', @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, @ActionNameEN, NULL, 0, @ActionNameEN, @ActionNameEN
