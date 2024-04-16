/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial StakeLevel FGG, SABA.games, Saba Casino for UUS Currency [#198960]
		https://nexdev.net/issues/198960
	DB: DBCust/CustDB  
*/

	
	CREATE TABLE #Temp_StakeLevel
	(
		StakeLevelID		INT,
		GameTypeID			INT,
		MinLabel			NVARCHAR(50),
		MaxLabel			NVARCHAR(50),
		MinStake			DECIMAL(19,8),
		MaxStake			DECIMAL(19,8),
		ExchangeID			INT,
		ResourceID			VARCHAR(20),
		GameGroupID			INT
	)
	

	INSERT INTO #Temp_StakeLevel  
	(
		--StakeLevelID
	      GameTypeID
	    , MinLabel
	    , MaxLabel
	    , MinStake
	    , MaxStake
	    , ExchangeID
	    , ResourceID
	    , GameGroupID
	)


		SELECT 8201  AS GameTypeID  ,  '35'  AS MinLabel  , '3,500'  AS MaxLabel  , 35  AS MinStake  , 3500  AS MaxStake  , 20  AS ExchangedID  , 'Level 1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '350'  AS MinLabel  , '17,500'  AS MaxLabel  , 350  AS MinStake  , 17500  AS MaxStake  , 20  AS ExchangedID  , 'Level 2'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '700'  AS MinLabel  , '35,000'  AS MaxLabel  , 700  AS MinStake  , 35000  AS MaxStake  , 20  AS ExchangedID  , 'Level 3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,000'  AS MaxLabel  , 0.1  AS MinStake  , 3000  AS MaxStake  , 20  AS ExchangedID  , 'Level 1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '50,000'  AS MaxLabel  , 0.1  AS MinStake  , 50000  AS MaxStake  , 20  AS ExchangedID  , 'Level 2'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 20  AS ExchangedID  , 'Level 1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 20  AS ExchangedID  , 'Level 2'  AS ResourceId , 0 AS GameGroupID 



	-- Check Data --

	--SELECT tem_sl.* , '________' AS '________' , sl.* , '________' AS '________' , gg.*
	--FROM #Temp_StakeLevel tem_sl
	--INNER JOIN StakeLevel sl WITH (NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId
	--INNER JOIN GameGroup gg WITH (NOLOCK) ON sl.GameGroupID = gg.GameGroupID AND sl.GameTypeID = gg.RefBetType 
	--AND tem_sl.ResourceID = gg.GroupName
	--WHERE 
	--gg.IsDeposit = 0
	--AND
	--sl.GameTypeID <> 8201


	--SELECT * 
	--FROM #Temp_StakeLevel tem_sl
	--INNER JOIN StakeLevel sl ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId AND CASE WHEN tem_sl.ResourceId = 'Level 1' THEN '1' WHEN tem_sl.ResourceId = 'Level 2' THEN '7' ELSE '5' END = sl.ResourceId
	--WHERE sl.GameTypeID = 8201

	 --End Check Data --

	-- Update  data StakeLevelID Temp Table --

	UPDATE tem_sl
		SET tem_sl.StakeLevelID = sl.StakeLevelID
	FROM #Temp_StakeLevel tem_sl
	INNER JOIN StakeLevel sl WITH (NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId
	INNER JOIN GameGroup gg WITH (NOLOCK) ON sl.GameGroupID = gg.GameGroupID AND sl.GameTypeID = gg.RefBetType AND  tem_sl.ResourceId = gg.GroupName
	WHERE 
	gg.IsDeposit = 0
	AND
	sl.GameTypeID <> 8201

	UPDATE tem_sl
		SET tem_sl.StakeLevelID = sl.StakeLevelID
	FROM #Temp_StakeLevel tem_sl
	INNER JOIN StakeLevel sl WITH(NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId AND CASE WHEN tem_sl.ResourceId = 'Level 1' THEN '1' WHEN tem_sl.ResourceId = 'Level 2' THEN '7' ELSE '5' END = sl.ResourceId
	WHERE sl.GameTypeID = 8201

	-- END Update  data StakeLevelID Temp Table --

	-- Check data Temp Table

	--SELECT tem_sl.* , '________' AS '________' , sl.*
	--FROM #Temp_StakeLevel tem_sl
	--INNER JOIN StakeLevel sl ON tem_sl.StakeLevelID = sl.StakeLevelID AND tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId


	-- Update StakeLevel Real Table

	UPDATE sl
		SET 
			sl.MinLabel = tem_sl.MinLabel ,
			sl.MaxLabel = tem_sl.MaxLabel ,
			sl.MinStake = tem_sl.MinStake ,
			sl.MaxStake = tem_sl.MaxStake 
	FROM #Temp_StakeLevel tem_sl
	INNER JOIN StakeLevel sl WITH (ROWLOCK , UPDLOCK) ON tem_sl.StakeLevelID = sl.StakeLevelID AND tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId
	

	DROP TABLE #Temp_StakeLevel


	