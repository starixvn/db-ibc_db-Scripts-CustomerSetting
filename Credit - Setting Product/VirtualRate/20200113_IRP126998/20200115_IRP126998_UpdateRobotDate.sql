/*
	Created: Johnson
	Date: 2020-01-15
	Task: update robotdate for IBO members	
*/

--step 1: run this script on DBONUSER/ON_USER 
--update robotdate for these customers

UPDATE RobotUsers WITH(UPDLOCK,ROWLOCK)
SET RobotDate = LastChangeTime
WHERE custid IN (1,2,xxx)

--step2 : run this script on DBLOG/bodb_CustomerLog
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

