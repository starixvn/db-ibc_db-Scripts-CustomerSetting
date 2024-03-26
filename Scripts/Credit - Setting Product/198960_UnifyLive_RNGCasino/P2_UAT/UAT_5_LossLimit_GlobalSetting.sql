/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial LossLimit_GlobalSetting [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

	IF NOT EXISTS (SELECT TOP 1 1 FROM LossLimit_GlobalSetting WITH (NOLOCK) WHERE ProductId = 53 AND ExchangeId = 20)
	BEGIN
		INSERT INTO LossLimit_GlobalSetting 
		(
			ProductId
		    , ExchangeId
		    , MinLossLimit
		    , DefaultLossLimit
		)
		SELECT 
			53 AS ProductId
		    , ExchangeId
		    , MinLossLimit
		    , DefaultLossLimit
		FROM LossLimit_GlobalSetting WITH (NOLOCK) 
		WHERE ProductId = 18 AND ExchangeId = 20
	END
	