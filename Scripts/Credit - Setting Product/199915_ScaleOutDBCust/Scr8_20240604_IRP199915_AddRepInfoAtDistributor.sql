/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240604@Johnson
	Task: Scale out dbcust [redmine: #199915]
	DB: DBCustRepl-ReplCustDB
*/ 
DECLARE @Group INT = 0

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size)
SELECT @Group,'BetSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetBetSetting_Agent','Repl_PutBetSetting_Agent_Dist',1000,10,60000,0	
UNION ALL SELECT @Group,'BetSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetBetSetting_Member','Repl_PutBetSetting_Member_Dist',1000,10,60000,0	

/*

SELECT * FROM RepInfoGroup (NOLOCK)

USE ReplCustDB
GO
DELETE
FROM RepInfo WITH (ROWLOCK, UPDLOCK)
WHERE [name] IN ('BetSetting_Agent','BetSetting_Member')
*/
