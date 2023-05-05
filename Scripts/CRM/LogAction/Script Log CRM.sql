/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230412@Winfred
	Task : NAP CRM - Some of our Headline Contact info was missing in CRM [redmine:#186726]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO
--DELETE FROM dbo.crmLogAction WHERE ActionID IN (108)
INSERT INTO dbo.crmLogAction(ActionID,SPName,ActionNameEN,IsInternal)
VALUES(108, 'Acc_CRM_CustomerShortUpd','Short Update Info Customer',0)


select * from crmLogAction WITH (NOLOCK)