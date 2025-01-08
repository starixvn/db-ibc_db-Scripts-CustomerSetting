/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Add Rep Inhouse config Distributor [Redmine: #209747]   
	DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02
	Table Related:
		ProblemAccount
		ProblemAccountAction
         	ProblemAccountClassification
         	ProblemAccountLimitDownline
         	ProblemAccountReason
*/


DECLARE @Group INT = 14

/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProblemAccount')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @Group,'ProblemAccount',0,'repupdatetime',0,'CustId','Repl_GetProblemAccount','Repl_PutProblemAccount_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProblemAccount exists !!!'
END
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProblemAccountAction')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @Group,'ProblemAccountAction',0,'repupdatetime',0,'ActionID','Repl_GetProblemAccountAction','Repl_PutProblemAccountAction_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProblemAccountAction exists !!!'
END
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProblemAccountClassification')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @Group,'ProblemAccountClassification',0,'repupdatetime',0,'custid','Repl_GetProblemAccountClassification','Repl_PutProblemAccountClassification_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProblemAccountClassification exists !!!'
END
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProblemAccountLimitDownline')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @Group,'ProblemAccountLimitDownline',0,'repupdatetime',0,'custid','Repl_GetProblemAccountLimitDownline','Repl_PutProblemAccountLimitDownline_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProblemAccountLimitDownline exists !!!'
END
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProblemAccountReason')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @Group,'ProblemAccountReason',0,'repupdatetime',0,'ReasonID','Repl_GetProblemAccountReason','Repl_PutProblemAccountReason_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProblemAccountReason exists !!!'
END
/***************************************************************************/

/* 
DELETE ri
FROM RepInfo ri
WHERE ri.[group] = 14
AND ri.name IN ('ProblemAccount' , 'ProblemAccountAction' , 'ProblemAccountClassification', 'ProblemAccountLimitDownline' , 'ProblemAccountReason')
*/