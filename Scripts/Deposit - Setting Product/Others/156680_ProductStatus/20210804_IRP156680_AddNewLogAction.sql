/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210712@Johnson
	Task: insert new log action for status RnG Casino
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
SELECT 2218,'Lrf_CustomerUpdCasinoStatus','Update Status of RnG Casino','Update Status of RnG Casino','Update Status of RnG Casino','Update Status of RnG Casino','Update Status of RnG Casino','Update Status of RnG Casino','Update Status of RnG Casino',1,'Update Status of RnG Casino','Update Status of RnG Casino'
      
