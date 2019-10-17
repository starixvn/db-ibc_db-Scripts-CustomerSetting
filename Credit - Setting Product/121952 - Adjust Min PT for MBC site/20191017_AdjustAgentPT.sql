/*
	Created: 20191017@Elodie
	Task: Update AgentPT of SB
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE cs
SET cs.apositiontaking = 0,
	cs.alivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN 0 ELSE cs.alivepositiontaking END
FROM dbo.CustSetting cs WITH (ROWLOCK)
WHERE cs.CustID IN (
1937408 -- 6666AHK
)
	


