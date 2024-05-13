/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240321@Helios
	Task: Incorporate Saba New Number Game - Init for UUS - Credit [#202590]  
		https://nexdev.net/issues/202590
	DB: DBCust/CustDB
*/
	
		
	IF NOT EXISTS (SELECT 1 FROM ProductStakeLevelGroup WITH (NOLOCK) WHERE Sporttype = 240)
	BEGIN
		INSERT INTO ProductStakeLevelGroup 
		(
			Sporttype
		    , GameGroupID
		    , MinBet
		    , MaxBet
		    , CreditGroupID
		)
		SELECT 240 , 2 , 0.01 , 300000 , 6 

	END
