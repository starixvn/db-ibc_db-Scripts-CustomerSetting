/*
	Created by: Elodie
	Date: 20200115
	Task: Adjust wrong MinPT for CN88
	DB: DBCUST/CustDB	
*/
USE CustDB
GO

DECLARE @AgentPT_New TINYINT = 15
DECLARE @AgentPT_XML XML

SET @AgentPT_XML =(
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											@AgentPT_New	AS '@val'
									FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
									WHERE bs.Type = 'PTSetting'
										AND bs.SportType = 1 AND bs.BetType = 1 AND bs.IsLive = 0
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)	

SELECT @AgentPT_XML

------------------UPDATE-------------------------------------------------------------------
--Update a2 of Agent
UPDATE cs
SET cs.AgentPT = apt.binaryStr_new,
	cs.AgentPT2 = apt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	CROSS APPLY dbo.f_SetBinaryValues(cs.AgentPT, @AgentPT_XML) apt
WHERE cs.CustId = 41159363

--Update a1 of Member
UPDATE cs
SET cs.AgentPT = apt.binaryStr_new,
	cs.AgentPT2 = apt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	CROSS APPLY dbo.f_SetBinaryValues(cs.AgentPT, @AgentPT_XML) apt
WHERE cs.AgentId = 41159363
