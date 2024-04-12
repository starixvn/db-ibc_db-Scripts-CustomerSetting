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
	  SELECT   Sporttype
		    , GameGroupID
		    , MinBet
		    , MaxBet
		    , CreditGroupID
		    , Remark
		    , RepUpdateTime
		    , isDeleted
	  FROM ProductStakeLevelGroup p WITH (NOLOCK)
	  WHERE p.Sporttype IN (171,224)

	-- INIT CreditGroupCurrency UUS Currency
	IF NOT EXISTS (SELECT 1 FROM ProductStakeLevelGroup p WITH (NOLOCK) 
				  INNER JOIN #Temp_StakeLevelGroup tslg ON p.Sporttype = tslg.Sporttype AND p.GameGroupID = 1 AND p.CreditGroupID = tslg.CreditGroupID)
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
		    , 1 AS GameGroupID
		    , MinBet
		    , MaxBet
		    , CreditGroupID
		    , Remark
		    , SYSDATETIME ()
		    , isDeleted
		FROM #Temp_StakeLevelGroup tslg
	END

	DROP TABLE #Temp_StakeLevelGroup