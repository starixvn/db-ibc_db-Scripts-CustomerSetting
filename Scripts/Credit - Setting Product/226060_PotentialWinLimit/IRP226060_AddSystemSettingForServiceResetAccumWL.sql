/*<info serverAlias="DBBAH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250602@Johnson	
	Task: Add system setting for job reset accum winloss daily [redmine:#226060]
	DB: DBBAH-bodb02
*/

/*
INSERT INTO [dbo].[SystemSettings]
           ([VName]
           ,[VValue])
SELECT 'ResetPotentialWinLimitJob_Config','{"DefaultTime":"00:05","IsActive":true,"ManualTime":null}'
UNION SELECT 'ResetPotentialWinLimitJob_Status','{"RunningDate":null,"LastMaxCustID":0,"CompletedTime":null}'

UPDATE SystemSettings WITH (ROWLOCK)
SET VValue = '{"DefaultTime":"00:01","IsActive":true,"ManualTime":null}'
WHERE VName = 'ResetPotentialWinLimitJob_Config';
*/

UPDATE SystemSettings WITH (ROWLOCK)
SET VValue = '{"RunningDate":null,"LastMaxCustID":0,"CompletedTime":null}'
WHERE VName = 'ResetPotentialWinLimitJob_Status';