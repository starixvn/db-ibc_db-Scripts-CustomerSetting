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
	     SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  5000 AS MaxBet ,  1 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  20000 AS MaxBet ,  2 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  5000 AS MaxBet ,  5 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  5000 AS MaxBet ,  4 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  2.5 AS MinBet ,  300000 AS MaxBet ,  8 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  5000 AS MaxBet ,  10 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  20000 AS MaxBet ,  7 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  300000 AS MaxBet ,  6 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  25000 AS MaxBet ,  9 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  50000 AS MaxBet ,  12 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  2500 AS MaxBet ,  18 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  20000 AS MaxBet ,  19 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  2500 AS MaxBet ,  17 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 171 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  5000 AS MaxBet ,  23 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  2500 AS MaxBet ,  1 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  8000 AS MaxBet ,  2 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500 AS MaxBet ,  3 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  2000 AS MaxBet ,  5 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  2500 AS MaxBet ,  4 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  350000 AS MaxBet ,  8 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500 AS MaxBet ,  10 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  20000 AS MaxBet ,  7 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500 AS MaxBet ,  6 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  6500 AS MaxBet ,  9 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  0.1 AS MinBet ,  500000 AS MaxBet ,  11 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 224 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  25000 AS MaxBet ,  12 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  5 AS MinBet ,  2000 AS MaxBet ,  1 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  10 AS MinBet ,  15000 AS MaxBet ,  2 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  3 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  5 AS MinBet ,  3000 AS MaxBet ,  5 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  5 AS MinBet ,  3000 AS MaxBet ,  4 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1000 AS MinBet ,  500000 AS MaxBet ,  8 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  10 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  25 AS MinBet ,  30000 AS MaxBet ,  7 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  6 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  10 AS MinBet ,  10000 AS MaxBet ,  9 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  11 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  50 AS MinBet ,  20000 AS MaxBet ,  12 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  10 AS MinBet ,  3000 AS MaxBet ,  15 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  5 AS MinBet ,  2000 AS MaxBet ,  20 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  10 AS MinBet ,  3000 AS MaxBet ,  21 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  10 AS MinBet ,  3000 AS MaxBet ,  22 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  10 AS MinBet ,  3000 AS MaxBet ,  16 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  14 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  18 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  23 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  25 AS MinBet ,  30000 AS MaxBet ,  19 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  2000 AS MaxBet ,  13 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    
 UNION ALL SELECT 245 AS Sporttype ,  2 AS GameGroupID ,  1 AS MinBet ,  500 AS MaxBet ,  17 AS CreditGroupID ,  NULL AS Remark ,  SYSDATETIME() AS RepUpdateTime ,  0 AS isDeleted    

	-- REMOVE CreditGroupCurrency UUS Currency
	DELETE FROM #Temp_StakeLevelGroup WHERE CreditGroupID = 6

	--SELECT 
	--	--e.CreditGroupID , e.currency , 
	--	DISTINCT t.*
	--FROM #Temp t 
	--INNER JOIN [exchange_test] e ON t.CreditGroupID = e.CreditGroupID
	--ORDER BY t.Sporttype

	-- Update CreditGroupCurrency REAL Currency
	IF EXISTS (SELECT 1 FROM ProductStakeLevelGroup ps WITH (NOLOCK) 
				  INNER JOIN #Temp_StakeLevelGroup tslg ON ps.Sporttype = tslg.Sporttype AND ps.GameGroupID = tslg.GameGroupID AND ps.CreditGroupID = tslg.CreditGroupID)
	BEGIN
		UPDATE ps 
			SET
				ps.MinBet = tslg.MinBet
			,	ps.MaxBet = tslg.MaxBet
			,	ps.RepUpdateTime = SYSDATETIME ()
		FROM ProductStakeLevelGroup ps WITH (NOLOCK) 
		INNER JOIN #Temp_StakeLevelGroup tslg ON ps.Sporttype = tslg.Sporttype AND ps.GameGroupID = tslg.GameGroupID AND ps.CreditGroupID = tslg.CreditGroupID
	END

	DROP TABLE #Temp_StakeLevelGroup