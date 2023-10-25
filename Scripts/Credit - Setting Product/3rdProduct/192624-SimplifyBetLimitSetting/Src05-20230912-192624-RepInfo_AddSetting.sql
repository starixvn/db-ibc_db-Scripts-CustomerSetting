/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20230912@Tacy
	Task: In-House (https://nexdev.net/issues/192624)
	DB: DBACC-bodb02, DBTP-bodb02
	
	Revisions:
		- 20230906@Tacy: 3rd Products - Simplify RNG Games bet limit setting [RedmineID: #192624]
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 1,'ProductStakeLevelGroup',1,'RepUpdateTime',0,'Sporttype|GameGroupID|CreditGroupID','Repl_GetProductStakeLevelGroup','Repl_PutProductStakeLevelGroup',1000,10,60000
UNION
SELECT 1,'Dep_ProductStakeLevelGroup',1,'RepUpdateTime',0,'Sporttype|GameGroupID|LicenseeGroupID|SiteID','Repl_GetDep_ProductStakeLevelGroup','Repl_PutDep_ProductStakeLevelGroup',1000,10,60000
GO