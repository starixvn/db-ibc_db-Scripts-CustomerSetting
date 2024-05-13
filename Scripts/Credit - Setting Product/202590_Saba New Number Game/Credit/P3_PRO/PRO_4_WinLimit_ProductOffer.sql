/*<info serverAlias="DBTRANS-bodb02"></info>*/
/*
	Created: 2024/04/17 Helios
	Task: SABA xD - Incorporate SABA xD [RM:#202590]
	DB: DBTRANS/bodb02
*/


IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer wp WITH (NOLOCK) WHERE ProductID = 86)
BEGIN
	INSERT INTO WinLimit_ProductOffer 
	(
		ProductID
	    , BetType
	    , IsActive_SMA
	    , IsActive_Company
	)
	SELECT 86 , 4601 , 1 , 1
END
