/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Elodie
	Date: 20220406
	Task: Setting job management
	DB: DBTXN/bodb02
*/
USE bodb02
GO

INSERT INTO SystemSettings (VName, VValue)
SELECT 'SettingJobDeploymentDate',''
