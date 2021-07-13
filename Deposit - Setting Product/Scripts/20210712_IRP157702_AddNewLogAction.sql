/*
	Created: 20210712@Johnson
	Task: insert new log action for updating odds group for licensee
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

INSERT INTO [dbo].[LogAction]
           ([ActionID]      
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
SELECT 2217,'Acc_Dep_LicenseeOddsGroupUpd','Update odds group for licensee','Update odds group for licensee','Update odds group for licensee','Update odds group for licensee','Update odds group for licensee','Update odds group for licensee','Update odds group for licensee',1,'Update odds group for licensee','Update odds group for licensee'
      