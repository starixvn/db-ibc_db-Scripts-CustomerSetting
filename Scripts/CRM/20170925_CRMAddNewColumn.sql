/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220112@Eldoie
	Task: CRM add new cluster index
	DB: DBCRM/bodb_CRM
*/

USE bodb_CRM
GO

-- Drop Constraint
ALTER TABLE SystemSetting DROP CONSTRAINT PK_SystemSetting

GO
ALTER TABLE SystemSetting ALTER COLUMN servicename VARCHAR(100) NOT NULL

GO
-- Create Clustered Index
ALTER TABLE SystemSetting ADD CONSTRAINT PK_SystemSetting PRIMARY KEY CLUSTERED (settingname, servicename)