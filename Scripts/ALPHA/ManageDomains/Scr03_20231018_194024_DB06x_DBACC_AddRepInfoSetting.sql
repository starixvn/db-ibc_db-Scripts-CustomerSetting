/*<info serverAlias="DBTP-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: Tacy@20231018
	Task: in-house [Redmine:#194024] 
	DB:	DBTP-bodb02,DBACC-bodb02
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size)
SELECT 1,'DomainManagement',1,'repupdatetime',0,'DomainID','Repl_GetDomainManagement','Repl_PutDomainManagement',1000,10,60000,0