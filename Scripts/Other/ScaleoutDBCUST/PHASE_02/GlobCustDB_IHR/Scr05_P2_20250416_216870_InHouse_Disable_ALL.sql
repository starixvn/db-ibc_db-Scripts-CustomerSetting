/*<info serverAlias="DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Disable In-house on ALL servers
	DB: DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02
	
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
	SET active = 0
		,[group] = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN 11 ELSE 14 END
		,get_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN get_sp ELSE get_sp + '_Dist' END
		,put_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN put_sp + '_Dist' ELSE put_sp END
	WHERE [name] =  'DomainManagement'
END
		
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStakeLevelGroup')
BEGIN
	UPDATE RepInfo
	SET active = 0
		,[group] = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN 11 ELSE 12 END
		,get_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN get_sp ELSE get_sp + '_Dist' END
		,put_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN put_sp + '_Dist' ELSE put_sp END
	WHERE [name] =  'ProductStakeLevelGroup'
END
		
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductStakeLevelGroup')
BEGIN
	UPDATE RepInfo
	SET active = 0
		,[group] = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN 11 ELSE 12 END
		,get_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN get_sp ELSE get_sp + '_Dist' END
		,put_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN put_sp + '_Dist' ELSE put_sp END
	WHERE [name] =  'Dep_ProductStakeLevelGroup'
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SportBettypeSettingMatrix
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix')
BEGIN
	UPDATE RepInfo
	SET active = 0
		,[group] = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN 11 ELSE 12 END
		,get_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN get_sp ELSE get_sp + '_Dist' END
		,put_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN put_sp + '_Dist' ELSE put_sp END
	WHERE [name] =  'SportBettypeSettingMatrix'
END