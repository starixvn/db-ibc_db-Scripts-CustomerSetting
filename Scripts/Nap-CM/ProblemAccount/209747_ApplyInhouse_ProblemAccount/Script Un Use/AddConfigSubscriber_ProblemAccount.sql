/*<info serverAlias="IRS_DBG-bodb02"></info>*/
/*
	Created: Helios
	Date: 9/9/2024
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Add Rep Inhouse config Subscriber [Redmine: #209747]   
	DB: IRS_DBG-bodb02
	Table: ProblemAccount
*/


/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'ProblemAccount')
BEGIN
	DECLARE @Group INT = 14


	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @Group,'ProblemAccount',0,'repupdatetime',0,'CustId','Repl_GetProblemAccount_Dist','Repl_PutProblemAccount',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'ProblemAccount exists !!!'
END
GO