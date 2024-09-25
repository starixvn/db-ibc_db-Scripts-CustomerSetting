/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240604@Eden
	Task: add rep In-House config  [Redmine: #204358]   
		BetSetting3rd_Agent
		BetSetting3rd_Member
	DB: DBACC-bodb02,DBTP-bodb02
*/
USE bodb02
GO
DECLARE @Group INT = 0

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT @Group,'BetSetting3rd_Agent',0,'RepUpdateTime',0,'CustID|Sporttype|BetType','Repl_GetBetSetting3rd_Agent_Dist','Repl_PutBetSetting3rd_Agent',1000,10,60000 UNION ALL
SELECT @Group,'BetSetting3rd_Member',0,'RepUpdateTime',0,'CustID|Sporttype|BetType','Repl_GetBetSetting3rd_Member_Dist','Repl_PutBetSetting3rd_Member',1000,10,60000

GO
/*
SELECT * FROM RepInfoGroup (NOLOCK)

USE bodb02
GO
DELETE
FROM RepInfo WITH (ROWLOCK, UPDLOCK)
WHERE [name] IN ('BetSetting3rd_Agent','BetSetting3rd_Member')
*/