/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240617
	Task: Clean bet limit  [Redmine:#206515] 
	DB:	DBCUST-CustDB

	Revision:
		- 20240621@Tacy: Run on SIT
*/
USE CustDB
GO
----------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
--Delete setting:
CREATE TABLE #DEL_StakeLevelGroup (
		Sporttype		SMALLINT
	    , GameGroupID	TINYINT
	    , CreditGroupID	TINYINT
	    PRIMARY KEY (Sporttype , GameGroupID , CreditGroupID)
	)

INSERT INTO #DEL_StakeLevelGroup(Sporttype, GameGroupID, CreditGroupID)
	  SELECT 212,	1,	12
UNION SELECT 212,	2,	12
UNION SELECT 158,	1,	10
UNION SELECT 158,	2,	10
UNION SELECT 171,	1,	9
UNION SELECT 171,	2,	9
UNION SELECT 234,	1,	9
UNION SELECT 232,	1,	1
UNION SELECT 232,	1,	4
UNION SELECT 232,	1,	8
UNION SELECT 232,	1,	7

UPDATE p 
SET p.isDeleted=1, p.RepUpdateTime=SYSDATETIME()
FROM ProductStakeLevelGroup p WITH (ROWLOCK)
INNER JOIN #DEL_StakeLevelGroup t
		ON t.Sporttype=p.Sporttype
		AND t.GameGroupID=p.GameGroupID
		AND t.CreditGroupID=p.CreditGroupID
GO
