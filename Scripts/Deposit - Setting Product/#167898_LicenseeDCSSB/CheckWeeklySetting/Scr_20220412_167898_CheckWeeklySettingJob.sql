/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Eden@20220412
	Task: Insert new rules, Update vnDBA_CheckSetting_RunningScripts [Redmine:#167898]	
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO

--Update command WHERE [ScriptName] = 'PT Deposit' , check DCS structure only
UPDATE t
SET t.[Command] = '
SET NOCOUNT ON;

DECLARE @CustId INT;

WHILE 0 = 0
BEGIN
	SELECT @CustId = NULL;
	UPDATE TOP(1) dbo.Deposit_Supers
	SET @CustId = CustId
	, PT = 2
	WHERE PT = 0;

	IF @CustId IS NULL BREAK;

	EXECUTE dbo.DBA_CheckPositionTaking_Deposit_DCS  @srecommend = @CustId, @RuleId = 0;
	--EXECUTE dbo.DBA_CheckPositionTaking_DepCustsetting  @srecommend = @CustId, @RuleId = 0;
	--EXECUTE dbo.DBA_CheckPositionTaking_DepCustSetting3rd  @srecommend = @CustId, @RuleId = 0;
	--EXECUTE dbo.DBA_CheckPositionTaking_DepCustSettingGame  @srecommend = @CustId, @RuleId = 0;

	UPDATE dbo.Deposit_Supers
	SET PT = 1
	WHERE CustId = @CustId
	AND PT = 2;
END;

UPDATE	dbo.vnDBA_Service_Variables WITH (ROWLOCK)
SET		VarValue	= ISNULL(CAST(VarValue AS SMALLINT), 0) - 1
WHERE	VarKey = N''~~~'';'
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts] t WITH(ROWLOCK,UPDLOCK)
WHERE [ScriptName] = 'PT Deposit'

--Skip check comm Deposit
DELETE t
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts] t WITH(ROWLOCK,UPDLOCK)
WHERE [ScriptName] IN('Commission Sportbooks Deposit','Commission 3rd Products Deposit','Commission Game Deposit')


--Script Insert Rules
INSERT INTO Rule_Credit(RuleId,RuleName)
SELECT 342,'Max Payout Per Match < 0' UNION ALL
SELECT 343,'Super mppm < Master mppm < Agent mppm' UNION ALL
SELECT 344,'Max Per Match > Max Payout Per Match'

SELECT * FROM Rule_Credit WITH(NOLOCK) WHERE RuleId IN (342,343,344)

/*
SELECT TOP (1000) [ScriptId]
      ,[ScriptName]
      ,[VarKey]
      ,[Threads]
      ,[Command]
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts]
WHERE [ScriptName] like '%Deposit%'

*/