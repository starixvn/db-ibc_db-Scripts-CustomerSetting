/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20211006@Johnson
	Task: add database structure for job update DangerLevel 
	DB: DBLOG/bodb_CustomerLog
*/

--Run at @DBLOG/bodb_CustomerLog
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
SELECT 1187,5,'Acc_CustomerUpdDangerLevel',N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level',NULL,1,N'Auto Update Saba Danger Level',N'Auto Update Saba Danger Level'
UNION SELECT 1188,5,'Dot_Admin_UpdateDangerLevel_ByCustIDTVP',N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level',NULL,1,N'Manual Update Saba Danger Level',N'Manual Update Saba Danger Level'
     


