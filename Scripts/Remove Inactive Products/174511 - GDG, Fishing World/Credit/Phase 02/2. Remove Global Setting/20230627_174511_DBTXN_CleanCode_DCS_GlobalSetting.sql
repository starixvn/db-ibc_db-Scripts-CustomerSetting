/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Tacy@20230627
	Task: Credit - Delete global settings for GDG, Fishing World, GD, ColosusBet
		https://nexdev.net/issues/174511
		https://nexdev.net/issues/179132
	DB: DBTXN/bodb02
*/ 
------------------------------CREDIT----------------------------------------------------------------
--> WinLimit_ProductOffer
DELETE a
FROM WinLimit_ProductOffer a WITH(ROWLOCK) 
WHERE ProductId in (59,24,12,15) --GDG, FW, GD, CB