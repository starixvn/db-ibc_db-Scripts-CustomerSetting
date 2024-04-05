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
							WHEN currency = 'AUD'		THEN 13 
							WHEN currency = 'CHF'		THEN 14 
							WHEN currency = 'CY'		THEN 15 
							WHEN currency = 'DKK'		THEN 16 
							WHEN currency = 'EURO'		THEN 17 
							WHEN currency = 'GBP'		THEN 18 
							WHEN currency = 'INR1'		THEN 19 
							WHEN currency = 'KHR'		THEN 20 
							WHEN currency = 'NOK'		THEN 21 
							WHEN currency = 'SEK'		THEN 22 
							WHEN currency = 'USTM'		THEN 23 
						END,
			ex.RepUpdateTime = SYSDATETIME ()
	FROM
		exchange ex WITH (ROWLOCK , UPDLOCK)
	WHERE
		currency IN ('AUD' , 'CHF' , 'CY' , 'DKK' , 'EURO' , 'GBP' , 'INR1' , 'KHR' , 'NOK' , 'SEK' , 'USTM')