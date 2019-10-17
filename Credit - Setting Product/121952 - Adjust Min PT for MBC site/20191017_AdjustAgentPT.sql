/*
	Created: 20191017@Elodie
	Task: Update AgentPT of SB
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #CustList (CustID INT, RoleId TINYINT, NewPT SMALLMONEY)

INSERT INTO #CustList(CustID, RoleId, NewPT)
SELECT 1937408, 2, 0 -- 6666AHK

UPDATE cs
SET cs.apositiontaking = NewPT,
	cs.alivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN NewPT ELSE cs.alivepositiontaking END
FROM dbo.CustSetting cs WITH (ROWLOCK)
	INNER JOIN #CustList t ON t.CustID = cs.custid
WHERE t.RoleId = 2

	


