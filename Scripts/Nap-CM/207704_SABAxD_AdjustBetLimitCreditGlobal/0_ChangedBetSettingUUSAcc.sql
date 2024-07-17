/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240408@Helios
	Task: SABA xD - Credit Global Bet Limit - UUS [#207704]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

 IF EXISTS (SELECT TOP 1 1 FROM ProductStakeLevelGroup WITH (NOLOCK) WHERE Sporttype = 240 AND GameGroupID = 2 AND CreditGroupID = 6) 
 BEGIN
	UPDATE pg
		SET 
			pg.MinBet		= 0.01
		,	pg.MaxBet		= 700000
		,	pg.RepUpdateTime	= SYSDATETIME ()
	FROM ProductStakeLevelGroup pg WITH (ROWLOCK , UPDLOCK)
	WHERE Sporttype = 240 AND GameGroupID = 2 AND CreditGroupID = 6
 END

