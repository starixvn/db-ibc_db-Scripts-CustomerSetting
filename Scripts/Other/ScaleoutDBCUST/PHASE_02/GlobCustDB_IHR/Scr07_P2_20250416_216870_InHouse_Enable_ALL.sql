/*<info serverAlias="DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Enable In-house on ALL servers
	DB: DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]

	Tables:
		DomainManagement
		ProductStakeLevelGroup
		Dep_ProductStakeLevelGroup
		SportBettypeSettingMatrix
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* -- on DBACC & DBTP 

	DomainManagement
	ProductStakeLevelGroup
	Dep_ProductStakeLevelGroup
*/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'DomainManagement')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'DomainManagement'
END
		
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStakeLevelGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'ProductStakeLevelGroup'
END
		
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductStakeLevelGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'Dep_ProductStakeLevelGroup'
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SportBettypeSettingMatrix
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'SportBettypeSettingMatrix'
END