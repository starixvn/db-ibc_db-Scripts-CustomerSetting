/*<info serverAlias="DBCustRepl-ReplCustDB,DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Disable In-house on ALL servers
	DB: DBCustRepl-ReplCustDB,DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]

	Tables:
		DomainManagement
		ProductStakeLevelGroup
		Dep_ProductStakeLevelGroup
		SportBettypeSettingMatrix
*/
IF @@SERVERNAME = 'IHRDISTC1'
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] IN ('Dep_ProductStakeLevelGroup'
					,'DomainManagement'
					,'ProductStakeLevelGroup'
					,'SportBettypeSettingMatrix')
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* -- on DBACC & DBTP 

	DomainManagement
	ProductStakeLevelGroup
	Dep_ProductStakeLevelGroup
*/
IF @@SERVERNAME IN ('DBTP10C','DB061','DB062')
BEGIN
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'DomainManagement')
	BEGIN
		UPDATE RepInfo
		SET active = 0
			,[group] = 1
			,get_sp = REPLACE(get_sp, '_Dist','')
			,put_sp = REPLACE(put_sp, '_Dist','')
		WHERE [name] =  'DomainManagement'
	END
		
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStakeLevelGroup')
	BEGIN
		UPDATE RepInfo
		SET active = 0
			,[group] = 1
			,get_sp = REPLACE(get_sp, '_Dist','')
			,put_sp = REPLACE(put_sp, '_Dist','')
		WHERE [name] =  'ProductStakeLevelGroup'
	END
		
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductStakeLevelGroup')
	BEGIN
		UPDATE RepInfo
		SET active = 0
			,[group] = 1
			,get_sp = REPLACE(get_sp, '_Dist','')
			,put_sp = REPLACE(put_sp, '_Dist','')
		WHERE [name] =  'Dep_ProductStakeLevelGroup'
	END
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SportBettypeSettingMatrix
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix')
BEGIN
	UPDATE RepInfo
	SET active = 0
		,[group] = CASE WHEN DB_NAME() IN ('CustDB') THEN 0 ELSE 1 END	--dbtxn.custdb
			,get_sp = REPLACE(get_sp, '_Dist','')
			,put_sp = REPLACE(put_sp, '_Dist','')
	WHERE [name] =  'SportBettypeSettingMatrix'
END