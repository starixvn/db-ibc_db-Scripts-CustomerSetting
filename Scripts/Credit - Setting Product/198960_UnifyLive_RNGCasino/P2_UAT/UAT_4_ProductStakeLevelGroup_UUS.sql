/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial ProductStakeLevelGroup - UUS Currency [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

	-- Add New Setting StakeLevel for Funky Games (224) , Virtual Games (245) , Vgaming (171)

	CREATE TABLE #Temp_StakeLevelGroup (
		Sporttype		SMALLINT
	    , GameGroupID		TINYINT
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , CreditGroupID	TINYINT
	    , Remark		VARCHAR(1000)
	    , RepUpdateTime	DATETIME2(7)
	    , isDeleted		BIT
	    PRIMARY KEY (Sporttype , GameGroupID , CreditGroupID)
	)

	INSERT INTO #Temp_StakeLevelGroup 
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
	--GameGroupID = 1 : Slot Game
	--GameGroupID = 2 : Others only
	     SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  300000 AS MaxBet ,  6 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500 AS MaxBet ,  6 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted 
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  6 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted   

	
	--SELECT 
	--	--e.CreditGroupID , e.currency , 
	--	DISTINCT t.*
	--FROM #Temp t 
	--INNER JOIN [exchange_test] e ON t.CreditGroupID = e.CreditGroupID
	--ORDER BY t.Sporttype

	-- INIT CreditGroupCurrency UUS Currency
	IF EXISTS (SELECT 1 FROM ProductStakeLevelGroup WITH (NOLOCK) WHERE Sporttype IN (171,224,245) AND GameGroupID = 1 AND CreditGroupID = 6)
	BEGIN
		UPDATE  p
		SET 
			P.isDeleted = 1,
			P.RepUpdateTime = SYSDATETIME ()
		FROM ProductStakeLevelGroup p  WITH (NOLOCK) WHERE Sporttype IN (171,224,245) AND GameGroupID = 1 AND CreditGroupID = 6
	END

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
	SELECT Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , CreditGroupID
	    , Remark
	    , RepUpdateTime
	    , isDeleted
	FROM #Temp_StakeLevelGroup tslg

	DROP TABLE #Temp_StakeLevelGroup