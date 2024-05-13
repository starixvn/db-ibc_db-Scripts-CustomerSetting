/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240408@Helios
	Task: SABA xD - Incorporate SABA xD - Initial ProductStakeLevelGroup - REAL Currency [#202590]  
		https://nexdev.net/issues/202590
	DB: DBCust/CustDB
*/


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
	     SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.01 AS MinBet  , 5000 AS MaxBet  , 1 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.1 AS MinBet  , 20000 AS MaxBet  , 2 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.1 AS MinBet  , 5000 AS MaxBet  , 3 AS CreditGroupID  , 'offered for 789y only' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.01 AS MinBet  , 5000 AS MaxBet  , 4 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.01 AS MinBet  , 5000 AS MaxBet  , 5 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.1 AS MinBet  , 20000 AS MaxBet  , 7 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 2.5 AS MinBet  , 300000 AS MaxBet  , 8 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.1 AS MinBet  , 25000 AS MaxBet  , 9 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.01 AS MinBet  , 5000 AS MaxBet  , 10 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.1 AS MinBet  , 50000 AS MaxBet  , 12 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.01 AS MinBet  , 2500 AS MaxBet  , 13 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 
 UNION ALL SELECT 240 AS Sporttype , 2 AS GameGroupID  , 0.01 AS MinBet  , 5000 AS MaxBet  , 14 AS CreditGroupID  , '' AS Remark  , SYSDATETIME () AS RepUpdateTime , 0 AS isDeleted 


	--SELECT 
	--	--e.CreditGroupID , e.currency , 
	--	DISTINCT t.* , e.currency
	--FROM #Temp_StakeLevelGroup t 
	--INNER JOIN [exchange] e ON t.CreditGroupID = e.CreditGroupID
	--ORDER BY t.Sporttype

	-- INS CreditGroupCurrency REAL Currency
	IF NOT EXISTS (SELECT 1 FROM ProductStakeLevelGroup ps WITH (NOLOCK)
				INNER JOIN #Temp_StakeLevelGroup temp ON ps.Sporttype = temp.Sporttype AND ps.GameGroupID = temp.GameGroupID AND ps.CreditGroupID = temp.CreditGroupID)
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
		    , Remark
		    , RepUpdateTime
		    , isDeleted
		FROM #Temp_StakeLevelGroup t
	END

	DROP TABLE #Temp_StakeLevelGroup