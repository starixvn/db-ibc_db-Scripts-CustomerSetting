/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial ProductStakeLevelGroup - Real Currency [#198960] 
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
	
	--GameGroupID = 2 : Others only of Funky Games (224) , Virtual Games (245) , Vgaming (171)
	     SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 300000 AS MaxBet , 6 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 1 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 20000 AS MaxBet , 2 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 5 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 4 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 2.5 AS MinBet , 300000 AS MaxBet , 8 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 10 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 20000 AS MaxBet , 7 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 25000 AS MaxBet , 9 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 50000 AS MaxBet , 12 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 2500 AS MaxBet , 13 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  2 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 14 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 2500 AS MaxBet , 1 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 8000 AS MaxBet , 2 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 500 AS MaxBet , 3 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 2000 AS MaxBet , 5 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 2500 AS MaxBet , 4 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 350000 AS MaxBet , 8 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 500 AS MaxBet , 10 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 20000 AS MaxBet , 7 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 6500 AS MaxBet , 9 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 500000 AS MaxBet , 11 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 25000 AS MaxBet , 12 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  2 AS GameGroupID , 0.1 AS MinBet , 500 AS MaxBet , 6 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 5 AS MinBet , 2000 AS MaxBet , 1 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 10 AS MinBet , 15000 AS MaxBet , 2 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 2000 AS MaxBet , 3 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 5 AS MinBet , 3000 AS MaxBet , 5 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 5 AS MinBet , 3000 AS MaxBet , 4 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1000 AS MinBet , 500000 AS MaxBet , 8 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 2000 AS MaxBet , 10 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 25 AS MinBet , 30000 AS MaxBet , 7 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 10 AS MinBet , 10000 AS MaxBet , 9 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 2000 AS MaxBet , 11 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 50 AS MinBet , 20000 AS MaxBet , 12 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 2000 AS MaxBet , 14 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 500 AS MaxBet , 13 AS CreditGroupID 
 UNION ALL SELECT 245 AS SportType ,  2 AS GameGroupID , 1 AS MinBet , 2000 AS MaxBet , 6 AS CreditGroupID 

	--GameGroupID = 1 : Slot Game of Funky Games (224) , Vgaming (171)
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 300000 AS MaxBet , 6 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 1 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 20000 AS MaxBet , 2 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 5 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 4 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 2.5 AS MinBet , 300000 AS MaxBet , 8 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 10 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 20000 AS MaxBet , 7 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 25000 AS MaxBet , 9 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 50000 AS MaxBet , 12 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 2500 AS MaxBet , 13 AS CreditGroupID 
 UNION ALL SELECT 171 AS SportType ,  1 AS GameGroupID , 0.01 AS MinBet , 5000 AS MaxBet , 14 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 2500 AS MaxBet , 1 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 8000 AS MaxBet , 2 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 500 AS MaxBet , 3 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 2000 AS MaxBet , 5 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 2500 AS MaxBet , 4 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 350000 AS MaxBet , 8 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 500 AS MaxBet , 10 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 20000 AS MaxBet , 7 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 6500 AS MaxBet , 9 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 500000 AS MaxBet , 11 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 1 AS MinBet , 25000 AS MaxBet , 12 AS CreditGroupID 
 UNION ALL SELECT 224 AS SportType ,  1 AS GameGroupID , 0.1 AS MinBet , 500 AS MaxBet , 6 AS CreditGroupID 


	-- REMOVE CreditGroupCurrency UUS Currency
	DELETE FROM #Temp_StakeLevelGroup WHERE CreditGroupID = 6

	-- REMOVE CreditGroupCurrency INH Currency OF VGAMING
	DELETE FROM #Temp_StakeLevelGroup WHERE SportType = 171 AND CreditGroupID = 9

	-- Check Data
	--SELECT 
	--	--e.CreditGroupID , e.currency , 
	--	DISTINCT t.*
	--FROM #Temp_StakeLevelGroup t 
	--INNER JOIN [exchange_test] e ON t.CreditGroupID = e.CreditGroupID
	--ORDER BY t.Sporttype

	-- INS CreditGroupCurrency REAL Currency
	IF NOT EXISTS (SELECT 1 FROM ProductStakeLevelGroup p WITH (NOLOCK) 
					INNER JOIN #Temp_StakeLevelGroup tslg ON p.SportType = tslg.Sporttype AND p.GameGroupID = tslg.GameGroupID AND p.CreditGroupID = tslg.CreditGroupID)
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
		SELECT Sporttype
			, GameGroupID
			, MinBet
			, MaxBet
			, CreditGroupID
			, NULL
			, SYSDATETIME ()
			, 0
		FROM #Temp_StakeLevelGroup t
	END

	DROP TABLE #Temp_StakeLevelGroup