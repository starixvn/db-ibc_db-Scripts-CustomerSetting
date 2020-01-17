/*
	Created: Johnson
	Date: 2020-01-17
	Task: update robotdate for IBO members	
	DB: DBLOG/bodb_CustomerLog
*/

--Add new logaction
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
SELECT 810,4,'Task_RobotAccounts_VirtualRate_Upd','Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account',1,'Daily auto update virtual rate for robot account','Daily auto update virtual rate for robot account'
