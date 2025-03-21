/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250211@Tacy
	Task: Scale Out DBCUST - Setup InHouse replication on Dist
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250211@Tacy: Created [RedmineID: #216870]
*/
USE ReplCustDB
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 2,'ProductStakeLevelGroup',0,'RepUpdateTime',0,'Sporttype|GameGroupID|CreditGroupID','Repl_GetProductStakeLevelGroup','Repl_PutProductStakeLevelGroup_Dist',1000,10,60000
UNION
SELECT 2,'Dep_ProductStakeLevelGroup',0,'RepUpdateTime',0,'Sporttype|GameGroupID|LicenseeGroupID|SiteID','Repl_GetDep_ProductStakeLevelGroup','Repl_PutDep_ProductStakeLevelGroup_Dist',1000,10,60000
UNION
SELECT 2,'DomainManagement',0,'RepUpdateTime',0,'DomainID','Repl_GetDomainManagement','Repl_PutDomainManagement_Dist',1000,10,60000
UNION
SELECT 2,'SportBettypeSettingMatrix',0,'RepUpdateTime',0,'sporttype|bettype|islicensee|islive|site','Repl_GetSportBettypeSettingMatrix','Repl_PutSportBettypeSettingMatrix_Dist',1000,10,60000
GO