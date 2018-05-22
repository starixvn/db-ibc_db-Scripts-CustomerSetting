/*
	Creator: 20180522@Elodie
	Task: Insert PT group of Allbet for Lucky88INH01
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @AgentID INT = 26192662

INSERT INTO [dbo].[Dep_CustPTGroupSetting_Member]
	([AgentID]
	,[SportType]
	,[BetType]
	,[IsLive]
	,[SuperPT]
	,[MasterPT]
	,[AgentPT]
	)
SELECT @AgentID,acs.SportType,acs.BetType,acs.IsLive,
		0,0,acs.AgentPT
FROM dbo.Dep_CustPTSetting_Agent acs WITH (NOLOCK)
WHERE acs.custid = @AgentID
	AND NOT EXISTS (SELECT TOP 1 1 FROM dbo.Dep_CustPTGroupSetting_Member WITH (NOLOCK) WHERE AgentID = @AgentID AND SportType = acs.SportType AND BetType = acs.BetType)