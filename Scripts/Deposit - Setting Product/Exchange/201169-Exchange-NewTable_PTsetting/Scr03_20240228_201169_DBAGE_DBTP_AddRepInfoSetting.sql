/*<info serverAlias="DBTP-bodb02, DBAGE-bodb02"></info>*/
/*
	Created by: Tacy@20240228
	Task: in-house -[Dep_ChargeInfoSetting] [Redmine:#200454] 
	DB:	DBTP-bodb02, DBAGE-bodb02
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size)
SELECT 1,'Dep_ChargeInfoSetting',1,'repupdatetime',0,'ChargeId','Repl_GetDep_ChargeInfoSetting','Repl_PutDep_ChargeInfoSetting',1000,10,60000,0
GO