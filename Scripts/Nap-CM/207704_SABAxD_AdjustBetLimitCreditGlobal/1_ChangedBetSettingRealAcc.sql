/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240408@Helios
	Task: SABA xD - Credit Global Bet Limit - Real Acc [#207704]   
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

CREATE TABLE #Temp_StakeLevelGroup (
		Sporttype		SMALLINT	DEFAULT (240)
	    , GameGroupID		TINYINT	DEFAULT (2)
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , CreditGroupID	TINYINT
	    PRIMARY KEY (Sporttype , GameGroupID , CreditGroupID)
	)


INSERT INTO #Temp_StakeLevelGroup 
	(
		MinBet
	    , MaxBet
	    , CreditGroupID
	)
	     SELECT 0.01 AS MinBet ,  5000 AS MaxBet	,  1 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  20000 AS MaxBet	,  2 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  2000 AS MaxBet	,  3 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  5000 AS MaxBet	,  4 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  10000 AS MaxBet	,  5 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  50000 AS MaxBet	,  7 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  700000 AS MaxBet  ,  8 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  25000 AS MaxBet	,  9 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  2000 AS MaxBet	,  10 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  50000 AS MaxBet	,  12 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  2000 AS MaxBet	,  13 AS CreditGroupID  
 UNION ALL SELECT 0.01 AS MinBet ,  2000 AS MaxBet	,  14 AS CreditGroupID  



 IF EXISTS (
		SELECT TOP 1 1
		FROM ProductStakeLevelGroup pg WITH (NOLOCK)
		INNER JOIN #Temp_StakeLevelGroup tslg ON pg.Sporttype = tslg.Sporttype AND pg.GameGroupID = tslg.GameGroupID AND pg.CreditGroupID = tslg.CreditGroupID
		)
 BEGIN
	
	UPDATE pg
		SET 
			pg.MinBet		= tslg.MinBet
		,	pg.MaxBet		= tslg.MaxBet
		,	pg.RepUpdateTime	= SYSDATETIME ()
	FROM ProductStakeLevelGroup pg WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Temp_StakeLevelGroup tslg ON pg.Sporttype = tslg.Sporttype AND pg.GameGroupID = tslg.GameGroupID AND pg.CreditGroupID = tslg.CreditGroupID
 END

 DROP TABLE #Temp_StakeLevelGroup