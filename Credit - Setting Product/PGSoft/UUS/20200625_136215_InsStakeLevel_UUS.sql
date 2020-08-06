/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Insert Setting StakeLevel [PG Game] - UUS RedmineID:#137763
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								ResourceId varchar(10) default('13'), 
								GameGroupID int default(15))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 6001,72				   -- YNG

INSERT INTO StakeLevel(GameTypeID,ExchangeId,ResourceId,GameGroupID)
SELECT GameTypeID,ExchangeId,ResourceId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp