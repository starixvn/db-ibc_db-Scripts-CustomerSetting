/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Update Data Setting LimitPTDailySetting [#198960]  
	DB: DBCust/CustDB
*/

	IF EXISTS (SELECT 1 FROM LimitPTDailySetting WITH (NOLOCK) WHERE ProductID = 18) 
	BEGIN
		UPDATE lps
			SET lps.ProductID = 53
		FROM LimitPTDailySetting lps WITH (ROWLOCK, UPDLOCK)
		WHERE lps.ProductID = 18
	END