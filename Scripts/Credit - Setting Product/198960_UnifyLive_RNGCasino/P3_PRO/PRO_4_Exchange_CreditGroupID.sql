/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial exchange.CreditGroupID - Real Currency [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

-- Update New CreditGroupID

	UPDATE ex
		SET 
			ex.CreditGroupID = CASE 
							WHEN currency = 'EURO'		THEN 13 
							WHEN currency = 'USTM'		THEN 14
						END,
			ex.RepUpdateTime = SYSDATETIME ()
	FROM
		exchange ex WITH (ROWLOCK , UPDLOCK)
	WHERE
		currency IN ('EURO' , 'USTM')