/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250916@Johnson	
	Task: Credit - Max Payout Per Match - Change to Max Win [redmine:#236447]
	DB: DBLOG/bodb_CustomerLog
*/

WITH T AS (
	 SELECT 220037 Old_ActionID, 220051 New_ActionID
	UNION ALL SELECT 220038 , 220052
	UNION ALL SELECT 220039 , 220053
	UNION ALL SELECT 220040 , 220054
	UNION ALL SELECT 220041 , 220055
	UNION ALL SELECT 220042 , 220056
	UNION ALL SELECT 220043 , 220057
	UNION ALL SELECT 262000 , 262004
	UNION ALL SELECT 262001 , 262005
	UNION ALL SELECT 262002 , 262006
	UNION ALL SELECT 262003 , 262007
	UNION ALL SELECT 95088 , 95124
	UNION ALL SELECT 95092 , 95125
	UNION ALL SELECT 95095 , 95126
	UNION ALL SELECT 264001 , 264006
	UNION ALL SELECT 264003 , 264007
)
INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT t.[New_ActionID]
		,[ActionTypeID]
		,[SPName]
		,[ActionNameEN]
		,[ActionNameCH]
		,[ActionNameCS]
		,[ActionNameJP]
		,[ActionNameIT]
		,[ActionNameTH]
		,[ActionNameKO]
		,[XsltContent]
		,[IsInternal]
		,[ActionNameVI]
		,[ActionNameCN]
FROM LogAction l WITH(NOLOCK)
	 INNER JOIN T ON l.ActionID = T.Old_ActionID