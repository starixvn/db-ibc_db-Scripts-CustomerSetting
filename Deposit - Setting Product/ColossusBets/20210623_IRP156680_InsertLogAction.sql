/*
	Created: 20210623@Johnson
	Task: insert new log action for update status Colossus Bets [redmine:#156680]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
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
     VALUES
           (2217
           ,NULL
           ,'Lrf_CustomerUpdDisableColossusBet'
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member'
           ,NULL
           ,0
           ,'Update Status of Colususs Bets for Member'
           ,'Update Status of Colususs Bets for Member')
GO


