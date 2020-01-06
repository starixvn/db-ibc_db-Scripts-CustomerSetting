/*
	Created: 20200106@Johnson
	Task: structure for informing status of problem accounts
	DB: DBCUST/CustDB
*/
--step 1: run this script at DBCUST/CustDB
USE CUSTDB
GO
ALTER TABLE CS_ProblemAccount ADD Informed1By INT 

ALTER TABLE CS_ProblemAccount ADD Informed2By INT

GO

--step 2: add new log action informing status at DBLOG/bodb_CustomerLog
USE bodb_CustomerLog
GO

INSERT INTO [bodb_CustomerLog].[dbo].[LogAction]
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
SELECT 31612,6,'CS_ProblemAccount_InformStatusUpd','Update informing status','Update informing status','Update informing status','Update informing status','Update informing status','Update informing status','Update informing status',1,'Update informing status','Update informing status'

