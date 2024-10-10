/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20241010@Helios
	Task: Scale out DBCUST - Setup InHouse GlobCustDB (CustInfoMini, CustSubMini) [RedmineID: #206823]
	DB: IRS_DBTP-bodb02
*/

USE bodb02
GO
DECLARE @group INT = xxx

IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustInfoMini')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @group,'CustInfoMini',0,'RepUpdateTime',0,'CustId','Repl_GetCustInfoMini','Repl_PutCustInfoMini',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustInfoMini exists !!!'
END
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSubMini')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @group,'CustSubMini',0,'RepUpdateTime',0,'subaccid','Repl_GetCustSubMini','Repl_PutCustSubMini',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustSubMini exists !!!'
END
GO