/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240604@Johnson
	Task: Scale out dbcust [redmine: #199915]
	DB: DBACC-bodb02,DBTP-bodb02
*/ 
DECLARE @Group INT = 0

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size)
SELECT @Group,'BetSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetBetSetting_Agent_Dist','Repl_PutBetSetting_Agent',1000,10,60000,0	
UNION ALL SELECT @Group,'BetSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetBetSetting_Member_Dist','Repl_PutBetSetting_Member',1000,10,60000,0	


/*
USE bodb02
GO

DELETE
FROM RepInfo WITH (ROWLOCK, UPDLOCK)
WHERE [name] IN ('BetSetting_Agent','BetSetting_Member')
*/