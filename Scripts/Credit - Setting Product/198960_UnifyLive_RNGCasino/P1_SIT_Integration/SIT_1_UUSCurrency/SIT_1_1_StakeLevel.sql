/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial StakeLevel - UUS Currency [#198960]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

	CREATE TABLE #Temp_SL 
	(
		[StakeLevelID] [int] ,
		[GameTypeID] [int] ,
		[MinLabel] [nvarchar](50) ,
		[MaxLabel] [nvarchar](50) ,
		[MinStake] [decimal](19, 8) ,
		[MaxStake] [decimal](19, 8) 
	)

	INSERT INTO #Temp_SL 
	(
		StakeLevelID
	    , GameTypeID
	    , MinLabel
	    , MaxLabel
	    , MinStake
	    , MaxStake
	)
	SELECT slgd1.StakeLevelID , slgd1.GameTypeID , slgd1.MinLabel , slgd1.MaxLabel , slgd1.MinStake , slgd1.MaxStake 
	FROM GameGroup gg WITH (NOLOCK)
	INNER JOIN StakeLevel sl WITH (NOLOCK) ON gg.GameGroupID = sl.GameGroupID AND gg.RefBetType =  sl.GameTypeID
	INNER JOIN StakeLevelGroupDetail slgd1 WITH (NOLOCK) ON sl.StakeLevelID = slgd1.StakeLevelID AND sl.GameTypeID = slgd1.GameTypeID
	WHERE gg.RefSportType IN (200,208)
	AND gg.RefBetType IN (1611,2101)
	-- 200 : SABA.games   ,  208 : Saba Casino - RNG Game

	--SELECT ts.* , '-' , sl.* 
	--FROM #Temp_SL ts
	--INNER JOIN StakeLevel sl WITH (ROWLOCK , UPDLOCK) ON ts.StakeLevelID = sl.StakeLevelID AND ts.GameTypeID = sl.GameTypeID

	UPDATE sl
		SET 
			sl.MinLabel = ts.MinLabel
		,	sl.MaxLabel = ts.MaxLabel
		,	sl.MinStake = ts.MinStake
		,	sl.MaxStake = ts.MaxStake
	FROM #Temp_SL ts	
	INNER JOIN StakeLevel sl WITH (ROWLOCK , UPDLOCK) ON ts.StakeLevelID = sl.StakeLevelID AND ts.GameTypeID = sl.GameTypeID

	DROP TABLE #Temp_SL