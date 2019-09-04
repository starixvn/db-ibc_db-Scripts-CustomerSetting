/*
	Created: 20190904@Winnie
	Task: Insert logaction #119642
	DB: DBLog/bodb_CustomerLog
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
           (1170
           ,5
           ,'Acc_Dep_CustomerUpdDisableColossusBet'
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status'
           ,NULL
           ,0
           ,'Update Enable/Disable Colossus Bets status'
           ,'Update Enable/Disable Colossus Bets status')
GO


