/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Winfred
	Date: 20220623
	Task: Insert Settings Into DCS Structure - Redmine: 171705
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO
DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId)
SELECT 472,'Update Position Taking DCS Products for Licensee Customers by LA', 'Acc_Dep_LicenseeSetting_PTSettingUpd',0,1


INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)



select * from LogAction with(nolock) where ActionID = 472