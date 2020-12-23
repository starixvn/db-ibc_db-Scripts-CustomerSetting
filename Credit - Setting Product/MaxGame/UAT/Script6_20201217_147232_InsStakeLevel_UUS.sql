/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task:  Insert Setting StakeLevel Max Game - UUS [RM:#147232]
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT, ExchangeId int)
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 5401,72	UNION ALL -- YNG
SELECT 5401,20 --UUS

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,19 AS GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp

--select * from StakeLevel where GameTypeID = 5401 and ExchangeId IN (20,72)