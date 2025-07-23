/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250715@Johnson
	Task: Add new log action for cash service [redmine:#231219]
	DB: DBLOG.bodb_CustomerLog
*/

;WITH T AS (
    SELECT 31780 ActionID,'NAP_Domain_CashDomainIns' SPName, 'Assign Domain to Cash Service Enabled Agent' ActionNameEN
    UNION SELECT 31781, 'NAP_Domain_CashDomainUpd', 'Assign Domain to Cash Service Enabled Agent'
    UNION SELECT 31782, 'NAP_Domain_CashDomainUpd', 'Remove Domain from Cash Service Enabled Agent'
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
SELECT ActionID, NULL, SPName, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, NULL, 1 IsInternal, ActionNameEN, ActionNameEN
FROM T
