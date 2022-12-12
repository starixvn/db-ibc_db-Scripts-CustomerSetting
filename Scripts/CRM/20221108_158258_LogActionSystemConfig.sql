/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
USE bodb_CRM
GO

/*
	Created: 20221123@Winfred
	DB: DBCRM.bodb_CRM
	Task:  update date
	Revisions:
		- 20221123@Winfred:  update log action system setting config [RedmineID: #158258]
*/
DELETE FROM crmLogAction WHERE ActionID = 311
INSERT INTO dbo.crmLogAction(ActionID,SPName,ActionNameEN,IsInternal,ExcludedForCn88)
VALUES(311, 'Acc_CRM_ConfigAutoFeedback_SettingUpd','Update Job Setting',0,1)

GO