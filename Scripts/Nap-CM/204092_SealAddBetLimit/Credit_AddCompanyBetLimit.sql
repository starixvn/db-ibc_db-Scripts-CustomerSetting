/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024/04/22
	Created: Helios
	Task: Seal Entertainment - Incorporate Arcade Games For Credit [#204092]
	DB: DBCust/CustDB
*/
CREATE TABLE #Temp_StakeLevelGroup (
		Sporttype		SMALLINT
	    , GameGroupID		TINYINT
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , CreditGroupID	TINYINT
	    PRIMARY KEY (Sporttype , GameGroupID , CreditGroupID)
	)


INSERT INTO #Temp_StakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , CreditGroupID
	)
	 SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  2500 AS MaxBet ,  1 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  7500 AS MaxBet ,  2 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500 AS MaxBet ,  3 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  1750 AS MaxBet ,  5 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  350000 AS MaxBet ,  8 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  10000 AS MaxBet ,  7 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500 AS MaxBet ,  6 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  25000 AS MaxBet ,  9 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500000 AS MaxBet ,  11 AS CreditGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  25000 AS MaxBet ,  12 AS CreditGroupID 


 --SELECT *
 --FROM #Temp_StakeLevelGroup
 IF NOT EXISTS (SELECT 1
		    FROM ProductStakeLevelGroup pslg WITH (NOLOCK)
		    INNER JOIN #Temp_StakeLevelGroup tslg ON pslg.Sporttype = tslg.Sporttype AND pslg.GameGroupID = tslg.GameGroupID AND pslg.CreditGroupID = tslg.CreditGroupID)

BEGIN
	INSERT INTO ProductStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , CreditGroupID
	    , Remark
	    , RepUpdateTime
	    , isDeleted
	)
	SELECT 
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , CreditGroupID
	    , NULL
	    , SYSDATETIME ()
	    , 0
	FROM #Temp_StakeLevelGroup
END


 DROP TABLE #Temp_StakeLevelGroup