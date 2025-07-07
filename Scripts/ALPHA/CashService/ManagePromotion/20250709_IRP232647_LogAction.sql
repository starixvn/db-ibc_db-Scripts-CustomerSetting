/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250709@Johnson
	Task: Alpha - Agency Cash Service - Manage Promotion  [#232347]  
	DB: DBLOG/bodb_CustomerLog
*/

;WITH T AS (
    SELECT 315001 ActionID,'Age_CashService_CashPromotionIns' SPName, 'Add new promotion' ActionNameEN
    UNION SELECT 315002, 'Age_CashService_CashPromotionUpd', 'Update promotion'
    UNION SELECT 315003, 'Age_CashService_CashPromotionDel', 'Delete promotion'
    UNION SELECT 315004, 'Age_CashService_CashPromotionSatusUpd', 'Update promotion status'
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
SELECT ActionID, 7, SPName, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, NULL, 0, ActionNameEN, ActionNameEN
FROM T

