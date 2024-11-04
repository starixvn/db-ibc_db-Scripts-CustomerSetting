/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241023@Johnson
	Task: Add new ErrMsg for oddsgroup [redmine: #199306]
	DB: DBCUST/CUSTDB
*/
--Step 1: add new ErrMsg on DBCUST
DECLARE @MsgNameEn NVARCHAR(1000)
SELECT @MsgNameEn = 'This function cannot be performed at this time as it may affect the performance of the whole system. Please contact IT for further assistance.'

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN]
           ,[MsgNameIN])
SELECT 90028, 10, @MsgNameEn, @MsgNameEn, @MsgNameEn, @MsgNameEn, @MsgNameEn, @MsgNameEn, @MsgNameEn, @MsgNameEn, 1, @MsgNameEn, @MsgNameEn
GO

--Step 2: Add new log Action on DBLOG.bodb_customerLog
USE bodb_customerLog
GO

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
SELECT 2222
	,[ActionTypeID]
   ,'Lrf_LicenseeOddsGroupUpd' [SPName]
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
FROM LogAction WITH (NOLOCK)
WHERE ActionID = 2217		   	   