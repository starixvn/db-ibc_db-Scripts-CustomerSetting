/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024-05-28
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649]
	DB: DBCust/CustDB 
*/

CREATE TABLE #tmpStakeSMA 
(
    CustID int,
    SportType smallint,
    BetType int,
    StakeLevelList varchar(200)
)

INSERT INTO #tmpStakeSMA 
	(
		CustID
	    , SportType
	    , BetType
	    , StakeLevelList
	)
SELECT 
	  CustID
	, SportType
	, BetType
	, StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) 
WHERE CustID IN (1201561,32899720,37995555,16419740,32659840)




CREATE TABLE #tmpSL (StakeLevelID int)

INSERT INTO #tmpSL (StakeLevelID)
SELECT DISTINCT CAST(ss.value AS INT)
FROM #tmpStakeSMA tem
CROSS APPLY	STRING_SPLIT(ISNULL(tem.StakeLevelList, ''), ',') AS ss


SELECT 'CustStakeLevel_Agent' AS Note , * FROM #tmpStakeSMA
SELECT 'StakeLevelID' AS Note , * FROM #tmpSL
SELECT 'StakeLevel' AS Note , sl.*
FROM StakeLevel sl WITH (NOLOCK)
INNER JOIN #tmpSL t ON sl.StakeLevelID = t.StakeLevelID



DROP TABLE #tmpStakeSMA
DROP TABLE #tmpSL