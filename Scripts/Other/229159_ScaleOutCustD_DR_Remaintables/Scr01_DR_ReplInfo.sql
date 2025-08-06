/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250610@Dave	
	Task: In-House
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250610@Dave: Apply Inhouse replication for remain tables [RedmineID: #229159]	
*/
IF NOT EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'SportBettypeSettingMatrix')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'SportBettypeSettingMatrix',0,'repupdatetime',0,'SportType|BetType|isLicensee|isLive|Site','DR_Repl_GetSportBettypeSettingMatrix_Dist','DR_Repl_PutSportBettypeSettingMatrix_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'SportBettypeSettingMatrix exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'Dep_ProductStakeLevelGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'Dep_ProductStakeLevelGroup',0,'repupdatetime',0,'Sporttype|GameGroupID|LicenseeGroupID|SiteID','DR_Repl_GetDep_ProductStakeLevelGroup_Dist','DR_Repl_PutDep_ProductStakeLevelGroup_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'Dep_ProductStakeLevelGroup exists !!!'
END
GO
/***************************************************************************/

IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'DomainManagement')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'DomainManagement',0,'repupdatetime',0,'DomainID','DR_Repl_GetDomainManagement_Dist','DR_Repl_PutDomainManagement_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'DomainManagement exists !!!'
END
GO
/***************************************************************************/


IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProductStakeLevelGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'ProductStakeLevelGroup',0,'repupdatetime',0,'Sporttype|GameGroupID|CreditGroupID','DR_Repl_GetProductStakeLevelGroup_Dist','DR_Repl_PutProductStakeLevelGroup_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProductStakeLevelGroup exists !!!'
END
GO
/***************************************************************************/
