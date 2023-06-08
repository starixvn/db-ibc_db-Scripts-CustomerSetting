/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/05/08
	Task: Virtual Game - Change credit bet limit setting [redmine : #187460]
	DB: DBCUST/CustDB
	Revisions: Script Delete StakeLevel Redudant
*/

	-- DEPLOY THIS @DBCUST.CustDB --------
	 SET NOCOUNT ON

	CREATE TABLE #StakeLevel ( RowN SMALLINT , StakeLevelID INT PRIMARY KEY)
	INSERT INTO #StakeLevel 
	SELECT
		CASE 
			WHEN sl.ExchangeId IN (6,78) THEN ROW_NUMBER() OVER(PARTITION BY sl.ExchangeId , sl.GameTypeID ORDER BY sl.GameTypeID , sl.MaxStake ASC)				-- only EUR,EURO (Euro') will be set at the lowest once
			ELSE						 ROW_NUMBER() OVER(PARTITION BY sl.ExchangeId , sl.GameTypeID ORDER BY sl.GameTypeID , sl.MaxStake DESC)					-- all currencies now will be set at the highest level
		END AS RowN ,
		sl.StakeLevelID 
	FROM StakeLevel sl WITH (NOLOCK)
	WHERE sl.GameTypeID IN (4601,4602,4605) 

	
	DELETE s
	FROM StakeLevel s WITH (ROWLOCK)
	WHERE GameTypeID IN (4601,4602,4605)
	AND s.StakeLevelID NOT IN (SELECT DISTINCT StakeLevelID FROM #StakeLevel WHERE RowN = 1)

	DROP TABLE #StakeLevel





