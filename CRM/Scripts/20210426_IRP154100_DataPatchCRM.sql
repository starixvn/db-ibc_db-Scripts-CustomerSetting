/*
	Created: 20210426@Johnson
	Task: data patch crm feedback setting
	DB: DBCRM/bodb_CRM
*/
--246 rows affect
UPDATE crmFeedbackSetting with(rowlock)
SET SettingID = 3025
WHERE SettingID = 3012
GO

UPDATE crmFeedback with (ROWLOCK) 
SET MainCategoryID = 3025
where MainCategoryID = 3012
GO

DELETE crmSetting WITH(ROWLOCK)
WHERE SettingID = 3012
GO
DELETE crmSetting_bk WITH(ROWLOCK)
WHERE SettingID = 3012
GO

DELETE crmSettingRelation WITH(ROWLOCK)
WHERE SettingID = 3012
GO

DELETE crmSettingRelation_bk WITH(ROWLOCK)
WHERE SettingID = 3012
GO

UPDATE crmSettingRelation WITH(ROWLOCK)
SET ParentID = 3025
where SettingID= 4029 and ParentID = 3012
GO

UPDATE crmSettingRelationB_bk WITH(ROWLOCK)
SET ParentID = 3025
where SettingID= 4029 and ParentID = 3012




