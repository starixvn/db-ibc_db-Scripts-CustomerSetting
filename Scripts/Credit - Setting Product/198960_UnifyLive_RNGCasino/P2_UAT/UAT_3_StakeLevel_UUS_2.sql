/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - RESET resourceid UUS Currency [#198960]
		https://nexdev.net/issues/198960
	DB: DBCust/CustDB  
*/

	-- RESET resourceid of UUS Currency
	UPDATE sl 
		SET sl.resourceid = NULL
	--SELECT *
	FROM StakeLevel sl WITH (ROWLOCK , UPDLOCK)
	WHERE sl.GameTypeID IN (1611,2101)
	AND sl.ExchangeId = 20 -- UUS